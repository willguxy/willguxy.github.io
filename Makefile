DIR ?= $$HOME/workspace/jekyll-TeXt-theme

restore:
	git checkout -- _sass/settings/_colors.scss

sync-template:
	rsync -avP $(DIR)/_data/ _data/ && \
	rsync -avP $(DIR)/_includes/ _includes/ && \
	rsync -avP $(DIR)/_layouts/ _layouts/ && \
	rsync -avP $(DIR)/_sass/ _sass/ && \
	rsync -avP $(DIR)/assets/ assets/

sync: sync-template restore
