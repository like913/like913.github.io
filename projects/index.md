---
title: Проекты
description: Все созданные проекты автора сайта
permalink: /projects/
layout: page
categories: 
- projects
tags:
- project
---

{% for post in site.categories.project %}
<div>
	<h4><a href="{{ post.url }}" title="{{ post.description }}">{{ post.title }}</a></h4>
	<div>{{ post.excerpt }}</div>
	<div class="right"><a href="{{ post.url }}" title="{{ post.description }}">Читать далее...</a></div>
</div><hr class="gray" />
{% endfor %}
