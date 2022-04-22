# Marketplace Builder

For quick prototyping or to learn how the Vultr Marketplace works, you can use the [Vultr Marketplace Builder](/marketplace-builder). It creates Vultr Marketplace snapshots with the correct version of cloud-init installed. Marketplace Builder can create snapshots for:

* CentOS 7
* CentOS 8
* Debian 10
* Ubuntu 18.04 LTS
* Ubuntu 20.04 LTS

## Requirements

Marketplace Builder runs in `bash` or `zsh`. It has been tested on macOS, Ubuntu 20.04, and Windows using Ubuntu under WSL.

1. Install [HashiCorp Packer](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli).
1. Verify your workstation's IP address is in your [Vultr API access control list](https://my.vultr.com/settings/#settingsapi).
1. Publish your API key.

        $ export VULTR_API_KEY=<Your API Key>

1. If you desire a debug log, export these two variables:

        $ export PACKER_LOG=1
        $ export PACKER_LOG_PATH=packer.log

## Instructions

1. Clone this repository to your workstation.

        $ git clone https://github.com/vultr/vultr-marketplace.git

1. Run the Marketplace Builder.

        $ cd vultr-marketplace/marketplace-builder
        $ ./marketplace-builder.sh

The Marketplace Builder prompts you to select one OS or build all snapshots in a batch. When finished, the script creates snapshots named `Squidex-<OS> <Date Time>` in your Vultr account, ready to be added to the Vultr Marketplace.

