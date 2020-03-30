FROM node:10

WORKDIR /usr/src/app

# I could use a package.json file but
# I want to install powerbi as global.
# COPY package*.json ./
# RUN npm install

# Install pbiviz in the global cache
RUN npm install -g powerbi-visuals-tools

COPY . .

EXPOSE 8080
