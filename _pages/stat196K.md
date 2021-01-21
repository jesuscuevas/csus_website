---
title: STAT 128 - Statistical Computing
---

This is the course webpage for my STAT 128 course at CSU Sacramento.
In this class we'll learn about data science and statistical computing using the R programming language.
The course notes are available on this page.
Announcements, assignment submissions, grades, discussions, lecture recordings, and anything that may identify students is [available on Canvas](https://csus.instructure.com/courses/67306).

<ul>
  {% for post in site.tags.stat128 %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>
