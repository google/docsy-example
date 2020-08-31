FROM klakegg/hugo:ext-nodejs
WORKDIR /home/docsy/app
RUN mkdir -p /home/docsy/deps
COPY package.json /home/docsy/deps/
COPY package-lock.json /home/docsy/deps/
RUN cd /home/docsy/deps/ && npm install -g
# COPY . .
CMD [ "server" ]
