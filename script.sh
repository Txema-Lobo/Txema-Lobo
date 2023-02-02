export subscriptionId="6831b23c-efcf-4a1b-9c32-ed246ead9c0c";
export resourceGroup="rg_sentinel_pro_westeu_001";
export tenantId="609bfa70-79cc-45ee-a596-61dd62b394e9";
export location="westeurope";
export authType="token";
export correlationId="4b2be45f-b9ae-4eef-aca6-e29e324c2bc7";
export cloud="AzureCloud";

# Descargar el paquete de instalación
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# Instalar el agente híbrido
bash ~/install_linux_azcmagent.sh;

# Ejecutar comando de conexión
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --tags "Datacenter=Arganda,City=Arganda,PO='Jose Maria Lobo'" --correlation-id "$correlationId
