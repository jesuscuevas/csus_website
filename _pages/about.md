---
---

<iframe width="560" height="315" src="https://www.youtube.com/embed/eJooFMxrPMo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

I'm an Assistant Professor in the [Department of Mathematics & Statistics](https://www.csus.edu/college/natural-sciences-mathematics/mathematics-statistics/) at CSU Sacramento, where I teach classes in statistics, computing, and data science.
This is my personal website, which I use primarily to share course material with the public.
It does not reflect the opinions of my employer.

If you find the content on this site useful, feel free to link to it, or [send me an email](mailto:fitzgerald@csus.edu).
Not everything posted on here is nicely finished, and I expect the content will continue to evolve for many years.
Use code at your own risk.

## Personal

I value clear, direct, and timely communication with my students.
Sometimes, I'm direct to the point of being terse.
So if I reply with one word, or just a 👍, please know that's just a style I use when I'm short on time.

The following posts are more about my personal experience and opinions, and less about technical content.
Most of my RTP ([research, tenure, and promotion](https://github.com/clarkfitzg/rtp)) documents are also online.
The RTP repository contains lots of personal reflection as I learn how to teach.

<ul>
  {% for post in site.tags.personal %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      {{ post.excerpt }}
    </li>
  {% endfor %}
</ul>


## Website

I built this website using Jekyll, and you can find the [website source code here](https://github.com/clarkfitzg/csus_website).
Feel free to use it as a template or a starting point if you want to build a website.

I have no special talents or interest in formatting.
If you're my student and it would be better if this website looked a different way, then just let me know.
