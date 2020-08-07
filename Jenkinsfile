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
                echo "Base image built"
            }
        }
        stage('Create test image') {
            agent {
                dockerfile {
                    filename "Dockerfile"
                    dir "${PROJECT_DIR}/access"
                    args "-v ${WORKSPACE}/${PROJECT_DIR}/access:/opt/app"
                }
            }
            steps {
                sh """
                    cd /opt/app
                    export GENERATE_REPORTS=true 
                    /usr/local/rvm/gems/ruby-2.2.3@app-env/bin/rake ci_report test test/models/*test.rb
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