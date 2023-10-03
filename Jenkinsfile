pipeline {

    agent any

    stages {

        stage("Interactive_Input") {
            steps {
                script {

                    // Variables for input
                    def Column1
					def Column2
					def Column3
					def Comment
					def Column6

                    // Get the input
                    def userInput = input(
                            id: 'userInput', message: 'Enter the values:?',
                            parameters: [
							string(defaultValue: 'None', description: 'Column1', name: 'Column1'),
							string(defaultValue: 'None', description: 'Column2', name: 'Column2'), 
							string(defaultValue: 'None', description: 'Column2', name: 'Column2'),
							string(defaultValue: 'None', description: 'Comment', name: 'Comment'),
							string(defaultValue: 'None', description: 'Column6', name: 'Column6') ] )

                    // Save to variables. Default to empty string if not found.
                    Column1 = userInput.Column1?:''
                    Column2 = userInput.Column2?:''
					Column3 = userInput.Column3?:''
                    Comment = userInput.Comment?:''
					Column6 = userInput.Column6?:''

                    // Echo to console
                    echo -e "Column1: ${Column1} \n Column2: ${Column2} \n Column3: ${Column3} \n Comment: ${Comment} \n Column6: ${Column6}";
                }
            }
        }
    }
}
