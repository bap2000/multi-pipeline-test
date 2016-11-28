#! /bin/groovy

    stage('Git') {
        node {
            checkout scm
        }
    }

    stage('create properties') {
        node {
		def propertiesFile = 'build.properties'
		def jsonFile = 'buildProperties.json'
		def jobName = env.JOB_NAME
		def gitHash = 'TODO'
		def buildNumber = env.BUILD_NUMBER
		def buildDisplayName = env.BUILD_DISPLAY_NAME
		def buildCreated = currentBuild.rawBuild.timeInMillis
		def buildStarted = currentBuild.rawBuild.startTimeInMillis

		def storePath = "/opt/jenkins_artifacts/ltw/${buildNumber}"

		writeFile(file: jsonFile, text: """{
  "jobName": "${jobName}",
  "gitHash": "${gitHash}",
  "buildNumber": ${buildNumber},
  "buildDisplayName": "${buildDisplayName}",
  "buildCreated": ${buildCreated},
  "buildStarted": ${buildStarted}
}""")
		writeFile(file: propertiesFile, text: """
JOB_NAME="${jobName}"
GIT_HASH="${gitHash}"
BUILD_NUMBER=${buildNumber}
BUILD_DISPLAY_NAME="${buildDisplayName}"
BUILD_CREATED=${buildCreated}
BUILD_STARTED=${buildStarted}
""")
		archiveArtifacts artifacts: "${propertiesFile},${jsonFile}", fingerprint: true
		storeArtifacts(storePath, "${propertiesFile},${jsonFile}")
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
	    	build(job: 'd2/begin-dev')
	    }
    }
	


  def doIt (String envName) {
	    stage("${envName}") {
		node {
		    echo "Crazy ${envName} on ${env.BRANCH_NAME}"
		}
	    }
    }

    def storeArtifacts(toDir, includes, excludes) {
	def destDir = new File(toDir)
	assert destDir.mkdirs()
	def destPath = new FilePath(destDir)
	newFilePath(new File()).cpoyRecursiveTo(includes, excludes, destPath)
    }

