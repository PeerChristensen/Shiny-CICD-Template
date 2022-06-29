FROM rocker/shiny

# Install system requirements for index.R as needed
RUN apt-get update && apt-get install -y 

COPY ./app/install_deps.R /tmp/install_deps.R
RUN Rscript /tmp/install_deps.R

#COPY Rprofile.site /etc/R
RUN install2.r --error --skipinstalled \
    shiny 

COPY ./app/* /srv/shiny-server/

USER shiny

EXPOSE 3838

# https://stackoverflow.com/questions/66392202/run-shiny-server-on-different-port-than-3838

ENTRYPOINT ["/usr/bin/shiny-server"]