# Use this container to build the application
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Use this container to deploy the application
FROM nginx:alpine
# Copy build files to this container using --from option
COPY --from=builder /app/build /usr/share/nginx/html
