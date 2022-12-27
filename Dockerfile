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

# build capacitor app
FROM builder as capacitor
ARG ENVIRONMENT=production
WORKDIR /home/node/ecf-mobile-desktop
RUN echo "Build capacitor app"
RUN npm run capacitor:build

# production image
FROM --platform=${BUILDPLATFORM} nginx:$NGINX_VERSION as production
ARG APP_VERSION
WORKDIR /app
ENV APP_VERSION=${APP_VERSION}
ENV APP_NAME=ecf-mobile-desktop

# Copy the .apk to /app/tempory/
RUN echo "Copying apk to root project"
COPY --from=capacitor /home/node/ecf-mobile-desktop/android/app/build/outputs/apk/debug/app-debug.apk /app/artifacts/app-debug.apk

RUN sed -i '1idaemon off;' /etc/nginx/nginx.conf
ADD ./spa.nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /home/node/ecf-mobile-desktop/dist/ ./

EXPOSE 80
CMD ["nginx"]