FROM node:20-alpine as build

RUN npm install -g pnpm

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . ./
RUN ls -la
RUN npm run build
RUN npm prune --production


FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/build  build/
COPY --from=build /app/package.json   .
COPY --from=build /app/node_modules  node_modules/

EXPOSE 3000
ENV NODE_ENV=production
ENTRYPOINT [ "node", "build" ]
