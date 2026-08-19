---
layout: page
title: "Blog posts"
description: ""
group: navigation
icon: fa-quote-right
pageorder: 3
---
{% include JB/setup %}
<div class="post-list">
{% for post in site.posts %}
<div class="post-preview">
<h2 class="post-title"><a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></h2>
<time class="post-meta" datetime="{{ post.date | date_to_xmlschema }}">{{ post.date | date_to_long_string }}</time>
{{ post.excerpt }}
</div>
{% endfor %}
</div>
