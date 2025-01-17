FROM ubuntu:22.04

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --no-install-recommends\
    build-essential cmake git \
    lsb-release wget software-properties-common gnupg \
    tzdata \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/

RUN wget https://apt.llvm.org/llvm.sh && \
    chmod +x llvm.sh && \
    ./llvm.sh 18 && \
    apt-get install -y clang-tidy-18

COPY . /clang_tidy_review/

RUN python3 -m pip install --upgrade pip && \
    python3 -m pip install /clang_tidy_review/post/clang_tidy_review

ENTRYPOINT ["review"]
