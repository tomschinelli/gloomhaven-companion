FROM node:20-alpine as build


WORKDIR /app

COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . ./
RUN ls -la
RUN npm run build


#ENTRYPOINT ["node","build"]


FROM node:20-alpine
COPY --from=build /app/build /app/
COPY --from=build /app/package.json /app/package.json
ENTRYPOINT ["node" ,"/app"]