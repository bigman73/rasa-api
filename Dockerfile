# This is a hodge-podge of stuff from a "pre-rasa-having-a-docker-stuff" config and the
# docker files that are part of the 0.8.6 release (Dockerfile, Dockerfile_full - combining those two)
#... so posible this config could introduce bugs
#

FROM python:2.7-slim

# unsure if this does anything, but mirroring the 0.8.6 Dockerfile
ENV RASA_NLU_DOCKER="YES" \
    RASA_NLU_PREFIX=/usr/src

ENV RASA_NLU_HOME=${RASA_NLU_PREFIX}/rasa_nlu

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential git-core wget && \
    apt-get clean 

RUN cd ${RASA_NLU_PREFIX} && \
    git clone https://github.com/golastmile/rasa_nlu.git && \
    cd ${RASA_NLU_HOME} && \
    git checkout tags/0.8.9 && \
    mkdir models && \
    wget -P data/ https://s3-eu-west-1.amazonaws.com/mitie/total_word_feature_extractor.dat 

WORKDIR ${RASA_NLU_HOME}

COPY ./files/ .

RUN pip install -r "${RASA_NLU_HOME}/requirements.txt" 

RUN python setup.py install

# dev-requirements.txt includes MITIE, its not version locked, to lock use "files" to replace
#  dev-requirements.txt, and use the https://stackoverflow.com/a/13754517/3334178 release lock
#  (spacy is also in dev-requirements.txt but its version locked)
RUN pip install -r dev-requirements.txt && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN pip install https://github.com/explosion/spacy-models/releases/download/en_core_web_sm-1.2.0/en_core_web_sm-1.2.0.tar.gz --no-cache-dir > /dev/null \
    && python -m spacy link en_core_web_sm en


RUN chmod +x ./start.sh && ls -la

EXPOSE 5000
VOLUME [ "/usr/src/rasa_nlu/models" ]

ENTRYPOINT [ "./start.sh" ]
CMD [ "start" ]
