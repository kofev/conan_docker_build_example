FROM arm64v8/ubuntu:24.04

ARG TZ=Europe/Moscow
ARG UNAME=docker
ARG GNAME=docker
ARG UID=1234
ARG GID=4321

# Set path to python packages
ENV PATH="$PATH:~/.local/bin/"

# Set timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add docker user
RUN groupadd -g $GID -o $GNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

# Install necessary packages
RUN DEBIAN_FRONTEND=noninteractive apt update
RUN DEBIAN_FRONTEND=noninteractive apt upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt install gcc g++ make build-essential cmake pipx mc -y
RUN DEBIAN_FRONTEND=noninteractive apt clean && rm -rf /var/lib/apt/lists/*

# Set default user
USER $UNAME

# Set working directory
WORKDIR /home/$UNAME/src/

# Install conan
RUN pipx install conan

