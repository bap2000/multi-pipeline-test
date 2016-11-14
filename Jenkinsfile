#! /bin/groovy


    stage('Git') {
        node {
            checkout scm
            fail "Some reason"
	    echo "Doing something on ${env.BRANCH_NAME}"
	    echo "RESULT ${currentBuild.result}"
        }
    }


    doIt('common2')

    if (env.BRANCH_NAME == "master") {
	    doIt('master1')
	    doIt('master2')

    }
	


  def doIt (String envName) {
	    stage("deploy ${envName}") {
		timeout(time:7, unit:'DAYS') {
			input message: "Deploy To ${envName}?", ok: 'Deploy'
		}
		node {
		    echo "Crazy ${envName} on ${env.BRANCH_NAME}"
		}
	    }
    }
