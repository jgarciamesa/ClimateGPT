#!/bin/bash

YELLOW='\033[1;33m'
NC='\033[0m' # No Color

Check if hostname contains "login"
if [[ $HOSTNAME == *"login"* ]]; then
	echo -e "${YELLOW}Cannot run on $HOSTNAME, please start on a compute node.${NC}"
	exit 1
fi

echo -e "${YELLOW}Starting climateGPT. The process takes several minutes, please be patient...${NC}"
module load mamba/latest >/dev/null 2>&1
source activate climateGPT
python3 -m fastchat.serve.controller >/dev/null 2>&1 &
sleep 60s
echo -e "${YELLOW}Loading model...${NC}"
python3 -m fastchat.serve.model_worker --model-path /scratch/dshah47/.cache/models--mbzuai-oryx--ClimateGPT  >/dev/null 2>&1 &
sleep 90s
echo -e "${YELLOW}Launching Gradio interface...${NC}"
python3 -m fastchat.serve.gradio_web_server > .climategpt.tmp 2>&1 &
sleep 90s
echo "Please click on the link below"
grep "Running on public URL:" .climategpt.tmp
echo "Remember to stop the climateGPT background services with \`bash stop-climateGPT.sh\`"
