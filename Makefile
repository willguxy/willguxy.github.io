DIR ?= $$HOME/workspace/jekyll-TeXt-theme

sync:
	rsync -avP $(DIR)/_data/ _data/ && \
	rsync -avP $(DIR)/_includes/ _includes/ && \
	rsync -avP $(DIR)/_layouts/ _layouts/ && \
	rsync -avP $(DIR)/_sass/ _sass/ && \
	rsync -avP $(DIR)/assets/ assets/
	rsync -avP $(DIR)/tools/ tools/

