# Qchan Worker
Worker implementation of Qchan.

Qchan is a project of a Job-Queue Worker System.
It consists of a cluster of many processes and Qchan Worker takes care of processing real tasks.
Qchan Woker has a responsibility to process build-tasks, enqueued to Redis server by Qchan API.

![](https://raw.github.com/r7kamura/qchan-worker/master/doc/png/overview.png)

## Usage
Note: Ruby 1.9.3 or later is required to run Qchan Worker.

```sh
# setup
gem install bundler
bundle install

# run
bundle exec rake resque:work
```

### Docker
[Dockerfile](https://github.com/r7kamura/qchan-worker/blob/master/Dockerfile)
is provided to use docker to run Qchan Worker.

```sh
docker build -t qchan-worker .
docker run qchan-worker
```

### Configuration
Change the following ENV variables for your environment.

* QCHAN_API_HOST - Qchan API's host (default: "localhost")
* QCHAN_API_PORT - Qchan API's port (default: "80")
* QCHAN_API_SCHEME - Qchan API's scheme (default: "http")
* QUEUE - queue names to be pulled from Resque (default: "builds")
* REDIS_HOST - redis hostname (default: "localhost")
* REDIS_PORT - redis port number (default: "6379")
