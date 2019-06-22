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


       stage ('Publish Cobertura')
{
steps {
cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'spring3hibernate/target/site/cobertura/coverage.xml', conditionalCoverageTargets: '70, 0, 0', enableNewApi: true, failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
}
}      
            
           
          
          

        }
}

