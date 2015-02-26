# Elasticsearch on docker

## Features

* Installs elasticsearch 1.4.4
* Uses supervisord to monitor the elasticsearch process
* Run daily cronjob to limit elasticsearch index size to 4GB (customizable)


## Build

```sh
$ docker build -t bitbetter/elasticsearch .
```

## Run

```sh
$ docker run --rm -it bitbetter/elasticsearch
```
