# SN Grader

A script to automate the checking of code quality for StarkNet Smart Contracts.

## Setup

Install System Dependencies:

```bash
sudo apt install curl jq git
curl -L https://raw.githubusercontent.com/software-mansion/protostar/master/install.sh | bash
source ~/.bashrc
```

Install Python Dependencies:

```bash
pip3 install amarna cairo-lang
```

## Parse Amarna Sarif

Open the `out.sarif` file with the VS Code extenstion: MS-SarifVSCode.sarif-viewer
