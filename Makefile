.PHONY: watch

watch:
	# pipe from /dev/null to prevent interaction
	latexmk --pdf -pvc main.tex < /dev/null
