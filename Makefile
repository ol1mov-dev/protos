USER_PROTO_DIR=user/v1
USER_OUT_DIR=pkg/user/v1

PRODUCT_PROTO_DIR=product/v1
PRODUCT_OUT_DIR=pkg/product/v1

.PHONY: proto, clean

proto:
	make user-proto
	make product-proto

user-proto:
	@echo "Generate user folders"
	mkdir -p pkg/user/v1

	@echo "🧩 Generating user gRPC code from proto files..."
	protoc \
		--proto_path=$(USER_PROTO_DIR) \
		--go_out=$(USER_OUT_DIR) \
		--go-grpc_out=$(USER_OUT_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_opt=paths=source_relative \
		$$(find $(USER_PROTO_DIR) -name "*.proto")
	@echo "✅ Generation complete!"

product-proto:
	@echo "Generate product folders"
	mkdir -p pkg/product/v1

	@echo "🧩 Generating product gRPC code from proto files..."
	protoc \
		--proto_path=$(PRODUCT_PROTO_DIR) \
		--go_out=$(PRODUCT_OUT_DIR) \
		--go-grpc_out=$(PRODUCT_OUT_DIR) \
		--go_opt=paths=source_relative \
		--go-grpc_opt=paths=source_relative \
		$$(find $(PRODUCT_PROTO_DIR) -name "*.proto")
	@echo "✅ Generation complete!"

clean:
	rm -rf pkg/user
	rm -rf pkg/product
