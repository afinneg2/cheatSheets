SHELL=/bin/bash

TOCline=$$(cat quickRef.md  | grep -n -e  '^\[TOC\]' | cut -f1 -d:)
display_github/quickRef.md: quickRef.md
	@echo "Creating quickRef_github.md with Table of contents for github"
	@tail -n  +$$(( $(TOCline) + 1 ))  quickRef.md > quickRef.tail.md
	@../../gh-md-toc quickRef.tail.md | cat - quickRef.tail.md > quickRef.tmp.md
	@head -n $$(( $(TOCline) - 1 ))  quickRef.md | cat - quickRef.tmp.md > ./display_github/quickRef.md
	@rm quickRef.tail.md quickRef.tmp.md	
	
 
