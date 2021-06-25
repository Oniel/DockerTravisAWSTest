FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# With this new FROM we're saying we're done with the section above and about to do something new
# You can think of FROM as a break
FROM nginx

# copy from the 'builder' phase from the build output to the nginx location
COPY --from=builder /app/build /usr/share/nginx/html