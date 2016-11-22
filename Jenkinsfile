#! /bin/groovy

    stage('Git') {
        node {
            checkout scm
        }
    }

    stage('create fingerprint') {
        node {
		def fingerprintFile = 'fingerprint'
		def gitHash="git rev-parse HEAD".execute().text.trim()
		writeFile(file: fingerprintFile, text: """{
  "jobName": "${env.JOB_NAME}",
  "gitHash": "${gitHash}",
  "buildNumber": ${env.BUILD_NUMBER},
  "buildDisplayName": "${env.BUILD_DISPLAY_NAME}",
  "buildCreated": ${currentBuild.rawBuild.timeInMillis}",
  "buildStarted": ${currentBuild.rawBuild.startTimeInMillis}"
}""")
		archiveArtifacts fingerprintFile
	}
    }


    doIt('node.js')
    doIt('ember app')
    doIt('api')
    doIt('integration tests')

    if (env.BRANCH_NAME == "master") {
	    stage("Initialize deployment pipeline") {
	    	build(job: 'd2/begin-prod')
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

