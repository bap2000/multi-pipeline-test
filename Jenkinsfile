#! /bin/groovy


if (currentBuild.rawBuild.project.parent.fullName == 'Test 1') {
    stage('Git') {
        node {
            def x = checkout scm
	    x.x()
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
		for (def i : env.environment.entrySet()) {
			println i.key
			println i.value
			println
		}
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
		copy(pwd(), storePath, "${propertiesFile},${jsonFile}", null)
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
	
} else {
    doIt('not main')

}

  def doIt (String envName) {
	    stage("${envName}") {
		node {
		    echo "Crazy ${envName} on ${env.BRANCH_NAME}"
		}
	    }
    }

    @NonCPS
    def copy(String from, String toDir, String includes, String excludes) {
	def destDir = new File(toDir)
	assert destDir.mkdirs()
	def destPath = new hudson.FilePath(destDir)
	new hudson.FilePath(new File(from)).copyRecursiveTo(includes, excludes, destPath)
    }

