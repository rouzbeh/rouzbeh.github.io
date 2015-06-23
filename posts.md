---
layout: default
title: "Blog posts"
description: ""
---
{% include JB/setup %}

{% assign post = site.posts.first %}
{% assign page = site.posts.first %}
{% assign content = post.content %}

<div class="page-header">
  <h1>Blog posts</h1>
</div>
<div class="col-xs-4 pagination-centered">
  <ul class="posts">
    {% for post in site.posts %}
    <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ BASE_PATH }}{{ post.url }}">{{ post.title }}</a></li>
    {% endfor %}
  </ul>
  </div>

<div class="col-xs-8">
  <h2>{{ post.title }} {% if page.tagline %}<small>{{page.tagline}}</small>{% endif %}</h2>
  <div class="date">
    <span>{{ post.date | date_to_long_string }}</span>
  </div>
  <div class="content">
    {{ content }}
  </div>
  
  {% unless page.categories == empty %}
  <ul class="tag_box inline">
    <li><i class="glyphicon glyphicon-open"></i></li>
    {% assign categories_list = page.categories %}
    {% include JB/categories_list %}
  </ul>
  {% endunless %}  
  
  {% unless page.tags == empty %}
  <ul class="tag_box inline">
    <li><i class="glyphicon glyphicon-tags"></i></li>
    {% assign tags_list = page.tags %}
    {% include JB/tags_list %}
  </ul>
  {% endunless %}  
  
  <hr>
    <ul class="pagination">
      {% if page.previous %}
      <li class="prev"><a href="{{ BASE_PATH }}{{ page.previous.url }}" title="{{ page.previous.title }}">&laquo; Previous</a></li>
      {% else %}
      <li class="prev disabled"><a>&larr; Previous</a></li>
      {% endif %}
      <li><a href="{{ BASE_PATH }}{{ site.JB.archive_path }}">Archive</a></li>
      {% if page.next %}
      <li class="next"><a href="{{ BASE_PATH }}{{ page.next.url }}" title="{{ page.next.title }}">Next &raquo;</a></li>
      {% else %}
      <li class="next disabled"><a>Next &rarr;</a>
        {% endif %}
    </ul>
    <hr>
    {% include JB/comments %}
</div>


