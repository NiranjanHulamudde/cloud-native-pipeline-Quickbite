FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm ci 

FROM node:20-alpine AS runner

WORKDIR /usr/src/app


COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY . .

EXPOSE 4000

ENV NODE_ENV=production

CMD ["npm", "run", "server"]

