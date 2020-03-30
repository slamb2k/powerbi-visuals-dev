FROM node:10

WORKDIR /usr/src/app

# Install pbiviz in the global cache
RUN npm install -g powerbi-visuals-tools

COPY . .

EXPOSE 8080

RUN ["./install.sh"]
