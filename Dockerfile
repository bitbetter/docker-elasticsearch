FROM dockerfile/java:oracle-java8
MAINTAINER Martin Kretz <martin.kretz@bitbetter.se>

# Install elasticsearch from package
RUN wget -qO- https://packages.elasticsearch.org/GPG-KEY-elasticsearch | sudo apt-key add -
RUN add-apt-repository "deb http://packages.elasticsearch.org/elasticsearch/1.4/debian stable main"
RUN apt-get -q update
RUN apt-get -qy install elasticsearch=1.4.4

# Install elasticsearch curator
RUN apt-get -y install python python-dev python-distribute python-pip
RUN pip install elasticsearch-curator

# Add curator to crontab
ADD elasticsearch.crontab /tmp/elasticsearch.crontab
RUN crontab /tmp/elasticsearch.crontab

# Install monit
RUN apt-get -y install monit
ADD elasticsearch.monit.conf /etc/monit/conf.d/elasticsearch.monit.conf

# Expose ports
EXPOSE 9200 9300

# Make elasticsearch data folder mountable
VOLUME ["/var/lib/elasticsearch"]

# Run supervisor
WORKDIR /tmp
CMD ["/usr/bin/monit", "-d 10", "-I"]
