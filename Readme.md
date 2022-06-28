# DEVOPS - TP4 - Cloud - Terraform

# 🎯  Objectifs:

1. Deployer sur Azure Container Instance (ACI) using Github Actions
2. Mettre à disposition son image sur DockerHub
3. Mettre à disposition son code dans un repository Github
4. Créer une machine virtuelle Azure (VM) avec une adresse IP publique Utiliser TerraformSe connecter à la VM avec SSH
5. Comprendre les différents services Azure (ACI vs. AVM)
6. Mettre à disposition son code dans un repository Github
    
    # Constitution du fichier TP :
    
    ![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled.png)
    

# ****Accès au ressource group****

## On initialise le projet terraform :

> **Terraform init**
> 

![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%201.png)

## Login à Azure

![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%202.png)

On accède ensuite au ressource groupe sur Azur puis au réseau virtuel et au subnet via le fichier Network.tf

## Vérification à l’aide de la commande:

> Terraform plan
> 

![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%203.png)

## Une fois les fichiers .tf complets (cf Github) on déploit et on test notre VM

> Terraform apply
> 

![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%204.png)

## Terraform output

![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%205.png)

# Création de la VM sur Azure ****✅****

![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%206.png)

# Connection de la VM avec SSH  ****✅****

> terraform output -raw tls_private_key > id_rsa
> 
> 
> Génération de la clé privée: 
> 
> ![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%207.png)
> 

> terraform output public_ip_address
> 

> ssh -i id_rsa azureuser@<public_ip_address>
> 

## Résultat :

![Untitled](DEVOPS%20-%20TP4%20-%20Cloud%20-%20Terraform%2052eccd47b2f2449f998ace1cf3bc0efe/Untitled%208.png)

#