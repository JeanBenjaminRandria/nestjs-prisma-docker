FROM node AS deps
RUN mkdir -p /app
WORKDIR /app

# A wildcard is used to ensure both package.json AND package-lock.json are copied
COPY package.json yarn.lock ./
COPY prisma ./prisma/

# Install app dependencies
RUN yarn add glob rimraf
#RUN yarn install --frozen-lockfile
RUN yarn install --immutable

FROM node AS builder
# Create app directory
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

#RUN yarn prisma:generate
RUN yarn prisma:generate
# build project
RUN yarn build


FROM node AS runner
WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json
COPY --from=builder /app/yarn.lock ./yarn.lock
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/prisma ./prisma/

EXPOSE 3000
#CMD [ "yarn","run","start:prod" ]
#CMD ["node", "dist/main"]
CMD ["yarn", "start"]