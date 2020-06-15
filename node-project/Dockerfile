# Base image
FROM node:alpine

# Specify the working directory, if it doesn't exit docker will create it
WORKDIR /usr/app

# Copy only the package.json file to minimize the rebuilds and cache busting
COPY ./package.json .

# Install dependencies mentioned in package.json file using npm
RUN npm install

# Copy current directory files to the working directory of the docker
COPY . .

# Configure the start up command
CMD ["npm", "start"]


