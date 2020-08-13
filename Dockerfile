# dockerfile
# build stage
FROM node:lts-alpine as build-stage
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN cnpm run build

# production stage
FROM nginx:stable-alpine as production-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
