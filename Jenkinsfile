#! /bin/groovy


    stage('Git') {
        node {
            checkout scm
        }
    }


    doIt('node.js')
    doIt('ember app')
    doIt('api')
    doIt('integration tests')

    if (env.BRANCH_NAME == "master") {
	    stage("Initialize deployment pipeline") {
	    	build(job: 'Deploy/prod-pipeline-start')
	    }
    } else {
	    stage("Initialize deployment pipeline") {
	    	build(job: 'Deploy/dev-pipeline-start')
	    }
    }
	


  def doIt (String envName) {
	    stage("${envName}") {
		node {
		    echo "Crazy ${envName} on ${env.BRANCH_NAME}"
		}
	    }
    }

