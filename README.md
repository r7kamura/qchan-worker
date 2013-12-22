# Qchan Worker
Worker implementation of Qchan.

Qchan is a project of a Job-Queue Worker System.
It consists of a cluster of many processes and Qchan Worker takes care of processing real tasks.
Qchan Woker has a responsibility to process build-tasks, enqueued to Redis server by Qchan API.

![](https://raw.github.com/r7kamura/qchan-worker/master/doc/png/overview.png)

## Usage
* ENV["QUEUE"] - the queue names pulled by Resque (default: "builds")
* ENV["REDIS_HOST"] - redis hostname (default: "localhost")
* ENV["REDIS_PORT"] - redis port number (default: "6379")

```
bundle exec rake resque:work
```
