# This file is the copy of ./frontend/Dockerfile to deploy application to aws
# Use this container to build the application
FROM node:alpine
WORKDIR /app
COPY ./frontend/package.json ./
RUN npm install
COPY ./frontend ./
RUN npm run build

# Use this container to deploy the application
FROM nginx:alpine
# Expose port 80 to view the application
EXPOSE 80
# Copy build files to this container using --from option
COPY --from=0 /app/build /usr/share/nginx/html
