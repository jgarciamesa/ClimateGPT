# ClimateGPT (EMNLP 2023)
![](https://i.imgur.com/waxVImv.png)

[Sahal Shaji Mullappilly](https://scholar.google.com/citations?user=LJWxVpUAAAAJ&hl=en)* , [Abdelrahman Shaker](https://amshaker.github.io/)* , [Omkar Thawakar](https://omkarthawakar.github.io/)* , [Hisham Cholakkal](https://scholar.google.com/citations?hl=en&user=bZ3YBRcAAAAJ), [Rao Muhammad Anwer](https://scholar.google.com/citations?hl=en&authuser=1&user=_KlvMVoAAAAJ), [Salman Khan](https://salman-h-khan.github.io/), and [Fahad Shahbaz Khan](https://scholar.google.es/citations?user=zvaeYnUAAAAJ&hl=en). 

*Equal Contribution

**Mohamed bin Zayed University of Artificial Intelligence, UAE**


[![paper](https://img.shields.io/badge/Paper-EMNLP_23-blue)](https://aclanthology.org/2023.findings-emnlp.941/) <a href='#'><img src='https://img.shields.io/badge/Project-Page-Green'></a> [![YouTube](https://badges.aleen42.com/src/youtube.svg)](https://youtu.be/2NKiujOJnqI) [![YouTube](https://badges.aleen42.com/src/youtube.svg)](https://youtu.be/0CGb9jzxV1U)



## :rocket: News
<hr>

+ Jan-30 : Clima500 English Dataset is released [Clima500](https://huggingface.co/datasets/mbzuai-oryx/Clima500)

+ Oct-8 : Accepted to Findings of EMNLP 2023 [Paper Link](https://aclanthology.org/2023.findings-emnlp.941/)

+ May-20 : Our code, models, and pre-processed datasets for English version are released. We will release everything related to the Arabic version as well as the technical report soon.


## Online Demo
You can try our demo using the following links :

[ClimateGPT](https://a316ef17aba684f4f4.gradio.live).

[ClimateGPT (العربية)](https://2aa49e301e7345a655.gradio.live/).


## About ClimateGPT
<hr>

+ ClimateGPT is a specialized Language Model (LLM) developed on top of Vicuna framework and fine-tuned specifically for Climate Change and Sustainability topics in both English and Arabic languages.
+ We introduce a vector embedding and datastore framework, which can be utilized during model inference for information retrieval without the need for additional training.
+ We have generated over 500k interactive conversational-style samples (Question & Answers) based on the public benchmarks for climate change related datasets. This augmentation of interactive conversational data greatly enhances the performance of LLMs through the fine-tuning process. Our proposed dataset (Clima500) will be available on HuggingFace. The instruction for Dataset creation will be released soon.
+ To the best of our knowledge, this marks the first release substantial conversational-style Arabic dataset (Question & Answers) dedicated to climate change and sustainability, comprising over 500k samples, dedicated to climate change and sustainability. The Arabic dataset will be released soon.

![overview](assets/ClimateGPT_overall.gif)


## Getting Started
### Installation

**1. Prepare the code and the environment**

Clone the repository and create a anaconda environment

```bash
git clone https://github.com/mbzuai-oryx/ClimateGPT.git
cd ClimateGPT
conda env create -f environment.yml
conda activate climateGPT
pip install -e .
```
OR 
```bash
git clone https://github.com/mbzuai-oryx/ClimateGPT.git
cd ClimateGPT
conda create -n climateGPT python=3.8
conda activate climateGPT
pip install -r requirements.txt
pip install -e .
```

### Setup

**1. Prepare the Datasets for training**

The Clima500 Dataset, along with the dataset instructions details, will be released soon. Stay tuned for further updates!


**2. Fine-Tuned Model**

Download fine-tuned model checkpoint can be downloaded from [here](https://huggingface.co/mbzuai-oryx/ClimateGPT/tree/main).

**3. Prepare the pretrained Vicuna weights**

We built ClimateGPT on the v1.1 version of Vicuna-7B.
 
Refer the original repo for Vicuna-7B model weights [Vicuna-7B](https://github.com/lm-sys/FastChat#vicuna-7b)


### Training of ClimateGPT 

You can use the following command to train ClimateGPT with 4 x A100 (80GB).
```bash
torchrun --nproc_per_node=4 --master_port=20001 fastchat/train/train_mem.py \
    --model_name_or_path ~/path_to_model_weights/Vicuna-7B  \
    --data_path path_to_data/Clima500_en_train.json \
    --bf16 True \
    --output_dir output \
    --num_train_epochs 1 \
    --per_device_train_batch_size 2 \
    --per_device_eval_batch_size 2 \
    --gradient_accumulation_steps 16 \
    --evaluation_strategy "no" \
    --save_strategy "steps" \
    --save_steps 100 \
    --save_total_limit 1 \
    --learning_rate 2e-5 \
    --weight_decay 0. \
    --warmup_ratio 0.03 \
    --lr_scheduler_type "cosine" \
    --logging_steps 1 \
    --fsdp "full_shard auto_wrap" \
    --fsdp_transformer_layer_cls_to_wrap 'LlamaDecoderLayer' \
    --tf32 True \
    --model_max_length 2048 \
    --gradient_checkpointing True \
    --lazy_preprocess True
```

### Launching Demo (Web GUI) on local machine

Download the fine-tuned model checkpoint from [here](https://huggingface.co/mbzuai-oryx/ClimateGPT/tree/main).

Save the model checkpoint at `weights/ClimateGPT_en`

Run the following commands in separate Terminals : (see [web_run.sh](web_run.sh))

#### Launch the controller
```bash
python3 -m fastchat.serve.controller
```
#### Launch the model worker
```bash
python3 -m fastchat.serve.model_worker --model-path weights/ClimateGPT_en
```
#### Launch the Gradio Web server
```bash
python3 -m fastchat.serve.gradio_web_server
```

Refer [Gradio Web GUI](https://github.com/lm-sys/FastChat#serving-with-web-gui) for more information.

## Examples
  |   |   |
:-------------------------:|:-------------------------:
![example 1](assets/English_example_1.png) |  ![example 2](assets/English_example_2.png)
![example 3](assets/Arabic_example_1.png)  |  ![example 4](assets/Arabic_example_2.png)


## 📜 Citation
```bibtex
  @inproceedings{mullappilly2023arabic,
  title={Arabic Mini-ClimateGPT: A Climate Change and Sustainability Tailored Arabic LLM},
  author={Mullappilly, Sahal and Shaker, Abdelrahman and Thawakar, Omkar and Cholakkal, Hisham and Anwer, Rao and Khan, Salman and Khan, Fahad},
  booktitle={Findings of the Association for Computational Linguistics: EMNLP 2023},
  pages={14126--14136},
  year={2023}
}
```


## Acknowledgement
<hr>

+ [Vicuna](https://github.com/lm-sys/FastChat) : The fantastic language ability of Vicuna is just amazing. And it is open-source!
+ [ChromaDB](https://github.com/chroma-core/chroma) : Chroma - the open-source embedding database.
+ [LangChain](https://github.com/hwchase17/langchain) : Building applications with LLMs through composability

We would like to thank our colleagues at MBZUAI for their essential contribution to the Evaluation and Dataset verification tasks, including Dr. Jean Lahoud, Abdelrahman Shaker, Salwa Al Khatib, Mohamed El Amine Boudjoghra, Aisha Fahad Ahmed Ali Alraeesi, 
Amna Abdelrahim Nasir Abdalla Alhosani, Hour Eisa Abdelrahim Ahmed Mohamed, Hosam Mahmoud Abdalla Ahmed Ali Elgendy, Yahia Dalbah, Mohammed Almansoori, without which this project would not be possible.

The computational resources were provided by the National Academic Infrastructure for Supercomputing in Sweden (NAISS), partially funded by the Swedish Research Council through grant agreement no. 2022-06725, and by the Berzelius resource, provided by the Knut and Alice Wallenberg Foundation at the National Supercomputer Centre.

## License
This repository is licensed under CC BY-NC-SA. Please refer to the license terms [here](https://creativecommons.org/licenses/by-nc-sa/4.0/).
