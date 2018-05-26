---
layout: article
title: Trading Systhem with Python and Redis (toy model)
comment: true
key: 20180306
tags: idea 
---
## Basic Idea
While getting more interested nowadays in trading system design, I want to share today what I've been thinking and implementing so far, as basis of entering the grand regime of the quant trading world. In previous post, I said that simple models are often better models. That usually makes the implementation of model less big of a deal. Therefore, building a robust and scalable trading system would be the more fun part. In this post, I'll demonstrate with simple examples as prroof of concept, and illustrate the thought process I have regarding building a trading system from ground up.

The basic components of a tranding system includes but not limited to: raw data feed, data ETL, signal generation, order generation, order execution, account management, risk management, P&L component, data persistence, etc. Some of the component can be thought of multiple cascades of processing with potentional branches if, say, we have multiple signals. One modern way of thinking about real-time system is based on event-driven programming. At the occurence of an event, certain process gets triggered and passed over the subsequent processes. In other times, these processes remains idle. This naturally creates a asynchronous pipeline, which throughput is limited by the slowest component. The good news is that as long as all events/data are somewhat independent and can be processed in parallel, we can always throw in more "workers" to the bottleneck component. As long as the most limited component has higher throughput than the original input, the system would not see any congestion.

The communication between components are mostly pre-defined structured data. Hence, naturally it makes sense to have some unified API between all components. This way, it is a lot easier to build things just against the API. All you need to know is how to connnect to the standard API, what data you are getting, and what kind of data you should be sending. The data you are getting is probably determined by the upstream components and aggreed by all parties globally schema-wise, similarly for the kind of data you are sending out.

The above pattern is called publisher-subscriber pattern. You might've heard observer/observable pattern, which is somewhat similar. The nuance difference is the exact reason why Redis is used. Pub/Sub pattern are composed of two relatively independent component, whose message flow is entirely controlled by the central message bus. These two components don't necessarily know the existence of one another. That's to say, the publisher can keep publishing "into the air", while the subscriber can subsribe to something that has no news. On the other hand, the subject in the observer pattern has to maintain the event loop and maintain all information of the observers, similarly observers are aware of the existence of the subject, thus hooking up itself to the subject. The pub/sub is more loose in terms of component coupling, but central message bus is required in implementation.

## System Structure
Usually message bus is pain in the butt. With Redis, we now have a lightweight central message bus, with very limited functionality comparing with other full-fledged message buses (Kafka, RabbitMQ, ActiveMQ, ZeroMQ, etc), but enough for a toy model. The basic pattern for each component is (in Python):

```
cache = redis.StrictRedis(...)
p = cache.pubsub()
p.subscribe('some_topic')
for msg in p.listen();
    # do something with msg
    # msg: type, pattern, channel, data
    p.publish('some_other_topic', some_new_data)
```

The for-loop is a infinite loop, which will not exit when there's no new message in the `some_topic` it subscribes to. Now you can use the same pattern to write a few components and generate orders. Note that the raw data feed also needs to run continuously. One can make intermittent calls to REST API with the following pseudo-code

```
while True:
    call REST API for data
    publish('some_topic', 'some_data')
    sleep(1)
```

However, the data is only avaible when we call API for it, and the overhead around http request/reponse leads to higher latency. In quant trading, we want to be more real-time and have less latency. Thus, other data transferring channels are preferred, such as the WebSocket connection (which a lot of exchanges provide). What's better, the socket connection is naturally event-driven, seamlessly integrated into our existing pipeline. So a better way of implementing raw data feed is

```
data_feed = websocket(some_url, some_authentication)
for msg in data_feed.listen():
    # turn raw data into internal data schema
    publish('some_topic', 'some_data')
```

Simple as this. Until nex time.


