# ---- 构建阶段 ----
# 锁定为 1.25.3，Alpine 版本建议一并锁定（3.22 或 3.21 均可）
FROM golang:1.25.3-alpine3.22 AS builder

WORKDIR /app

# 先拷依赖文件，利用缓存
COPY go.mod go.sum* ./
RUN go mod download

# 再拷源码
COPY . .

# 静态编译，方便在 alpine 里跑
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /app/httpserver .

# ---- 运行阶段 ----
FROM alpine:3.22

WORKDIR /app
COPY --from=builder /app/httpserver /app/httpserver

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["/app/httpserver"]
