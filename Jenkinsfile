#! /bin/groovy


    stage('Git') {
        node {
	    currentBuild.result='SUCCESS'
            checkout scm
	    echo "Doing something on ${env.BRANCH_NAME}"
        }
    }


    doIt('common2')

    if (env.BRANCH_NAME == "master") {
	    doIt('master1')
	    doIt('master2')
	    stage("Initialize deployment pipeline") {
	    	build(job: 'Deploy/prod-pipeline-start')
	    }
    } else {
	    stage("Initialize deployment pipeline") {
	    	build(job: 'Deploy/dev-pipeline-start')
	    }
    }
	


  def doIt (String envName) {
	    stage("deploy ${envName}") {
		node {
		    echo "Crazy ${envName} on ${env.BRANCH_NAME}"
		}
	    }
    }

