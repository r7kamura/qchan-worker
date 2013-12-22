# Qchan Worker
Worker implementation of Qchan.

Qchan is a project of a Job-Queue Worker System.
It consists of a cluster of many processes and Qchan Worker takes care of processing real tasks.
Qchan Woker has a responsibility to process build-tasks, enqueued to Redis server by Qchan API.

![](https://raw.github.com/r7kamura/qchan-worker/master/doc/png/overview.png)

## Usage
```
bundle exec rake resque:work
```

## Configuration
* ENV["QCHAN_API_HOST"] - Qchan API's host (default: "localhost")
* ENV["QCHAN_API_PORT"] - Qchan API's port (default: "80")
* ENV["QCHAN_API_SCHEME"] - Qchan API's scheme (default: "http")
* ENV["QUEUE"] - queue names to be pulled from Resque (default: "builds")
* ENV["REDIS_HOST"] - redis hostname (default: "localhost")
* ENV["REDIS_PORT"] - redis port number (default: "6379")
