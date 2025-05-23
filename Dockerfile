FROM rust:1.70 as builder

WORKDIR /usr/src/app
COPY . .
RUN cargo build --release

FROM debian:bullseye-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/src/app/target/release/kora-rpc /usr/local/bin/json_rpc_server

EXPOSE 3030
CMD ["json_rpc_server"]
