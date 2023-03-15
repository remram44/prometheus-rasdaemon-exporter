FROM python:3.10

# Copy
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY setup.cfg setup.py README.md ./
COPY prometheus_rasdaemon_exporter ./prometheus_rasdaemon_exporter

ENV VERSION 0.1.0

# Install
RUN cat setup.cfg | sed -e "/^author = /a version = $VERSION" -e '/^setup_requires =/d' -e '/^  setuptools_scm/d' > setup.cfg.new && mv setup.cfg.new setup.cfg
RUN pip --disable-pip-version-check install --no-cache-dir -e .

ENV PYTHONFAULTHANDLER=1

EXPOSE 9445
CMD ["prometheus-rasdaemon-exporter"]
