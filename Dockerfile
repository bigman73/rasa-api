FROM python:2.7.13

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  git-core && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install git+https://github.com/mit-nlp/MITIE.git

RUN cd /usr/src \
    && git clone https://github.com/golastmile/rasa_nlu.git \
    && cd rasa_nlu/data \
    && wget https://s3-eu-west-1.amazonaws.com/mitie/total_word_feature_extractor.dat \
    && cd .. \
    && mkdir models

WORKDIR /usr/src/rasa_nlu

COPY ./files/ .

RUN pip install -r "./requirements.txt" \
    && python setup.py install

RUN chmod +x ./start.sh && ls -la

EXPOSE 5000
VOLUME [ "/usr/src/rasa_nlu/models" ]

ENTRYPOINT [ "./start.sh" ]
CMD [ "start" ]