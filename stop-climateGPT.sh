#!/bin/bash

rm -f .climategpt.tmp
pkill -9 -f "python3 -m fastchat.serve.controller"
pkill -9 -f "python3 -m fastchat.serve.model_worker --model-path /scratch/dshah47/.cache/models--mbzuai-oryx--ClimateGPT"
pkill -9 -f "python3 -m fastchat.serve.gradio_web_server"
