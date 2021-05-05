FROM squidex/squidex:dev-2273

RUN apk update \
 && apk add --no-cache busybox \
 && apk add --no-cache wget

RUN mkdir -p plugins/sendgrid \
 && wget -qO- https://github.com/squidexcontrib/sendgrid/releases/download/plugin1.0/sendgrid.zip | busybox unzip -q -d plugins/sendgrid -

RUN ls /app/plugins/sendgrid

ENV PLUGINS__1 /app/plugins/sendgrid/publish/Squidex.Extensions.SendGrid.dll