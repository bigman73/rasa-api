# rasa-api

This is a custom Dockerfile for the [Rasa.ai](https://rasa.ai) libraries. The directory where trained models are stored is available as a shared volume at `/usr/src/rasa_nlu/models`.

In order to get RASA working, you can follow this steps:

1) Pull (Download) the container image
There are several docker images, also known as tags, available on docker hub. See a [full list](https://hub.docker.com/r/samtecspg/rasa-api/tags/).
To pull a specific tag:
```
docker pull rasa-api samtecspg/rasa-api:<TAG_NAME>
```
For example, for the RASA_0.8.10_full tag:
```
docker pull rasa-api samtecspg/rasa-api:RASA_0.8.10_full
```
Rasa NLU docker tags are large, ~819MB, wait for the tag to full download.

2) Create and start the container
A docker conatiner needs to be created and started, using on the pulled tag (i.e. image):
```
docker run -p5000:5000 -v/local/path/or/volume/to/models:/usr/src/rasa_nlu/models --name rasa-api samtecspg/rasa-api:<TAG_NAME> start
```

3) Train some data using the endpoint `http://localhost:5000/train`. Remember to follow [rasa training format](https://rasa-nlu.readthedocs.io/en/latest/dataformat.html). You can assign a name to your model by passing a query parameter on the endpoint like this `/train?name=myModelName`.

4) To use your model, you can just GET the parse endpoint `/parse?q=hello&model=myModelName` or POST to it with a payload having this format: 
```
{
    q: textToParse,
    model: yourModelName
}
```

By default the container will start with the `spacy_sklearn` pipeline. If you want to change, do so at the [config file](./files/config.json) file.
