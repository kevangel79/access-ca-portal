pipeline {
    agent{
        label 'slave01'
    }
    options {
        checkoutToSubdirectory("access-ca-portal")
        newContainerPerStage()
    }
    environment{
        PROJECT_DIR="access-ca-portal"
    }
    stages {
        stage('Create base image'){
            agent {
                dockerfile {
                    filename "Dockerfile"
                    dir "${PROJECT_DIR}/docker/ruby"
                    additionalBuildArgs "-t centos6-ruby2.2.3:latest"
                }
            }
            steps {
                echo 'step1'
            }
        }
        stage('Create test image'){
            agent {
                dockerfile {
                    filename "Dockerfile"
                    dir "${PROJECT_DIR}/access"
                    additionalBuildArgs "-t access-ca-portal_devel:latest"
                }
            }
            steps {
                echo 'step1'
            }
        }
    }
    post{
        always {
            cleanWs()
        }
    }
}