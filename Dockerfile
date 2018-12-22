FROM alpine:3.7

# File Author / Maintainer
LABEL authors="majid Rehman <majid.rehman@locopixel.com>"

# Update & install required packages
RUN apk add --update nodejs bash git

# Install app dependencies
COPY package.json /www/package.json
RUN cd /www; npm install

# Copy app source
COPY . /www

# Set work directory to /www
WORKDIR /www

# set node env
# ENV NODE_ENV production

# set your port
ENV PORT 8083

# expose the port to outside world
EXPOSE  8083

# start command as per package.json
CMD npm run start