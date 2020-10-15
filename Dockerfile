FROM python:3.7.3

ARG geonames_username
ENV GEONAMES_USERNAME=$geonames_username

RUN useradd -d /home/flaskapp flaskapp

#RUN apt-get update && apt-get upgrade -y

WORKDIR /home/flaskapp

COPY config.py config.py
COPY requirements.txt requirements.txt
COPY reconcile.py reconcile.py
COPY text.py text.py
COPY lc_parse.py lc_parse.py

RUN pip install -r requirements.txt

ENV FLASK_APP reconcile.py

RUN chown -R flaskapp:flaskapp ./

USER flaskapp

EXPOSE 5000

ENTRYPOINT ["python"]

CMD ["reconcile.py"]
