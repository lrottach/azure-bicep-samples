# Script for What-If deployments

echo 'Start evaluating deployment...'
az deployment sub what-if --name 'bicep-development' --location 'Switzerland North' -f ./Templates/main.bicep -p location='switzerlandnorth'