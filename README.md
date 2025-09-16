# My-DevSecOps-Lab

# 🎥 Amazon Prime Video Clone – DevSecOps Project

A full-stack **DevSecOps implementation** showcasing how to build, secure, deploy, and monitor an **Amazon Prime Video clone** using advanced tools like **Terraform, Ansible, Jenkins, ArgoCD, Vault, Tailscale, Prometheus, Grafana, Trivy, and SonarQube**.

---

## 🧩 Project Scope

- Local VMs (RHEL 9.6) on **VMware**  
  - 1x DevOps VM (Terraform + Ansible + Vault)  
  - 1x Kubernetes Master node  
  - 2x Kubernetes Worker nodes  

- Jenkins Master/Slave deployment on **Azure** using **Terraform** (secured by Vault)  
- Secure networking with **Tailscale VPN** between local and Azure environments  
- Kubernetes cluster configuration & monitoring via **Ansible**  
- GitOps deployment using **ArgoCD**  
- Monitoring with **Prometheus + Grafana + Node Exporter**  
- CI/CD pipelines with **Jenkins** (GitHub, SonarQube, Docker, Trivy, GitLab Registry)  
- Application deployment via **NGINX Ingress + MetalLB**  
- Final domain: 🌐 **www.amazoneprime.com**

---

## 📊 Project Architecture Diagram


