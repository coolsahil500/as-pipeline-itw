### STAGE 1: Build ###
FROM node:22-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install     # This installs Vite from devDependencies

COPY . .
RUN npm run build   # This generates /app/dist

### STAGE 2: Serve ###
FROM nginx:1.17.1-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
