---
title: STAT 128 - Statistical Computing
---

This is the course webpage for STAT 128 at CSU Sacramento.
In this class we'll learn about data science and statistical computing using the R programming language.

<ul>
  {% for post in site.tags.stat128 %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
