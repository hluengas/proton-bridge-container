# GoLang Build Image
FROM docker.io/library/golang:latest AS build

# Install Build Dependencies
RUN apt-get update && \
    apt-get install -y libsecret-1-dev

# Version Variable
ENV BRIDGE_VERSION="3.4.2"

# Build Source
WORKDIR /build/
RUN git clone https://github.com/ProtonMail/proton-bridge.git && \
    cd proton-bridge && \
    git checkout v${BRIDGE_VERSION} && \
    make build-nogui

# Fedora Base Image
FROM registry.fedoraproject.org/fedora:39

# Install dependencies
# Install dependencies and protonmail bridge
RUN dnf upgrade --refresh -y && \
    dnf install -y \
    dbus-x11 \
    expect \
    gnome-keyring \
    libsecret

# Copy Binaries From Build Stage
COPY --from=build /build/proton-bridge/proton-bridge /proton/
COPY --from=build /build/proton-bridge/bridge /proton/

# Copy scripts
COPY ./scripts /proton/scripts
RUN ["chmod", "-R", "+x", "/proton"]

# Start Protonmail-Bridge
CMD ["/proton/scripts/entrypoint.sh"]
