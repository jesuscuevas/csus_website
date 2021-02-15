---
---

If you're a student at CSUS and you are interested in doing a research project involving data science or software development in Julia, R, or Python, then come by my office (Shasta 156) or [send me an email](mailto:fitzgerald@csus.edu).
If you're a major or minor in the [College Natural Science & Mathematics](https://www.csus.edu/college/natural-sciences-mathematics/), then [summer funding opportunities](https://www.csus.edu/college/natural-sciences-mathematics/research/sure-award.html) may be available.

A list of current and former students follows.


<!--
Can't figure it out, and don't have time.
https://stackoverflow.com/questions/31918354/stop-floating-with-the-end-of-a-tag/31918440
.floatBlock:after {
    display: block;
    content: " ";
    clear: both;
    height: 0;
}
-->

{% for post in site.tags.student %}
<div class="floatBlock">
  <p>
  <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
  {{ post.excerpt }}
  {{ post.time }}
  </p>
</div>
{% endfor %}
