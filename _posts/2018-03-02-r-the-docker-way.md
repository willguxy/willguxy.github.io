---
layout: article
title: R the Docker way
comment: true
key: 20180302
tags: idea 
---
## Docker

The idea of containerized application/process has been thriving for the past few years. Basically it's a separation of concerns -- you start from scratch, install things you need for you application, and only need to worry about the local env within the container. You can build your Docker image (the VM) incrementally with version control. Deployment made easy and co-exist of all sorts of applications on one host machine without having to worry about dependencies and whatnot.

Of course, container management can be challenging once scaled-up, and there are more things on top (like Kubernetes) to facilitate the process. People kinda favor dynamic linking traditionally, and this sort goes back to the origin of Docker. But version problem is almost inevitable in dynamic linking. Python for example, is a type of VM as well (obviously virtual env tells the truth). But poeple tend to favor Docker nowadays to virtual env, because Docker is lot easier to manage and will never mess up with your host machine.

Other people may favor static-linking, which is also easy for deployment, and you don't have to worry about version problem! You don't need all the overhead and VM, which can be huge comparing with just a lightweight application (Docker image of gigabytes isn't rare). After all, do you really need all the Ubuntu systems flying around when your application just send you a reminder every day to drink more water?


## R

Enough on Docker. I've been getting all different opinions on R and Python -- the most known rivals in data science world. The reality is, which one suits you better depends on your own level of knowledge and your goal with coding something up. R in my opinion is more functional programming, where Python is more object-oriented. You may argue that both can do the other. But the fundmental philosiphy is indeed different. You can tell from the very common `head` function in R. It's generic and gives you the first couple of elements from any iteratable data structure. While in Python, it's a class method. Of course, Python has `len`, `map`, `reduce`, etc. But that's really not the focus of Python. In R, this sort of functions are everywhere.

So that makes R a language for people who are familiar with the concept and don't care too much about implementation (like people with stats background). Sloppy name space is OK. Load whatever package you need. If you are thinking about autocorrelcation, fine, just call `acf`, and boom, magic. All top level. For data work, you always think about data when coding things up. Simple as that. Of course, the learning curve could be a bit steep. But once you master a few R packages, you can just stick with them for the rest of your life. Python on the other hand, needs a bit more specification in terms of where the function gets loaded. Pandas DataFrame is unfortunately verbose comparing with R `data.table` etc.

However, Python is lot more handy when you develop some sort of process. The coding is more systematic and handles very well with all sorts of resources, e.g. `Flask` for web framework. R can do some, but is not really designed for that.


## R for Docker

Although R is not designed for full-fledge applications, it can be really useful in data science, because a lot of the work is just data ETL (Extract, Transform, and Load). R is succcinct and efficient. R library is either compiled c executables or just more R scripts. But the dependency could still be an issue, especially when you have all sorts of R processes. Docker in this case could be handy. I originally started with pure Ubuntu and tried to install R as I build the image. But with more understading in Docker, I realized that one should use existing Docker images for stability and compatibility (such as r-base on Docker hub).

Installing packages can be a bit cumbersome. Having tens of lines of `RUN Rscript -e "install.packages('ggplot2')"` in your Dockerfile is far from ideal. I'd suggest adopting the Python way, like `requirementsR.txt` with package names. And a simple R scipt to lead this file and install packages. Some R packages have dependencies which need to be installed with `apt-get`, but I think some Python modules have the same issue when you install through `pip`.

With Python it's naturally intuitive to use separate files/modules for different part of the code. Better reusability, things are put into perspectives. With R, I originally tried put all of my code into functions, and just throw all the function calls into a main function. But overtime, I feel that a lot of the ETL work is just hard to reuse. A lot of it is data specific, and requirements you to customize your code a little bit. Even though somethings are done in almost every ETL pipeline (like fill/remove missing data), it's only one or two lines. No point really to throw them into a function and try to be generic. Therefore, most of my R script is just straight top-to-bottom codes, not much function calls, ver few indents.

It's helpful though, to have some data validation steps, intermediate output, and `tryCatch`, so that debugs are a lot easier.

## Summary

Overall I think using containerized R process for data ETL work is great. With kubernetes, you can even schedule dockers and make the pipeline vert efficient


