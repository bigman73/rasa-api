FROM python:2.7.13

RUN pip install git+https://github.com/mit-nlp/MITIE.git \
    && cd /usr/src \
    && git clone https://github.com/golastmile/rasa_nlu.git \
    && git clone https://github.com/mit-nlp/MITIE.git \
    && cd MITIE \
    && make MITIE-models \
    && mv MITIE-models/english/total_word_feature_extractor.dat ../rasa_nlu/data/total_word_feature_extractor.dat \
    && cd ../rasa_nlu \
    && python setup.py install \
    && mkdir models

WORKDIR /usr/src/rasa_nlu

COPY ./files/ .

RUN pip install -r "./requirements.txt"

RUN chmod +x ./start.sh && ls -la

EXPOSE 5000
VOLUME [ "/usr/src/rasa_nlu/models" ]

ENTRYPOINT [ "./start.sh" ]
CMD [ "start" ]