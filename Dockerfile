### STAGE 1: Build ###
FROM 339713011246.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app-repo:22-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install     # This installs Vite from devDependencies

COPY . .
RUN npm run build   # This generates /app/dist

### STAGE 2: Serve ###
FROM 339713011246.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app-repo:22-alpine

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html
