FROM rust:1.64 as builder

WORKDIR /usr/src/app
COPY . .
RUN cargo install --path .

FROM debian:buster-slim
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/cargo/bin/buildtest /usr/local/bin/buildtest

WORKDIR /

EXPOSE 8000
CMD ["buildtest"]

