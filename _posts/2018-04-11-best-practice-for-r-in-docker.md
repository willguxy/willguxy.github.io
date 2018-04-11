---
layout: post
title: Best practice for R in Docker
comment: true
key: 20180411
tags: idea 
---

## Docker

I've talked about this topic in the past but decided to write another post with some practical ideas. To recap, containerization software `Docker` is a program that provisions and executes OS-level virtual machines. It runs within a system and gives the user the access to independent developing and run-time environments. For individual applications, `Docker` provides a VM solution that is isolated from the host OS to package them up with their dependencies and "ship" together. It makes application deployment very easy with just a few command lines. Comparing with server-level configurations, `Docker` allows multiple applications run on the same server without them affecting each other, and potentially communicate through the loopback network, without having to expose ports to other servers. The resource management. `Docker` can be used to build cluster on a single server by running multiple containers. Scaling is also made easy with `Docker` by using `docker-compose`. Server start-up and shut-down are usually slower than docker container up and down. `Docker` provisioning is also much simpler than that for server, which makes docker perfect for the scaling type of work.

## Containers for R

My trials with R containers in docker hub have been futile. The reason is that R doesn't have many dependencies to begin with, especially with the `Ubuntu` base image. All you need is to install `r-base` and `r-base-dev`, although for other OS you might need a bit of work to install R. I mentioned last time that one way to instlal R packages is by using `Rscript -e "install.packages('your_awesome_package_name')"`, but just like Python, a lot of the R packages are built with C and rely on certain libraries. It's easy to install those, but sometimes hard to wrap your head around what's really needed without spending some time on Google.

An alternative and probably better way is to install these packages by `apt-get`. Some the common R packages all follow the same naming convention as `r-cran-xxx`. For example, `r-cran-ggplot2`, `r-cran-rpostgresql`. The reason why this is better is because the maintainers of these `apt` packages also specify dependencies, so that you don't need to know that `RPostgreSQL` relies on `libpq-dev` -- `apt-get` would install that for you.

Of course there are still a few exceptions. For example, the very awesome `data.table` package is not in `apt` as of now, so you'd need a bit of work to install that separately. What you could do, as I suggested last time, is to mimic what python does for dependencies. You can create a file called `requirements.txt` and it goes

```
data.table
```

and then you can have another R script called `install.R` with your favorite repo mirror server

```
pkgs = read.csv('requirements.txt', header=FALSE, stringsAsFactors=FALSE)$V1
install.packages(pkgs, repos='http://cloud.r-project.org/')
```

and finally your `Dockerfile` can go like

```
from ubuntu:16.04

run apt-get update \
  && apt-get install -yqq --fix-missing \
  && apt-get upgrade -yqq \
  && apt-get install -yqq bsd-mailx \
  && apt-get install -yqq r-base r-base-dev \
  && apt-get install -yqq r-cran-rpostgresql r-cran-magrittr r-cran-gridextra \
  && apt-get autoremove

add requirements.txt /tmp/requirements.txt
add install.R /tmp/install.R
run cd /tmp && Rscript install.R

# some other stuff
```

Of course you can just throw the R package installation step in the `Dockerfile`, but I feel this way is clearer, and you can squash all installation into one step, which reduces unnessary layers when building the image.

Until nex time.
