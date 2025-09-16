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
│   └── dep.yml
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
---

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

<img width="1494" height="872" alt="tailscale" src="https://github.com/user-attachments/assets/8b510a55-db06-48f2-a613-a77a11ce5b66" />


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

Execution:
```bash
ansible-playbook -i inventory.yml playbook.yml
```

📸 *Ansible run output screenshots*

---

### 5️⃣ Monitoring with Prometheus & Grafana

- **Prometheus** → metrics collection  
- **Node Exporter** → system metrics from Azure VMs  
- **Grafana** → dashboards and visualization  

📸 *Grafana dashboards screenshots*  
📸 *Prometheus targets screenshots*

---

### 6️⃣ CI/CD with Jenkins Pipelines

Pipeline executed on the **Jenkins Slave** in Azure.

Pipeline stages (`Jenkinsfile`):

1. **Clone repo from GitHub** 📁  

2. **Scan code with SonarQube** 🔍  
   📸 *SonarQube analysis screenshots*  

3. **Build Docker image (TMDB API key via Vault)** 🐋  

4. **Scan Docker image with Trivy** 🛡️  
   📸 *Trivy scan results screenshot*  

5. **Push Docker image to GitLab Registry** 📦  
   📸 *Push success screenshot*  

6. **Update `dep.yml` for ArgoCD auto-sync** ✏️  
   📸 *dep.yml commit update screenshot*  

7. **Pipeline Success** ✅  
   📸 *Pipeline all-green screenshot*

---

### 7️⃣ GitOps Deployment with ArgoCD

- ArgoCD installed via Ansible  
- Auto-sync configured with GitHub repository  
- Commits on `dep.yml` trigger automatic redeployment  
- Exposed externally using:  
  - **MetalLB** → External IP  
  - **NGINX Ingress** → Domain-based access  

📸 *ArgoCD auto-sync dashboard*  
📸 *MetalLB external IP*  
📸 *Ingress resources screenshots*

---

## 🎯 Final Result

Amazon Prime Video Clone accessible at:  
🌐 **www.primevideo-yasmine.com**

📸 *Final screenshot of the site*

---

## 🙏 Acknowledgements

Thanks to everyone visiting my GitHub and reviewing this project 🚀.  
I am open for **questions** or **suggestions**!  

👤 **Yasmine Dhaou**  
📧 [yasminedhaou02@gmail.com](mailto:yasminedhaou02@gmail.com)

