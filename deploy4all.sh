#!/usr/bin/env bash
jekyll build
rsync -avz --delete _site/ web:/datas/vol3/w4a155529/var/www/neishabouri.net/htdocs

