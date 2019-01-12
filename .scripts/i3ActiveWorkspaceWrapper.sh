#!/bin/bash

i3-msg -t get_workspaces | python ~/.scripts/i3ActiveWorkspaces.py
