#!/usr/bin/env groovy
pipeline {
	agent any

    stages {

        stage("Interactive_Input") {
            steps {
                script {

                    // Variables for input
                    def releaseNumber
					def requestType
					def requestLink
					def artifactUrl
					def envName
					def Comment
					def prodDeployment
					def preprodDeployment
					def icatDeployment
					buildTriggerredBy = currentBuild.getBuildCauses()[0].userId + "-" + currentBuild.getBuildCauses()[0].userName
					//def timeStamp = String.format('%tF %<tH:%<tM', java.time.LocalDateTime.now())

                    // Get the input
                    def userInput = input(
                            id: 'userInput', message: 'Enter the values:?',
                            parameters: [
							string(defaultValue: 'None', description: 'releaseNumber', name: 'releaseNumber'),
							choice(choices: ['Major', 'Minor'], description: 'requestType', name: 'requestType'),
							string(defaultValue: 'None', description: 'requestLink', name: 'requestLink'),
							string(defaultValue: 'None', description: 'artifactUrl', name: 'artifactUrl'),
							string(defaultValue: 'None', description: 'envName', name: 'envName'),
							string(defaultValue: 'None', description: 'Comment', name: 'Comment'),
							choice(choices: ['Yes', 'No', 'TBD'], description: 'prodDeployment', name: 'prodDeployment'),
							choice(choices: ['Yes', 'No', 'TBD'], description: 'preprodDeployment', name: 'preprodDeployment'),
							choice(choices: ['Yes', 'No', 'TBD'], description: 'icatDeployment', name: 'icatDeployment')
							] )

                    // Save to variables. Default to empty string if not found.
                    releaseNumber = userInput.releaseNumber?:''
                    requestType = userInput.requestType?:''
					requestLink = userInput.requestLink?:''
					artifactUrl = userInput.artifactUrl?:''
					envName = userInput.envName?:''
                    Comment = userInput.Comment?:''
					prodDeployment = userInput.prodDeployment?:''
					preprodDeployment = userInput.preprodDeployment?:''
					icatDeployment = userInput.icatDeployment?:''
					
					/*
                    // Echo to console
                    echo "releaseNumber: ${releaseNumber} \n requestType: ${requestType} \n	requestLink: ${requestLink} \n artifactUrl: ${artifactUrl} \n envName: ${envName} \n Comment: ${Comment} \n prodDeployment: ${prodDeployment} \n preprodDeployment: ${preprodDeployment} \n icatDeployment: ${icatDeployment} \n buildTriggerredBy: ${buildTriggerredBy} \n timeStamp: ${timeStamp}";
					*/
				}
            }
        }
		
		stage(Update_Confluence) {
			steps {
				sh "echo $releaseNumber"
				sh '''				newRow="<tr><td>$releaseNumber</td><td>$requestType</td><td>$envName</td><td>$prodDeployment</td><td>$preprodDeployment</td><td>$icatDeployment</td><td>$timeStamp</td><td>$buildTriggerredBy</td><td>$Comment</td><td>$requestLink</td><td>$artifactUrl</td></tr></tbody></table>"
				'''
			}
		} 
    }
}
