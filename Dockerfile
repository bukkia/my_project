# Base image: Official Jenkins LTS
FROM jenkins/jenkins:lts

# Switch to root to install tools
USER root

# Install Docker, Python3, pip and venv
RUN apt-get update && \
    apt-get install -y docker.io python3 python3-pip python3-venv && \
    usermod -aG docker jenkins && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create app directory and working dir
RUN mkdir -p /app
WORKDIR /app

# Create virtual environment and install dependencies inside it
COPY requirements.txt /app/
RUN python3 -m venv /app/venv && \
    /app/venv/bin/pip install --no-cache-dir -r requirements.txt

# Copy the rest of your project files
COPY . /app

# Set virtual environment path in PATH
ENV PATH="/app/venv/bin:$PATH"

# Switch back to Jenkins user
USER root

# Base image: Official Jenkins LTS
FROM jenkins/jenkins:lts

# Switch to root to install Docker CLI
USER root
