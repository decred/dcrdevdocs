# Build image
FROM python:3.9

LABEL description="dcrdevdocs build"
LABEL version="1.0"
LABEL maintainer "holdstockjamie@gmail.com"

USER root
WORKDIR /root

RUN python -m pip install --upgrade pip

COPY ./ /root/

RUN pip install mkdocs && \
	pip install --user -r requirements.txt

RUN ./bin/build_docs.sh

# Serve image (stable nginx version)
FROM nginx:1.20

LABEL description="dcrdevdocs serve"
LABEL version="1.0"
LABEL maintainer "holdstockjamie@gmail.com"

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=0 ./root/site/ /usr/share/nginx/html
