const puppeteer = require('puppeteer');
const fs = require('fs');
const cliArgs = process.argv.slice(2);
const chapterUrl = cliArgs[0];
const chapterRange = parseInt(cliArgs[1]);
const regExMangaUrl = new RegExp('(^.*)(?<=Manga\/.*\/)', 'g');
const regExMangaName = new RegExp('(?<=Manga\/)(.*?)(?=\/)', 'g');
const mangaUrl = regExMangaUrl.exec(chapterUrl)[0]; 
const mangaName = regExMangaName.exec(chapterUrl)[0];
const regExChapterName = new RegExp('(?<=' + mangaName + '\/)(.*?)(?=\\?)');

(async () => {
	const browser = await puppeteer.launch({args: ['--no-sandbox', '--disable-setuid-sandbox'], headless: false});
	const page = await browser.newPage();
	await page.goto(mangaUrl);
	await page.waitForSelector('table.listing');
	const chapterList = await page.evaluate(() => [...document.querySelectorAll('table.listing > tbody > tr > td > a')].reverse().map(element => element.getAttribute('href')));
	for(var i = 0; i < chapterList.length; i++){
		chapterList[i] = 'https://kissmanga.com' + chapterList[i];
	};

	var chapterIndex = chapterList.indexOf(chapterUrl);
	var chaptersToDownload = chapterList.slice(chapterIndex, chapterIndex + chapterRange);
	console.log('The chapter\'s index is ' + chapterIndex);
	console.log('We will download the following chapters: ' + '\n', chaptersToDownload);
	for(var i = 0; i < chaptersToDownload.length; i++){
		console.log('The current chapter\'s link is: ' + chaptersToDownload[i]);
		chapterName = regExChapterName.exec(chaptersToDownload[i])[0] + '_' + mangaName;
		console.log('The current chapter\'s name is: ' + chapterName);
		// const page = await browser.newPage();
		await page.goto(chaptersToDownload[i], {
			timeout: 3000000
		});
		await page.waitForSelector('div#divImage');
		var imageLinks = await page.evaluate(() => [...document.querySelectorAll('#divImage > p > img')].map(element => element.getAttribute('src')));  
		console.log('The links of the current chapter\'s images are: ' + '\n', imageLinks);
		imageLinksSeparated = imageLinks.join('\r\n');
		fs.writeFile('/home/archyusuf/Documents/Documents/Manga/mangaDownload/Links/' + chapterName + '.txt', imageLinksSeparated, function(err) {
			if(err) {
				return console.log(err);
			}

			console.log('The file was saved as ' + chapterName + '.txt');
		});
		await page.waitFor(4000);
	};

	await browser.close();
})();
