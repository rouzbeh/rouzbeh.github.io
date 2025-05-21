---
layout: page
title: "Blog posts"
description: ""
group: navigation
icon: fa-quote-right
pageorder: 3
---
{% include JB/setup %}
{% for post in site.posts %}
<div class="post-preview">
<a href="{{ BASE_PATH }}{{ post.url }}">
<h2 class="post-title">
{{ post.title }}
</h2>
</a>
<small>{{ post.date | date_to_long_string }}</small>
{{ post.excerpt }}
</div>
{% endfor %}
