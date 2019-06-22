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
             stage ('submitter')
                 {
                   steps{
                         
			input message: 'this is limited access', submitter: 'admin'
                     }
                    }
		
		  stage ('Code Quility')
              { 
                  steps
                  {
                   sh 'cd /var/lib/jenkins/workspace/Job1/spring3hibernate; mvn checkstyle:checkstyle'
                  }
          }
		  stage ('Code Coverange')
              { 
                  steps
                  {
                   sh 'cd /var/lib/jenkins/workspace/Job1/spring3hibernate; mvn cobertura:cobertura'
                  }
          }
	stage ('Code Publish')
              {
                  steps
                  {
                   sh 'cd publishCoverage adapters: [coberturaAdapter('target/site')], sourceFileResolver: sourceFiles('NEVER_STORE')
                  }
          }

        }
}

