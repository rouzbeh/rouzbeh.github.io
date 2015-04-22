#!/usr/bin/env bash
jekyll build
rsync -avz --delete _site/ man210@shell1.doc.ic.ac.uk:/homes/man210/public_html
