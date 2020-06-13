# Use an existing base image
FROM alpine

# Install dependencies
RUN apk add --update redis

# Tell the image what to do when it starts up
CMD ["redis-server"]