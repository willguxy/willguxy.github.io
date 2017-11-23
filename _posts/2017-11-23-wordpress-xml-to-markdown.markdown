---
layout: post
title:  "Turn your wordpress.com blog into Jekyll"
categories: miscellaneous
---
I found this [Github Gist][wordrpessxml2jekyll] pretty useful. After exporting the xml file from wordpress admin account, you can call the `wordpressxml2jekyll.rb` like

{% highlight bash %}
ruby wordpressxml2jekyll.rb wordpress.xml
{% endhighlight %}

Then you should be able to find a folder named `_posts` under your current directory. I have to admit it's not perfect and you'd be better off using wordpress plugins such as [Jekyll Exporter][jekyll-exporter]. It would work if you have wordpress blog fully managed by you, but would fail in case you are using the free version on wordpress.com

Trust me, don't even bother trying the method mentioned on jekyll's website -- it's not going to work and the output markdown files are pretty much trash. *pandoc* didn't work for me either.

[wordpressxml2jekyll]: https://gist.github.com/brianburridge/d28fd59ecd097c140be2
[jekyll-exporter]: https://wordpress.org/plugins/jekyll-exporter
