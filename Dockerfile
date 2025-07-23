### STAGE 1: Build ###
FROM 339713011246.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app-repo:22-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

### STAGE 2: Serve ###
FROM 339713011246.dkr.ecr.ap-south-1.amazonaws.com/nodejs-app-repo:22-alpine

RUN apk update && apk add --no-cache nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80  # Match nginx.conf if using `listen 80`

CMD ["nginx", "-g", "daemon off;"]
