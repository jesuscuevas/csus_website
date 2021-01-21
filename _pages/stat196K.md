---
title: STAT 196K - Analyzing and Processing Big Data
---

This is the course webpage for STAT 196K, Analyzing and Processing Big Data, at CSU Sacramento.
The course notes are available here.
Announcements, assignment submissions, grades, discussions, lecture recordings, and anything that may identify students is [available on Canvas](https://csus.instructure.com/courses/75528).

<ul>
  {% for post in site.tags.stat196K %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
