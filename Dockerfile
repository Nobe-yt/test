FROM golang:1.25.3-alpine3.22 AS builder

WORKDIR /app

# 一次性拷贝（放弃依赖缓存层）
COPY . .

# 没有 go.mod 就初始化，然后 tidy
RUN if [ ! -f go.mod ]; then go mod init httpserver; fi && \
    go mod tidy && \
    CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/httpserver .

FROM alpine:3.22
WORKDIR /app
COPY --from=builder /app/httpserver /app/httpserver
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["/app/httpserver"]
