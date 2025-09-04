node {   // Forcer l'exécution sur le Master

    // Définir le registry GitLab et le tag de l'image
    def registryProjet = 'registry.gitlab.com/yasminedhaou02/devsecops-amazone'
    def IMAGE = "${registryProjet}:version-${env.BUILD_ID}"

    // Nom du serveur SonarQube configuré dans Jenkins
    def SONARQUBE_SERVER = 'sq1'

    stage('Clone Code') {
        git branch: 'main', url: 'https://github.com/yasminedhaou/My-DevSecOps-Lab.git'
    }

    stage('SonarQube Analysis') {
        def scannerHome = tool 'sonarscan'  // Nom défini dans Global Tool Configuration
        withSonarQubeEnv(SONARQUBE_SERVER) {
            sh "${scannerHome}/bin/sonar-scanner -Dsonar.projectKey=MyProject -Dsonar.sources=."
        }
    }

    stage('Build Docker Image') {
        def img = docker.build("$IMAGE", '.')
        env.DOCKER_IMAGE = "$IMAGE"
    }

    stage('Scan Docker Image with Trivy') {
        sh "trivy image --format table --no-progress ${env.DOCKER_IMAGE}"
    }

    stage('Push Docker Image') {
        docker.withRegistry('https://registry.gitlab.com', 'yasmineGitlab') {
            def img = docker.image(env.DOCKER_IMAGE)
            img.push('latest')
            img.push()
        }
    }

    stage('Update GitOps Repo for ArgoCD') {
        withCredentials([usernamePassword(credentialsId: 'github-argocd-token', usernameVariable: 'GIT_USER', passwordVariable: 'GIT_PASS')]) {
            sh """
            git config --global user.email "jenkins@example.com"
            git config --global user.name "jenkins"

            # Cloner le repo GitOps surveillé par ArgoCD
            
            cd My-DevSecOps-Lab/k8s

            # Modifier l'image dans deployment.yaml
            sed -i 's#${registryProjet}:.*#${IMAGE}#' deploymentAmazonP.yaml

            git add deploymentAmazonP.yaml
            git commit -m "Update image to ${IMAGE}"
            git push origin main
            """
        }
    }
}