# SN Grader

A script to automate the checking of code quality for StarkNet Smart Contracts.

## Setup

***system***

```bash
sudo apt install curl jq git
```

***protostar***

```bash
curl -L https://raw.githubusercontent.com/software-mansion/protostar/master/install.sh | bash
source ~/.bashrc
```

***python***

```bash
pip3 install amarna cairo-lang
```

## Usage

Pass the github organization and repo name to the script. Example:

```bash
# ex - ./sn-grader.sh chee-chyuan buidl_guild_cairo
git clone https://github.com/starknet-edu/sn-grader.git
cd sn-grader
./sn-grader.sh <ORG_NAME> <REPO_NAME>
```

## Parse Amarna Sarif

Open the `out.sarif` file with the VS Code extenstion: MS-SarifVSCode.sarif-viewer
