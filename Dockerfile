FROM node:20-alpine AS development-dependencies-env
RUN apk add --no-cache sqlite
COPY . /app
WORKDIR /app
RUN npm install

FROM node:20-alpine AS production-dependencies-env
COPY ./package.json /app/
WORKDIR /app
RUN npm install --omit=dev

FROM node:20-alpine AS build-env
COPY . /app/
COPY --from=development-dependencies-env /app/node_modules /app/node_modules
WORKDIR /app
# Generate Prisma client and run migrations
RUN npx prisma generate
RUN npm run build

FROM node:20-alpine
RUN apk add --no-cache sqlite openssl
COPY ./package.json /app/
COPY --from=production-dependencies-env /app/node_modules /app/node_modules
COPY --from=build-env /app/build /app/build
COPY --from=build-env /app/prisma /app/prisma
# Copy the generated Prisma client from custom output directory
COPY --from=build-env /app/generated /app/generated
WORKDIR /app
# Run migrations on startup
CMD ["sh", "-c", "npx prisma migrate deploy && npm run start"]