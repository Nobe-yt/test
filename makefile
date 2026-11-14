APP_NAME  := httpserver
MAIN_FILE := main.go
GO        := go
PORT      ?= 8080
BIN_DIR   := bin

.DEFAULT_GOAL := help

.PHONY: help init run build test fmt vet tidy clean

help: ## 显示帮助
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-8s\033[0m %s\n", $$1, $$2}'

init: ## 初始化 go.mod（首次使用）
	$(GO) mod init $(APP_NAME)

run: ## 本地运行（默认端口 8080）
	PORT=$(PORT) $(GO) run $(MAIN_FILE)

build: ## 编译到 bin/ 目录
	$(GO) build -o $(BIN_DIR)/$(APP_NAME) $(MAIN_FILE)

test: ## 运行测试
	$(GO) test ./...

fmt: ## 格式化代码
	$(GO) fmt ./...

vet: ## 静态检查
	$(GO) vet ./...

tidy: ## 整理依赖
	$(GO) mod tidy

clean: ## 清理构建产物
	rm -rf $(BIN_DIR)
