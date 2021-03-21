# Script for What-If deployments

az deployment sub what-if --name 'bicep-development' --location 'Switzerland North' -f ./Templates/main.bicep -p location='switzerlandnorth'