
# az ad sp create-for-rbac --name ServicePrincipalSQM
# {
#  "appId": "1ef10365-f866-4cf8-85a2-4fdca5a37a4f",
#  "displayName": "ServicePrincipalSQM",
#  "name": "http://ServicePrincipalSQM",
#  "password": "b92549d5-75a0-4a1d-bd6d-40e1c7c4a9ef",
#  "tenant": "72f988bf-86f1-41af-91ab-2d7cd011db47"
# }

# ssh-keygen -t rsa -b 4096 -f "C:\Users\rorozasn\Desktop\Terraform Azure Demo\tfaz_id_rsa"

export TF_VAR_subscription_id="b4081e51-2f31-45b4-981d-cf5ef01cf490"
export TF_VAR_client_id="b9c52a55-89e3-46ef-a040-ca6cadfd9739"
export TF_VAR_client_secret="aa809684-e54c-4717-92a5-017188cb6d64"
export TF_VAR_tenant_id="ee9a0945-3e32-4c74-8986-8e411af80f3c"
export TF_VAR_ssh_key_private="$(cat tfaz_id_rsa)"
export TF_VAR_ssh_key_public="$(cat tfaz_id_rsa.pub)"
