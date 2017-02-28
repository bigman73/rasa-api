FROM python:2.7.13

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  build-essential \
  git-core && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install git+https://github.com/mit-nlp/MITIE.git \
    && cd /usr/src \
    && git clone --branch 0.6-beta https://github.com/golastmile/rasa_nlu.git \
    && git clone https://github.com/mit-nlp/MITIE.git \
    && cd MITIE \
    && make MITIE-models \
    && mv MITIE-models/english/total_word_feature_extractor.dat ../rasa_nlu/data/total_word_feature_extractor.dat \
    && cd ../rasa_nlu \
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