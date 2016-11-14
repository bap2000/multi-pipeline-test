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

    }
	


  def doIt (String envName) {
	    stage("deploy ${envName}") {
		try {
			timeout(time:7, unit:'DAYS') {
				input message: "Deploy To ${envName}?", ok: 'Deploy'
			}
			node {
			    echo "Crazy ${envName} on ${env.BRANCH_NAME}"
			}
		} catch (e) {
			echo "e.message"
			currentBuild.executor.abortBuild()
		}
	    }
    }
