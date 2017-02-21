# rasa-api

This is a custom Dockerfile for the [Rasa.ai](https://rasa.ai) libraries. It has the MITIE model pre-downloaded. Also the directory where trained models are stored is available as a shared volume at `/usr/src/rasa_nlu/availableModels` and the active model needs to be located in `/usr/src/rasa_nlu/selectedModel`.

The exposed volumes allow model management. 
