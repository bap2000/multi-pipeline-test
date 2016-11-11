#! /bin/groovy


try {
    stage('Git') {
        node {
            checkout scm
	    echo "Doing something on ${env.BRANCH_NAME}"
	    echo "RESULT ${currentBuild.result}"
        }
    }


    doIt('common2')

    if (env.BRANCH_NAME == "master") {
	    doIt('master1')
	    doIt('master2')

    }
	
} catch(Throwable t) {
    echo "GOT A THING: ${currentBuild.result}"
    currentBuild.result = "FAILED"
    throw t
} finally {
    //slack currentBuild.result, currentBuild
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
