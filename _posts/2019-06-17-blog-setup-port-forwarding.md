---
layout: post
title: "Blog setup: Port Forwarding"
author: "Jochen"
---

In my previous post, I explained what I had to do, to make sure that the
requests end up at my router. Therefore, I configured the DNS to send
requests for my domain to the public IP address assigned to my router.
However, the blog is not running on the router, but instead on a server in my
local network. This means the router needs to forward all requests to this
server.

Maybe you are asking yourself, why didn't I configure the DNS in the first
place to send the requests directly to the server? The reason for that has to
do with the way how networking works. My server has a private IP address,
that cannot be reached from the internet directly, only my router can be
accessed from the internet, via the assigned public IP.[^1] But luckily there
are technologies out there to solve this problem, and port forwarding is one
of them. However, before going into the details of port forwarding, I want to
explain why ports are needed.

# Why do we need ports?
Up to this point, I always talked about IP addresses and how important they
are, to make sure that each request ends up at the intended system. When the
request reaches the system, it needs to know to which application the request
has to be forwarded. In addition, there are usually multiple applications
running on a server, that are waiting for incoming requests (e.g. web server,
ssh server, ...), therefore a way to distinguish these applications is
needed. This is where ports come into play. Each application that wants to
receive requests over the network, has to listen on a specific port. For each
request that arrives at the system, it checks whether there is an application
listening on this port and if so, the system passes the request over to this
application. There is a [list of
ports](https://en.wikipedia.org/wiki/List_of_TCP_and_UDP_port_numbers){:target="_blank"}
that describes which port should be used for which protocol, including a
range of ports that can be used for custom purposes.

When one accesses a website over the browser, the so called _Hypertext
Transfer Protocol (HTTP)_ is used. There are two ports reserved for this,
port 80 and port 443. Whereas, the latter is used for HTTPS, which is HTTP
via
[TLS/SSL](https://en.wikipedia.org/wiki/Transport_Layer_Security){:target="_blank"}.
These are the two ports, I will later come back to, when I explain the
configuration of the router[^2].

# Port Forwarding
Now that I explained what ports are, let's jump into [port
forwarding](https://en.wikipedia.org/wiki/Port_forwarding){:target="_blank"}.
With port forwarding[^3] a system forwards an incoming request for a specific
port to
* another port on the same system
* the same port on another system
* another port on another system

In my case, I configured my router, to forward requests for port 80 and port
443 to the same ports on another system in my network (see line No. 2 and 3
in the image below). If a request comes in, that isn't for one of these two
ports, the router will block that request, and the caller will get a
_connection refused_.

In the image below, the _Public Port_, is the port on which the router is
listening and the _Private IP_ and _Private Port_ contains the information,
to where the request gets forwarded to. The image shows also a column labeled
_Protocol_, which is either set to
[UDP](https://en.wikipedia.org/wiki/User_Datagram_Protocol){:target="_blank"}
or to
[TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol){:target="_blank"}.
The differences between these two are, that the latter guarantees that all
the packets of a request will be passed in the correct order to the
application. Whereas, the first one makes no guarantees whether the request
will arrive at the application.

![Port forwarding Configuration](/assets/blog-setup/port-forwarding.png)
_Port forwarding configuration of my router_

With these configurations on the router, all requests for my blog end up at
the server that is hosting the blog. In my next post I will focus on the
server, including the installed software and the different configurations I
had to do.

Thanks for reading!

---

[^1]: More information about IP addresses can be found
      [here](https://www.lifewire.com/what-is-an-ip-address-2625920){:target="_blank"}

[^2]: It doesn't necessarily have to be port 80 or 443, one can also specify
      other ports

[^3]: Port forwarding is sometimes also referred to as port mapping
