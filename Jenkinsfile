    pipeline{
        agent any
        environment {
            IMAGE = 'robot'
        }
       
        stages{
            stage("build image") {
                steps {
                    echo "🐳 Building Docker image: $IMAGE"
                    sh 'docker build -t $IMAGE .'
                    echo "✅ Docker image built successfully!"
                }
                }
           
            stage("run container and execute tests") {
                steps {
                    echo "🚀 Running Robot Framework tests inside container..."
                    sh 'docker run --rm -v ${WORKSPACE}:/app $IMAGE'

                }
               }   
    }}