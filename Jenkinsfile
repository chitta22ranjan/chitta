pipeline {
    agent any

    environment {
        SOURCE_DIR = "/mnt/cdimage"
        DEST_DIR = "."
    }

    stages {
        stage('Checkout Code') {
            steps {
                script {
                    // Checkout the latest code from the main branch
                    sh 'git checkout -t origin/main'
                }
            }
        }

        stage('Sync D11 and D12') {
            steps {
                script {
                    // Sync D11 directory
                    sh "time rsync -avz --delete --exclude='.svn/' ${SOURCE_DIR}/D11/ ${DEST_DIR}/D11/"
                    
                    // Sync D12 directory
                    sh "time rsync -avz --delete --exclude='.svn/' ${SOURCE_DIR}/D11/ ${DEST_DIR}/D12/"
                }
            }
        }

        stage('Git Status and Diff') {
            steps {
                script {
                    // Change to destination directory
                    dir("${DEST_DIR}") {
                        // Get git status and diff output
                        sh 'git status >> change.txt'
                        sh 'git diff >> change.txt'
                    }
                }
            }
        }

        stage('Check for Changes and Commit') {
            steps {
                script {
                    // Check if there are any changes to commit
                    def gitStatus = sh(script: 'git status', returnStdout: true).trim()
                    
                    if (gitStatus.contains("working tree clean")) {
                        echo "No changes detected - exiting"
                    } else {
                        echo "Changes detected, committing..."
                        // Add, commit, and push the changes
                        sh 'git add .'
                        sh 'git commit -m "Update: $(date \'+%Y-%m-%d %H:%M:%S\')"'
                        sh 'git push origin main'
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completed successfully"
        }

        failure {
            echo "Pipeline failed"
        }
    }
}
