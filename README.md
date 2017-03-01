# rasa-api

This is a custom Dockerfile for the [Rasa.ai](https://rasa.ai) libraries. It has the MITIE model pre-downloaded. Also the directory where trained models are stored is available as a shared volume at `/usr/src/rasa_nlu/models`.

My usage of it flows somewhat like this:
1) start the container
```
docker run -p5000:5000 -v/local/path/or/volume/to/models:/usr/src/rasa_nlu/models --name rasa-api samtecspg/rasa-api:latest start
```

2) Train some data using the endpoint `http://localhost:5000/train`. See the rasa.ai docs for training formats. The model should appear in the folder or volume you mounted in the above command.

3) Stop and remove the running container.

<kbd>ctrl</kbd> + <kbd>c</kbd>
```
docker rm rasa-api
```

4) Start a new rasa-api container and specify the new model directory
```
docker run -p5000:5000 -v/local/path/or/volume/to/models:/usr/src/rasa_nlu/models --name rasa-api samtecspg/rasa-api:latest start --server_model_dir=/usr/src/rasa_nlu/models/model_XXXXXXX-XXXXXX
```
