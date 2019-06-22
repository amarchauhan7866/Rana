pipeline {
    agent any
    stages
    {
        stage ('Git Clone')
        { 
          steps{
              sh 'rm -rf spring3hibernate; git clone git@github.com:opstree/spring3hibernate.git'
               }
        }
              stage ('Code Stability')
              { 
                  steps
                  {
                   sh 'cd /var/lib/jenkins/workspace/Job1/spring3hibernate; mvn compile'
                  }
          }
          
        }
}



