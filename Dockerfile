FROM ubuntu:20.04 as base

RUN apt-get update && apt-get install -y python3.10

RUN wget -O /tmp/script.py https://bootstrap.pypa.io/get-pip.py
RUN python /tmp/script.py

RUN pip install youtube-dl

FROM base as build

WORKDIR /app
COPY . .
RUN pip install -r requirements.txt

FROM build as final

WORKDIR /app
COPY --from=build /app /app

RUN mkdir /app/config
VOLUME [ "/app/config" ]

ENTRYPOINT [ "python", "main.py"]