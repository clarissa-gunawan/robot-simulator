FROM nvidia/cuda:12.8.0-devel-ubuntu24.04

# Set non-interactive mode for apt-get
RUN apt-get update && apt install -y \
    python3 \
    python3-pip \
    python3-venv \
    libglfw3 \
    libglew2.2 \
    libglew-dev \
    libosmesa6-dev \
    zlib1g-dev \
    patchelf \
    ffmpeg \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# ARG USER="base"
# ENV HOME=/home/${USER}
    

# RUN addgroup --gid 5555 ${USER} && \
#     useradd --create-home --shell /bin/bash --uid 1111 -g ${USER} ${USER} && \
#     usermod -a -G sudo ${USER} && \
#     passwd -d ${USER} && \
#     printf '%sudo ALL=(ALL) NOPASSWD:ALL\n' >> /etc/sudoers && \
#     chown -R ${USER}:${USER} ${HOME} && \
#     mkdir -p -m 0700 /run/user/1111 && \
#     chown -R ${USER}:${USER} /run/user/1111

# ENV XDG_RUNTIME_DIR=/run/user/1111

# USER ${USER}

WORKDIR /app

# Python Environment
RUN python3 -m venv venv
COPY ./requirements.txt /app/requirements.txt
RUN venv/bin/pip install -r /app/requirements.txt
ENV PATH="/app/venv/bin:$PATH"

COPY ./entrypoint.sh entrypoint.sh
RUN ["chmod", "+x", "/app/entrypoint.sh"]
ENTRYPOINT [ "./entrypoint.sh" ]

COPY ./simulator /app/simulator

CMD ["/bin/bash"]