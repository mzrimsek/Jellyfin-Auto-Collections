FROM ubuntu:20.04 as base

RUN apt-get update && apt-get install -y python3.9 python3.9-dev
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

CMD ["python", "main.py"]