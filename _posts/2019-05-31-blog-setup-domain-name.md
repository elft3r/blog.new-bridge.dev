---
layout: post
title: "Blog setup: Domain Name"
author: "Jochen"
---

In my [first post](/2019-05-25/hello-world) I wrote, that the first series of
posts will be about the setup of my blog. As I am always curios how things
work and what needs to be done to combine all the different pieces, I decided
to host my blog in my apartment. Currently, it is running on a linux server,
but the ultimate goal is to migrate the blog, to a Raspberry Pi based
Kubernetes cluster that I have already running. But as this is further down
the road, I will focus for now on the current setup.

First let me show you a high-level overview, how a call from your browser
ends up at the server, that is hosting the blog. I simplified especially the
part at your end and the involved components within the internet, as this
would add additional complexity, which is out of the scope for this post.
Nevertheless, it should give you a basic understanding of what is going on.
![Blog setup](/assets/blog-setup/blog-setup.png)
_High-level overview of how to access my blog_

# Domain Name
Let's get started by talking about _domain names_. You ended up on my block
by either clicking on a link or by entering the URL
<https://blog.new-bridge.dev>{:target="_blank"} into your browser. Each URL
consists of three parts:

* the protocol (e.g. _https_)
* the domain name (e.g. _blog.new-bridge.dev_)
* the file to display (e.g. _index.html_)[^1]

For this post, I will focus on the domain name, but we will come back to the
protocol in one of the next posts, especially when talking about how to
handle the request within the network of my apartment.

The [domain
name](https://en.wikipedia.org/wiki/Domain_name){:target="_blank"}, among
other things, identifies a resource on the internet and is the central piece
in the URL. In order to get your own domain name you have to sign-up with a
[domain name
registrar](https://en.wikipedia.org/wiki/Domain_name_registrar){:target="_blank"},
which allows you to register domain names. Most of the registrars also have
additional services like web hosting, mail hosting and so on, so that you
don't need to set up and configure the infrastructure on your own. After some
research, I decided to register the _new-bridge.dev_[^2] domain name at
[Namecheap](https://www.namecheap.com/){:target="_blank"}.

Now that I had registered a domain name, I needed to make sure, that the
requests for that domain are routed to the router in my apartment.

# DNS
Traffic on the internet is not routed based on domain names, but instead
based on [IP
addresses](https://en.wikipedia.org/wiki/IP_address){:target="_blank"}. This
means, you can also access my blog via
[213.55.173.239](http://213.55.173.239){:target="_blank"}, which is the IP
address that is assigned by my ISP (Internet Service Provider) to my
router[^3]. In order to make sure, that all the requests for
[blog.new-bridge.dev](https://blog.new-bridge.dev){:target="_blank"} are
routed to this IP address, I had to configure the [DNS (Domain Name
System)](https://en.wikipedia.org/wiki/Domain_Name_System){:target="_blank"},
using the tooling provided by the registrar. To do so, I added two lines to
the configuration to do the job.[^4]

First I added an __A record__, that forwards all the requests for the
_current domain_ to the IP address: 213.55.173.239 (@ is a placeholder for
the current domain, which in my case will be replaced with new-bridge.dev)
{% highlight resource %}
@    IN A     213.55.173.239  ;
{% endhighlight %}

In addition to the first record, I added a __CNAME record__, that
forwards all the requests for _blog.new-bridge.dev_ to _new-bridge.dev_
{% highlight resource %}
blog IN CNAME new-bridge.dev. ;
{% endhighlight %}

After these changes were activated[^5], each request to my domain
(independent of the protocol), started being forwarded to my router. The next
step, was to configure the router, so that all the requests are forwarded to
the linux server. But I will tell you more about this in the next post.

Thanks for reading!

<hr>

[^1]: There is no file shown in the example URL. It would be placed after the
      domain name and separated by a `/`

[^2]: I picked this domain name as an homage to the place where I grew up
      :blush:

[^3]: If you also want to host a blog in your apartment, you either have to
      make sure, that your ISP assigns you a fixed IP or that you use a
      [Dynamic DNS](https://en.wikipedia.org/wiki/Dynamic_DNS)

[^4]: I could have also configured the DNS with one entry, but as I have also
      other things configured, this was the better choice for me

[^5]: Changes to the DNS aren't instant and it will usually take several
      minutes or in worst cases up to 24h until they are propagated
      throughout the internet
