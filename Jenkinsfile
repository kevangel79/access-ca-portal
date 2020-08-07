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
        stage('Create base image') {
            agent {
                dockerfile {
                    filename "Dockerfile"
                    dir "${PROJECT_DIR}/docker/ruby"
                    additionalBuildArgs "-t centos6-ruby2.2.3:latest"
                    args "-v ${WORKSPACE}/${PROJECT_DIR}:/opt/app -u jenkins:jenkins"
                }
            }
            steps {
                sh """
                    cd /opt/app
                    GENERATE_REPORTS=true rake ci_report test test/models/*test.rb
                """
            }
        }
    }
    post{
        always {
            cleanWs()
        }
    }
}