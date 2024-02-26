FROM ubuntu:20.04 as base

RUN apt-get update && apt-get install -y python3.9 python3.9-dev
RUN pip install youtube-dl

FROM base as build


COPY . .
RUN pip install -r requirements.txt

CMD ["python"]