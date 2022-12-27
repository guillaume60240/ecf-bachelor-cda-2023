ARG BUILDPLATFORM=linux/amd64
ARG NODE_VERSION=18.12-alpine
ARG NGINX_VERSION=stable-alpine
ARG APP_VERSION=0.0.0

# app dependencies
FROM --platform=${BUILDPLATFORM} node:${NODE_VERSION} as package
WORKDIR /home/node/ecf-mobile-desktop

RUN echo "Install dependencies"
ADD ./package.json ./
RUN npm install

# build ionic app
FROM package as builder
ARG ENVIRONMENT=production
WORKDIR /home/node/ecf-mobile-desktop

ADD ./ ./
RUN cp .env .env.local || cp .env.dist .env.local
RUN echo "Build app"
RUN npm run build

RUN echo "Build app capacitor"
RUN npm run capacitor:build

RUN echo "Copying files"
RUN cp -r ./dist ./electron/app

RUN echo "Installing electron dependencies"
RUN npm --prefix ./electron install

RUN echo "Building electron app"
RUN npm --prefix ./electron run build && npm --prefix ./electron run electron:make

# production image
FROM --platform=${BUILDPLATFORM} nginx:$NGINX_VERSION as production
ARG APP_VERSION
WORKDIR /app
ENV APP_VERSION=${APP_VERSION}
ENV APP_NAME=ecf-mobile-desktop

RUN sed -i '1idaemon off;' /etc/nginx/nginx.conf
ADD ./spa.nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /home/node/ecf-mobile-desktop/dist/ ./

EXPOSE 80
CMD ["nginx"]