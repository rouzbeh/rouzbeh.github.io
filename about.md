---
layout: page
title: "About me"
description: ""
group: navigation
icon: fa-child
pageorder: 4
---
{% include JB/setup %}

{% for category in site.data.cv.categories %}
<div class="col-lg-6 col-md-6 col-sm-12">
<h2>{{ category | capitalize}}</h2>
{% for item in site.data.cv.items %}
{% if item.category == category %}
<h3>{{ item.title }}</h3>
<h4>{{item.date}} <small>{{item.place}}, {{item.location}}</small></h4>

<p class="text-justify">{{ item.description }}</p>

{% endif %}
{% endfor %}
</div>
{% endfor %}

<div class="col-lg-6 col-md-6 col-sm-12">
<h2>Contact</h2>
<p>
<p class="voffset2">
  <a href="http://pgp.mit.edu:11371/pks/lookup?op=vindex&search=0x267288B636FDE1E9">
    <i class="fa fa-lock"></i>
    Public key</a><br/>
    <a href="http://twitter.com/Rou7_beh"><i class="fa fa-twitter"></i> @Rou7_beh</a><br/>
    <a href="http://github.com/rouzbeh"><i class="fa fa-github"></i> @rouzbeh</a><br/>
    <i class="fa fa-chevron-right"></i>
    <a href="https://www.researchgate.net/profile/Ali_Neishabouri">ResearchGate</a>
    <br/>
    <i class="fa fa-chevron-right"></i>
    <a href="https://scholar.google.com/citations?user=1Enh_KsAAAAJ">
      Google Scholar
    </a>
  </p>
I speak Persian, French and English.
</div>