![Master Node (1)](https://github.com/user-attachments/assets/ef455c4d-b8e1-4f8a-9d74-b43e1b1247f5)


---

## 📁 Project Structure
```
DevSecOps – Amazon Prime Clone
├── ansible
│   ├── inventory.yml
│   ├── playbook.yml
│   └── roles
│       ├── cluster_k8
│       ├── monitoring
│       ├── argoCd
│       └── jenkins
├── terraform
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
├── Jenkinsfile
├── argocd
│   └── deploymentAmazoneP.yml
└── README.md
```

---

## ⚙️ Step-by-Step Implementation

### 1️⃣ Local Kubernetes Cluster (VMware)

Created 4 VMs on **VMware (RHEL 9.6)**:  
- **DevOps VM** → Terraform, Ansible, Vault  
- **Master Node** → Kubernetes master  
- **Worker1 & Worker2** → Kubernetes workers  

<img width="177" height="111" alt="Capture d’écran 2025-09-16 195153" src="https://github.com/user-attachments/assets/0066ed13-b797-4996-9bed-5987deb13b32" />


### 2️⃣ Jenkins Infrastructure (Azure) with Terraform + Vault

Provisioned **Jenkins Master and Slave VMs** on Azure using Terraform, secured via Vault.



Terraform Files:
- `main.tf` → Azure resources (RG, VNet, Subnet, NSG, VMs)  
- `variables.tf` → Configurable variables  
- `outputs.tf` → Outputs (IPs, RG)  
- `provider.tf` → Azure provider + Vault integration  

🔐 **Vault** stores:  
- **SSH private key**  
- **Usernames & passwords** for Azure VMs  

SSH keys were generated on the **DevOps VM (local)** to enable secure connections.  



Terraform plan : 

<img width="1555" height="742" alt="plantf" src="https://github.com/user-attachments/assets/30fd7b01-158f-49fb-a56e-64cb4465eadc" />

<img width="452" height="248" alt="plantf1" src="https://github.com/user-attachments/assets/71240c20-8cc6-4034-8445-c2db4cb36f39" />

Terraform apply : 

<img width="1547" height="517" alt="applytf" src="https://github.com/user-attachments/assets/69f99908-6305-437c-8e3b-b43db72c2d18" />

<img width="1532" height="255" alt="applytf1" src="https://github.com/user-attachments/assets/17441d62-cb2d-4d3e-b884-533429faafbc" />

Vault :

<img width="1366" height="535" alt="Design sans titre" src="https://github.com/user-attachments/assets/31af3235-0d8f-4df3-ab0b-da2869797a6e" />

Vault web interface :


<img width="1103" height="535" alt="Design sans titre" src="https://github.com/user-attachments/assets/c01e11c9-2a05-4350-97b5-92e49fbf7d8f" />

Azure :
<img width="1863" height="781" alt="ressources" src="https://github.com/user-attachments/assets/eac3d83a-9a9c-431a-ac07-15df6fecc3c6" />

<img width="1477" height="785" alt="rgAZURE" src="https://github.com/user-attachments/assets/57213fc5-1c3e-4a8a-9d01-b0451d3aef38" />


### 3️⃣ Secure Connectivity with Tailscale

Configured **Tailscale VPN** across all local and Azure VMs:  
- Encrypted communication 🔐  
- Simplifies Ansible inventory using Tailscale IPs  
- Enables secure cross-environment monitoring  

<img width="912" height="535" alt="Design sans titre (1)" src="https://github.com/user-attachments/assets/6c50c4d9-add6-4721-b941-724b7434d1f8" />


---

### 4️⃣ Configuration Management with Ansible

Generated SSH keys and copied to all machines for secure access:  
```bash
ssh-keygen
ssh-copy-id <ip_machine>
```

Ansible Roles:
- `cluster_k8` → Setup Kubernetes cluster (1 master, 2 workers)  
- `monitoring` → Deploy Prometheus + Grafana + Node Exporter  
- `argoCd` → Deploy ArgoCD into Kubernetes  
- `jenkins` → Configure Jenkins on Azure VMs  
<img width="475" height="231" alt="roleAnsible" src="https://github.com/user-attachments/assets/4ce80c26-6051-4672-ad1d-31fb636ee110" />


Execution:
```bash
ansible-playbook -i inventory.yml playbook.yml



```

<img width="817" height="677" alt="1" src="https://github.com/user-attachments/assets/da54edf9-34ec-47df-8655-0efd0aba52fa" />
<img width="950" height="143" alt="2" src="https://github.com/user-attachments/assets/5578865e-3bca-4fe9-be94-1e09ed994836" />
---

### 5️⃣ Monitoring with Prometheus & Grafana

- **Prometheus** → metrics collection  
- **Node Exporter** → system metrics from Azure VMs  
- **Grafana** → dashboards and visualization  

Prometheus :

<img width="1713" height="871" alt="prom" src="https://github.com/user-attachments/assets/bc1b2bae-8150-4ff5-8ca2-a05b6c3d6697" />

Grafana :

Master :

<img width="1133" height="535" alt="Design sans titre (2)" src="https://github.com/user-attachments/assets/95ab1ba9-21a2-4708-a5c8-8ceb08ca6664" />

Worker 1 :

<img width="1149" height="535" alt="Design sans titre (3)" src="https://github.com/user-attachments/assets/f8be55d7-1bd8-4bff-bac3-edf1697a3ae6" />

Worker 2 :

<img width="1140" height="535" alt="Design sans titre (4)" src="https://github.com/user-attachments/assets/621914eb-2ef3-40e4-813d-4ae112a52072" />

Jenkins VMs On Azure :

<img width="1717" height="841" alt="jenkinsAZ" src="https://github.com/user-attachments/assets/b0f47481-a6ab-47a5-8681-2b740233d094" />



---

### 6️⃣ CI/CD with Jenkins Pipelines

Pipeline executed on the **Jenkins Slave** in Azure.

Pipeline stages (`Jenkinsfile`):

1. **Clone repo from GitHub** 📁  

<img width="729" height="913" alt="image" src="https://github.com/user-attachments/assets/ed7e6cfc-9477-4e8c-b4d0-40ccbddf0b61" />


2. **Scan code with SonarQube** 🔍  

   <img width="855" height="871" alt="image" src="https://github.com/user-attachments/assets/16b811dc-ba41-4b04-9d60-5da530bbc9c5" />
<img width="1723" height="502" alt="scan" src="https://github.com/user-attachments/assets/2b5cba58-c1c2-4dee-8eae-957f8377e912" />


4. **Build Docker image (TMDB API key via Vault)** 🐋  
<img width="992" height="871" alt="image" src="https://github.com/user-attachments/assets/d0bb4771-4b92-4dd6-a46a-9a700cf3b97e" />

5. **Scan Docker image with Trivy** 🛡️  
<img width="1122" height="871" alt="image" src="https://github.com/user-attachments/assets/525db744-c336-43e0-b67c-10d84b05f937" />
<img width="1352" height="645" alt="trivyCLOI" src="https://github.com/user-attachments/assets/ce7f89e5-b305-4187-9edf-b027e9b67f7a" />

6. **Push Docker image to GitLab Registry** 📦  
  <img width="1253" height="871" alt="image" src="https://github.com/user-attachments/assets/45317ada-8f4d-4247-afbb-c5fcfa385856" />


7. **Update `deploymentAmazonP.yml` for ArgoCD auto-sync** ✏️  
<img width="1387" height="871" alt="image" src="https://github.com/user-attachments/assets/b2745909-dbe6-4a6c-bf6f-f968235a69b7" />

8. **Pipeline Success** ✅  
 <img width="1715" height="913" alt="pipelineCI" src="https://github.com/user-attachments/assets/f7a5d235-1cab-40ff-9cfa-b3447b79adea" />


---

### 7️⃣ GitOps Deployment with ArgoCD

- ArgoCD installed via Ansible  
- Auto-sync configured with GitHub repository  
- Commits on `deploymentAmazonP.yml` trigger automatic redeployment  
- Exposed externally using:  
  - **MetalLB** → External IP  
  - **NGINX Ingress** → Domain-based access  

<img width="1713" height="872" alt="appHealth" src="https://github.com/user-attachments/assets/d8f21f25-5d40-4786-8062-f5470667e8fd" />

<img width="962" height="110" alt="svc" src="https://github.com/user-attachments/assets/96569e54-2653-4f03-a169-715163559b73" />


---

## 🎯 Final Result

Amazon Prime Video Clone accessible at:  
🌐 **www.primevideo-yasmine.com**

<img width="1722" height="858" alt="amazoneprime" src="https://github.com/user-attachments/assets/422f5abf-1fa7-42d6-982a-ee606e0ae0ad" />

---

## 🙏 Acknowledgements

Thanks to everyone visiting my GitHub and reviewing this project 🚀.  
I am open for **questions** or **suggestions**!  

👤 **Yasmine Dhaou**  
📧 [yasminedhaou02@gmail.com](mailto:yasminedhaou02@gmail.com)

