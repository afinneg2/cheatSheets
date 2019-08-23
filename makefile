SHELL=/bin/bash

TOCline1=$$(cat quickRef.md  | grep -n -e  '^\[TOC\]' | cut -f1 -d:)
TOCline2=$$(cat quickRef_git.md  | grep -n -e  '^\[TOC\]' | cut -f1 -d:)
display_github/quickRef.md display_github/quickRef_git.md /display_github/misc/git_cheat_sheet.png: quickRef.md quickRef_git.md misc/git_cheat_sheet.png
	@echo "Creating ./display_github/quickRef.md with Table of contents for github"
	@tail -n  +$$(( $(TOCline1) + 1 ))  quickRef.md > quickRef.tail.md
	@bash ./scripts/gh-md-toc quickRef.tail.md | cat - quickRef.tail.md > quickRef.tmp.md
	@head -n $$(( $(TOCline1) - 1 ))  quickRef.md | cat - quickRef.tmp.md > ./display_github/quickRef.md
	@rm quickRef.tail.md quickRef.tmp.md
	@echo "Creating ./display_github/quickRef_git.md with Table of contents for github"
	@mkdir -p ./display_github/misc 
	@cp ./misc/git_cheat_sheet.png ./display_github/misc/git_cheat_sheet.png 
	@tail -n  +$$(( $(TOCline2) + 1 ))   quickRef_git.md >  quickRef_git.tail.md
	@bash ./scripts/gh-md-toc  quickRef_git.tail.md | cat -  quickRef_git.tail.md >  quickRef_git.tmp.md
	@head -n $$(( $(TOCline2) - 1 ))   quickRef_git.md | cat - quickRef_git.tmp.md > ./display_github/quickRef_git.md
	@rm quickRef_git.tail.md quickRef_git.tmp.md     

