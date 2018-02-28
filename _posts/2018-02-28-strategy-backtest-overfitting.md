---
layout: post
title: Overfitting problem in quantitative trading strategies
comment: true
key: 20180228
tags: idea strategy
---

The problem of overfitting is ubiquitous. In the world of quantitative trading, its impact can be devastating. On the modest side, the signal degredates very fast; on the extreme side, you lose money. Overfitting is the most severe when you optimize your model parameters by maximizing some kind of objective function, no matter if it's gain, sharpe ratio, least drawdown etc., using the historical price time series. After all, by looping through the same price series for enough times, you ultimately would end up with some strategy that works perfectly. But out-of-sample performance is doomed to be bad-looking. Things get even worse when the model has all sorts of tuning parameters.

By the way, the very famous ["curve of dimensionality"][curse-of-dimension] already tells us that the among of data to get robust prediction grow exponentially with the increase of dimension. So, simple strategies are often better strategies. Anyways, even with simple model, my personal rule-of-thumb is that, if the optimized value is overly sensitive to the choice of parameter around its backtested "optimal", then it's probably not good. On the other hand, if the jiggled parameters lead to similar results, then the parameters are more likely to thrive.

We also know that cross-validation is an awesome way to reduce the risk of overfitting. I'll probably talk about how I think it can be used in quantitative stratigies in another post. But for now, I'd like to introduce you to an awesome [blog post][blog-post] by Ernest Chan, the author of a few well-known quant trading books, that talks about their stab at the overfitting problem. To put into simple terms, one can backtest on simulated price series and optimize over all possible outcomes. The simulated price comes from a good time series model of the price history, which probably has to have some unique characteristics that can be used. After all, one cannot have a wining strategy over pure random walks. This approach is kind of like data agumentation, whic I argue that time series model based simulation is much better than resampling. The latter approach is used widely in monte carlo simulation (according to my professor of risk management).

This of course relies heavily on a good (and stable) time series model of the price history. I cannot speak from that perpesctive if that's realistic or not, since I'm not an expert of time series. This blog post also mentioned two papers by [Leung][leung-paper] and [Karr][karr-paper] respectively on this subject. The Karr paper is said to be similar to what Ernest described in his blog post, although he claimed that they discovered this approach indenpendently.

Also as a heads-up, I'll probably write another post on my recently developed trading system based on python and redis. This is system is designed to run both in real-time and as backtesting, so they they utilize the same infrastructure and code base. The system is also designed for scalability, in the sense of add more assets, exchanges, and components, though the performance would probably see a bottle neck for higher frequency and more complex processes. I've started learning node.js, which I've been told good things about.

Until next time.


[curse-of-dimension]: https://en.wikipedia.org/wiki/Curse_of_dimensionality
[blog-post]: http://epchan.blogspot.com/2017/11/optimizing-trading-strategies-without.html
[leung-paper]: https://arxiv.org/pdf/1411.5062.pdf
[karr-paper]: https://arxiv.org/pdf/1408.1159.pdf
