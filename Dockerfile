# Build stage
FROM node:20-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npx parcel build "src/*.html" --dist-dir ./dist --public-url ./

# Serve stage
FROM nginx:1.29.3-alpine
COPY --from=build-stage /app/dist/ /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
