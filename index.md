---
layout: page
title: Ali Neishabouri
tagline: PhD student
---
{% include JB/setup %}

Read more [about]({% for page in site.pages %}{% if page.title == "About"%}{{ BASE_PATH }}{{ page.url }}{% endif %}{% endfor %}) me.

## Research
I am a PhD student in the [Department of Bioengineering](http://www3.imperial.ac.uk/bioengineering) at the [Imperial college London](http://www3.imperial.ac.uk/). I am part of the [Brain and Behaviour lab](http://www.faisallab.com). 

I am focused on the basic biophysical constraints faced by axons, and how these constraints have shaped the trade-offs made by neurons. I investigate these tradeoffs using stochastic simulations based on biophysical data found in litterature. The simulations are carried on using Modigliani, our in-house stochastic simulator.

{% if site.posts.size != 0 %}
## Blog
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
{% endif %}
