FROM golang:1.12.0-alpine3.9 as buildStage
RUN mkdir /app
ADD . /app
WORKDIR /app
## Add this go mod download command to pull in any dependencies
RUN go mod download
## Our project will now successfully build with the necessary go libraries included.
RUN go build -o helloServer .
## Our start command which kicks off
## our newly created binary executable
CMD ["/app/main"]

FROM scratch AS exportStage
COPY --from=buildStage app/helloServer .
