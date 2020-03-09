#################################################################
# USING GUIDE:
#
# docker build --build-arg CODE_URL=http://git.sth -t image/tag .
# 
#################################################################

######################################
# STEP 1 build executable binary
######################################

FROM golang:alpine AS builder

ARG CODE_URL
ARG CODE_DIR

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git

# Create appuser.
RUN adduser -D -g '' mio

RUN git clone ${CODE_URL} /build/src
VOLUME /build
WORKDIR /build/src/${CODE_DIR}

# Fetch dependencies.
# Using go get.
RUN go get -d -v

# Using go mod.
# RUN go mod download
# Build the binary.
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o /build/bin/main

############################
# STEP 2 build a small image
############################
FROM scratch

# Import the user and group files from the builder.
COPY --from=builder /etc/passwd /etc/passwd

# Copy our static executable.
COPY --from=builder /build/bin/main /go/bin/main

# Use an unprivileged user.
USER mio

# Run the hello binary.
ENTRYPOINT ["/go/bin/main"]