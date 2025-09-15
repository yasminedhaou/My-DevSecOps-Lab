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
- Final domain: 🌐 **www.primevideo-yasmine.com**

---

## 📊 Project Architecture Diagram


![Master Node](https://github.com/user-attachments/assets/e30a660a-eb03-46e4-934d-91bdc50a14a0)

---

## 📁 Project Structure
```
PrimeVideo-DevSecOps
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

📸 *VM creation screenshots*

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

📸 *Terraform plan & apply screenshots*  
📸 *Vault secrets screenshots*

---

### 3️⃣ Secure Connectivity with Tailscale

Configured **Tailscale VPN** across all local and Azure VMs:  
- Encrypted communication 🔐  
- Simplifies Ansible inventory using Tailscale IPs  
- Enables secure cross-environment monitoring  

📸 *Tailscale dashboard screenshots*

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

