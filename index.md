---
layout: page
title: Welcome
tagline : Neuroscientist
analytics : false
---
{% include JB/setup %}
<p><img src ="{{ BASE_PATH }}/assets/images/googleplusprofile.jpg" class="inset right" style="margin-top: -3em;" title="Ali Neishabouri" alt="Photo" width="120px" /></p>
I'm Ali Neishabouri, a research associate in the [Department of Computing](http://www3.imperial.ac.uk/computing) at the [Imperial college London](http://www3.imperial.ac.uk/). I am part of the [Brain and Behaviour lab](http://www.faisallab.com).

I investigate the basic biophysical constraints faced by axons, and how these constraints have shaped the trade-offs made by neurons. I investigate these tradeoffs using stochastic simulations based on biophysical data found in litterature. The simulations are carried on using Modigliani, our in-house stochastic simulator.

{% if site.posts.size != 0 %}
## Blog
<ul class="posts">
  {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
  {% endfor %}
</ul>
{% endif %}
