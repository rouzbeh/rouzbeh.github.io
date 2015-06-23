---
layout: page
title: "Blog posts"
description: ""
---
{% include JB/setup %}

<div class="col-lg-8 col-lg-offset-2 col-md-10 col-md-offset-1">
{% for post in site.posts %}
<div class="post-preview">
<a href="{{ BASE_PATH }}{{ post.url }}">
<h2 class="post-title">
{{ post.title }}
<small>Posted on {{ post.date | date_to_long_string }}</small></h2>
</a>
{{ post.excerpt }}
</div>
{% endfor %}
</div>
  
