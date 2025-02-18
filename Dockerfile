# Use an official Python runtime as the base image

FROM python:3.9-slim

# Set the working directory in the container

WORKDIR /app

# install required packages for system

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# apt-get update & apt-get upgrade -- updates the packages list and upgrade the packages with latest versions

# apt-get install gcc -- Installs GCC, which is a GNU compiler Collection for compiling C extensions

# default-libmysqlclient-dev -- MYSQL dev libraries for MYSQL DATABASE connections

# rm -rf /var/lib/apt/lists/* - cleans up the package cache to reduce the docker image size


# Copy the requirements file into the container

COPY requirements.txt .

# Install app dependencies

RUN pip install mysqlclient

RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code

COPY . .

# Specify the command to run your application

CMD ["python", "app.py"]

