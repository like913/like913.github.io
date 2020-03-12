---
title: Блог
description: Блог автора сайта
permalink: /blog/
layout: page
categories: 
- projects
tags:
- blog
---
<div class='flex'>
{% for post in site.categories.blog %}

{% include post-x2.html %}

{% endfor %}
</div>

{% if paginator.total_pages > 1 %}
<hr />
<div class="menu">
	<ul id="menubar">
	{% if paginator.previous_page %}
		<li><a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">&laquo; Назад</a></li>
	{% endif %}
	{% for page in (1..paginator.total_pages) %}
		{% if page == paginator.page %}
			<li><em>{{ page }}</em></li>
		{% elsif page == 1 %}
			<li><a href="{{ paginator.previous_page_path | prepend: site.baseurl | replace: '//', '/' }}">{{ page }}</a></li>
		{% else %}
			<li><a href="{{ site.paginate_path | prepend: site.baseurl | replace: '//', '/' | replace: ':num', page }}">{{ page }}</a></li>
		{% endif %}
	{% endfor %}
	{% if paginator.next_page %}
		<li><a href="{{ paginator.next_page_path | prepend: site.baseurl | replace: '//', '/' }}">Вперед &raquo;</a></li>
	{% endif %}
	</ul>
</div>
{% endif %}
