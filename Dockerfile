FROM --platform=linux/amd64 golang:1.22 AS base

WORKDIR /app

COPY go.mod ./
RUN go mod download
COPY . .

RUN GOARCH=amd64 GOOS=linux go build -o main .

FROM --platform=linux/amd64 gcr.io/distroless/base

COPY --from=base /app/main .
COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
