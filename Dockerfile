FROM madnificent/elixir-server:1.13.0

# OpenShift runs containers as an arbitrary UID in group 0 with HOME=/.
# Keep using /root (where mix/hex live) and make it and /app group-accessible.
ENV HOME=/root

RUN sed -i "2i\\cp /config/dispatcher.ex /app/lib/dispatcher.ex" /startup.sh \
  && sed -i "2i\\sh /app/own-build.sh" /startup.sh

ADD . /app

RUN sh /setup.sh \
  && chgrp -R 0 /root /app \
  && chmod -R g=u /root /app
