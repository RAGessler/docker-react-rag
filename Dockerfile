#Build Enviornment
#Node version #16
FROM node:alpine as build

WORKDIR /app

#ENV Path
COPY package.json ./
COPY package-lock.json ./

RUN npm ci

COPY ./ ./
RUN npm run build

#* production enviornment

FROM nginx:alpine as prod
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD [ "nginx", "-g", "daemon off;" ]