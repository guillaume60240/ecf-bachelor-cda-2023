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

# RUN echo "Copying files"
# RUN cp -r ./dist ./electron/app

# RUN echo "Installing electron dependencies"
# RUN npm --prefix ./electron install

# RUN echo "Building electron app"
# RUN npm --prefix ./electron run build && npm --prefix ./electron run electron:make

# production image
FROM --platform=${BUILDPLATFORM} nginx:$NGINX_VERSION as production
ARG APP_VERSION
WORKDIR /app
ENV APP_VERSION=${APP_VERSION}
ENV APP_NAME=ecf-mobile-desktop


# RUN echo "Copying apk to root project"
# COPY --from=builder /home/node/ecf-mobile-desktop/android/app/build/outputs/apk/debug/app-debug.apk ./app-debug.apk
# RUN cp --from=builder  /home/node/ecf-mobile-desktop/android/app/build/outputs/apk/debug/app-debug.apk ./app-mobile-lastest.apk
# Récupération de l'ID du conteneur builder en utilisant docker inspect
# RUN CONTAINER_ID=$(docker inspect --format='{{.Id}}' builder)

# Copie du fichier /home/node/ecf-mobile-desktop/android/app/build/outputs/apk/debug/app-debug.apk du conteneur builder vers l'hôte
# RUN docker cp $CONTAINER_ID:/home/node/ecf-mobile-desktop/android/app/build/outputs/apk/debug/app-debug.apk ~desktop/build/app-mobile-lastest.apk
# Copy the .apk to /app
COPY --from=capacitor /home/node/ecf-mobile-desktop/android/app/build/outputs/apk/debug/app-debug.apk /app/app-mobile-lastest.apk

RUN sed -i '1idaemon off;' /etc/nginx/nginx.conf
ADD ./spa.nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /home/node/ecf-mobile-desktop/dist/ ./

EXPOSE 80
CMD ["nginx"]