# rasa-api

This is a custom Dockerfile for the [Rasa.ai](https://rasa.ai) libraries. The directory where trained models are stored is available as a shared volume at `/usr/src/rasa_nlu/models`.

In order to get RASA working, you can follow this steps:

1) start the container
```
docker run -p5000:5000 -v/local/path/or/volume/to/models:/usr/src/rasa_nlu/models --name rasa-api samtecspg/rasa-api:latest start
```

2) Train some data using the endpoint `http://localhost:5000/train`. Remember to follow [rasa training format](https://rasa-nlu.readthedocs.io/en/latest/dataformat.html). You can assign a name to your model by passing a query parameter on the endpoint like this `/train?name=myModelName`.

3) To use your model, you can just GET the parse endpoint `/parse?q=hello&model=myModelName` or POST to it with a payload having this format: 
```
{
    q: textToParse,
    model: yourModelName
}
```

By default the container will start with the `spacy_sklearn` pipeline. If you want to change, do so at the [config file](./files/config.json) file.