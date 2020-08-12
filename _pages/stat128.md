---
title: STAT 128 - Statistical Computing
---

This is the course webpage for STAT 128 at CSU Sacramento.
I plan to keep this page public, so that it's easier for alumni to refer back to it.

<ul>
  {% for post in site.tags.stat128 %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
