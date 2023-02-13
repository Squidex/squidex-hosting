FROM mcr.microsoft.com/dotnet/sdk:7.0

RUN apt-get update \
 && apt-get -f install \
 && apt-get -y install wget gnupg2 apt-utils

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
 && apt-get update \
 && apt-get install -y google-chrome-unstable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf --no-install-recommends \
 && rm -rf /var/lib/apt/lists/*

 ENV PUPPETEER_EXECUTABLE_PATH "/usr/bin/google-chrome-unstable"