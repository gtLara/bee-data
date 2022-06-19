To Bee or Not To Bee
==============================

Detecção de abelhas em som ambiental

Organização de Projeto
------------

    ├── data
    │   ├── processed <- Dados processados
    │   │    ├── audio <- Clipes segmentados
    │   │    ├── spectrogram <- Espectrogramas de clipes
    │   │    └── metadata.csv <- Arquivo de metadados
    │   │
    │   └── raw <- Dados originais, imutáveis
    │
    ├── requirements.txt <- Arquivo de pacotes python necessários
    │
    └─ src <- Código fonte
        │
        └── data <- Scripts para baixar, gerar ou transformar dados
           │
           ├── get_raw_data.sh <- Script para baixar dados de Zenodo (1)
           │
           ├── process_raw_data.sh <- Script para segmentar dados em clipes (2)
           │
           └── generate_spectrograms.sh <- Script para gerar espectrogramas a partir de dados (3)


--------

<p><small>Estrutura de projeto baseado em <a target="_blank" href="https://drivendata.github.io/cookiecutter-data-science/">cookiecutter data science project template</a>. #cookiecutterdatascience</small></p>
