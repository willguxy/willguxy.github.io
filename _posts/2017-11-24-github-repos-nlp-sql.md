---
layout: article
title: A few github repos for natural language to sql queries
comment: true
key: 20171124
tags: nlp idea
---

I realize that turning natural language to sql queries isn't what nlp is all about, but it's an interesting sub-problem. It has some constraints -- for example, it expects the input to be questions related to data. On the other hand, database has to exist for your question, even some of the weirdiest ones. To that extent, nlp invoking search engines might be a better solution, and your search engine is reposible to making sense of the results. Google apparently has deployed some experimental features like this.

In other scenarios, nlp to sql can actually be quite useful. For example, if you constrain your user base to ask questions on sepecific data, like "*what's the most expensive restaurant within 25 miles of where I live?*" -- regardless of whether you really want to put your bucks on those or just out of curiosity. It's a lot easier to make sense of, and the accuracy can potentially be pretty good.

Salesforce has annouced recently that by year 2020, they will come up with some tool for their users to query data using natural language. The model? LSTM, value networks, that kinda of thing. I believe that they use those machine learning algos for a reason, but just for your knowledge, Microsoft used to provide this feature for their MS SQL products back in the years, but discontinued that project later. So the idea is definitely not new. I do believe though, that Salesforce has done their own research and decided that LSTM is the way to go.

While the above mentioned methods by Salesforce are pretty much in-house, I've found a few github repos that attempt to attack similar problems if not the same, which could good staring points if you decide to probe this problem a bit deeper:

- [In2sql][in2sql]
- [EchoQuery][echoquery]
- [quepy][quepy]
- [Natural-Language-to-SQL-Convertor][nlp2sqlconvertor]
- [NLIDB][nlidb]
- [DukeNLIDB][dukenlidb]


[in2sql]: https://github.com/FerreroJeremy/ln2sql
[echoquery]: https://github.com/vqtran/EchoQuery
[quepy]: https://github.com/machinalis/quepy
[nlp2sqlconvertor]: https://github.com/Anishabhatla281/Natural-Language-to-SQL-Convertor
[nlidb]: https://github.com/nihit7/NLIDB
[dukenlidb]: https://github.com/DukeNLIDB/NLIDB


