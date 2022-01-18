FROM python:3.9.6-buster
#ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1
RUN apt-get update -y
RUN apt-get install -y python3 python-pip-whl python3-pip wget build-essential automake
WORKDIR /app

COPY ./ta-lib-0.4.0-src.tar.gz /app/
RUN tar -xzf ta-lib-0.4.0-src.tar.gz \
&& cd ta-lib/ \
   && wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' -O './config.guess' \
   && wget 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD' -O './config.sub' \
   && ./configure --prefix=/usr \
   && make \
   && make install

ENV LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

RUN pip install --upgrade pip
RUN pip3 install cryptography==2.8
RUN pip3 install ta-lib
COPY ./app/requirements.txt /app/
RUN pip3 install -r requirements.txt

EXPOSE 5000

CMD ["gunicorn", "-b", "0.0.0.0:5000", "wsgi:app"]