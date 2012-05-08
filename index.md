---
layout: page
title : Ali Neishabouri
tagline : PhD student
analytics : false
---
{% include JB/setup %}
## About
Find out more [about]({% for page in site.pages %}{% if page.title == "About"%}{{ BASE_PATH }}{{ page.url }}{% endif %}{% endfor %}) who I am and how to contact me.

## Research
I am a PhD student in the [Department of Bioengineering](http://www3.imperial.ac.uk/bioengineering) at the [Imperial college London](http://www3.imperial.ac.uk/). I am part of the [Brain and Behaviour lab](http://www.faisallab.com).

I investigate the basic biophysical constraints faced by axons, and how these constraints have shaped the trade-offs made by neurons. I investigate these tradeoffs using stochastic simulations based on biophysical data found in litterature. The simulations are carried on using Modigliani, our in-house stochastic simulator.

{% if site.posts.size != 0 %}
## Blog
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
{% endif %}
