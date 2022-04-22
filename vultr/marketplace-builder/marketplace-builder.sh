#!/bin/bash

echo ""
echo "Checking dependencies."
echo ""
#################################
## Test API access
if [[ -z "${VULTR_API_KEY}" ]]; then
  echo ""
  echo "Please export your API key."
  echo "-------------------------------------------------------------------"
  echo ""
  echo "# export VULTR_API_KEY={your-Vultr-API-key}"
  exit 1
fi
echo "API key found."

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "https://api.vultr.com/v2/account" -X GET -H "Authorization: Bearer ${VULTR_API_KEY}")
if [[ "${HTTP_CODE}" != "200" ]]; then
  echo ""
  echo "This workstation does not have API access and can not continue."
  echo "-------------------------------------------------------------------"
  echo ""
  echo "Please add IP address " $(host myip.opendns.com resolver1.opendns.com | grep "myip.opendns.com has" | awk '{print $NF}')
  echo "to the API Access Control list at:"
  echo "https://my.vultr.com/settings/#settingsapi"
  exit 1
fi
echo "Workstation has API access."

#################################
## Check for HashiCorp Packer
packer --version &> /dev/null
if [[ $? -ne 0 ]]; then
  echo ""
  echo "This workstation does not have HashiCorp Packer installed."
  echo "-------------------------------------------------------------------"
  echo ""
  echo "https://learn.hashicorp.com/tutorials/packer/get-started-install-cli"
  echo "Please install Packer and run this script again."
  exit 0
fi
echo "Packer is installed."

#################################
## Start building snapshots.
echo ""
echo ""
echo "-----------------------------------------------------------------------"
echo "Marketplace Builder creates working Vultr Marketplace snapshots. Use"
echo "these examples as a starting point for your application."
echo "-----------------------------------------------------------------------"
echo ""
echo "Create a snapshot for which OS?"
echo ""
echo "0: Create all"
echo "1: CentOS 7 (NOT WORKING)"
echo "2: CentOS 8 (NOT WORKING)"
echo "3: Debian 10"
echo "4: Ubuntu 18.04"
echo "5: Ubuntu 20.04"
echo ""

read -r -p "Enter the OS number, or another key to quit: " OSVER

VALID_INPUT='012345'
if [[ ${VALID_INPUT} == *${OSVER}* ]]; then
  echo "Starting the Marketplace Builder."
else
  echo "Exiting."
  exit 0
fi

#################################
## CentOS 7
if [[ "${OSVER}" == "1" || "${OSVER}" == "0" ]]; then
  export PACKER_LOG=1
  export PACKER_LOG_PATH=packer-CentOS7.log
  packer init centos7.pkr.hcl
  packer build centos7.pkr.hcl
fi

#################################
## CentOS 8
if [[ "${OSVER}" == "2" || "${OSVER}" == "0" ]]; then
  export PACKER_LOG=1
  export PACKER_LOG_PATH=packer-CentOS8.log
  packer init centos8.pkr.hcl
  packer build centos8.pkr.hcl
fi

#################################
## Debian 10
if [[ "${OSVER}" == "3" || "${OSVER}" == "0" ]]; then
  export PACKER_LOG=1
  export PACKER_LOG_PATH=packer-Debian10.log
  packer init debian10.pkr.hcl
  packer build debian10.pkr.hcl
fi

## Ubuntu 18.04
if [[ "${OSVER}" == "4" || "${OSVER}" == "0" ]]; then
  export PACKER_LOG=1
  export PACKER_LOG_PATH=packer-Ubuntu1804.log
  packer init ubuntu1804.pkr.hcl
  packer build ubuntu1804.pkr.hcl
fi

#################################
## Ubuntu 20.04
if [[ "${OSVER}" == "5" || "${OSVER}" == "0" ]]; then
  export PACKER_LOG=1
  export PACKER_LOG_PATH=packer-Ubuntu2004.log
  packer init ubuntu2004.pkr.hcl
  packer build ubuntu2004.pkr.hcl
fi
#################################
