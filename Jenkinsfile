#! /bin/groovy


try {
    stage('Git') {
        node {
            checkout scm
	    echo "Doing something on ${env.BRANCH_NAME}"
        }
    }

    stage('Another common stage') {
	input message: 'Deploy To QA?', ok: 'Deploy'
        node {
	    echo "Doing something common on ${env.BRANCH_NAME}"
        }
    }

    if (env.BRANCH_NAME == "master") {

	    stage('Master only stage 1') {
		node {
		    echo "Crazy master 1 on ${env.BRANCH_NAME}"
		}
	    }

	    stage('Master only stage 2') {
		node {
		    echo "Crazy master 2 on ${env.BRANCH_NAME}"
		}
	    }
    }
	
} catch(Throwable t) {
    currentBuild.result = "FAILED"
    throw t
} finally {
    //slack currentBuild.result, currentBuild
}
