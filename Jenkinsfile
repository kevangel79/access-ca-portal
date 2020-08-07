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
                }
            }
            steps {
                sh """
                    cd ${WORKSPACE}/${PROJECT_DIR}/access
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