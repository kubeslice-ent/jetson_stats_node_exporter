## Dockerfile for Jetson Stats Node Exporter
# sources: https://rnext.it/jetson_stats/docker.html
#          https://github.com/laminair/jetson_stats_node_exporter
# Usage: See git hub documentation

# Base image, Python image
FROM python:3.11-slim

# Set environment variables (prevents writing .pyc files and buffering of stdout and stderr)
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies (including gcc and python3-dev and curl-->for docker-healthcheck) and clean up to reduce image size
RUN apt-get update && apt-get install -y gcc python3-dev curl && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install the Jetson Stats Node Exporter
# Define build argument for the version
# --> Insert the correct version you want to install and which fits your system requirements. Especially the compatibility with jetson-stats (jtop)
ARG JSN_RELEASE="0.1.3"
# working ="0.1.0" with jetson-stats==4.2.9 --> install with sudo pip install jetson-stats==4.2.9
# working ="0.0.6" with jetson-stats==4.2.6
# check version with jtop --version

# Install the Jetson Stats Node Exporter via .tar.gz using the ARG:
RUN pip3 install -U https://github.com/laminair/jetson_stats_node_exporter/archive/refs/tags/v${JSN_RELEASE}.tar.gz


# Set the start command
ENTRYPOINT ["python3", "-m", "jetson_stats_node_exporter"]

CMD []
