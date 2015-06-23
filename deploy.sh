#!/usr/bin/env bash
sed 's/BASE_PATH :\ false/BASE_PATH :\ \/\~man210/g' _config.yml >_config_deploy.yml
mv _config.yml _config.yml.bak
mv _config_deploy.yml _config.yml
jekyll build
rsync -avz --delete _site/ shell:/homes/man210/public_html
ssh shell 'cd ~/public_html && ln -s french French && ln -s mathmatics Mathematics && ln -s tips Tips'
mv _config.yml.bak _config.yml

