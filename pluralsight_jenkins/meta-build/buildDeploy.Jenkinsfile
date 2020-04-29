def dockerImage;

node('docker'){
	stage('SCM'){
		checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/thanujkumar/docker-hub']]]);
	}
	stage('build'){
		dockerImage = docker.build('thanujtk/jenkins:lts-jdk11-dotnet-v$BUILD_NUMBER', './pluralsight_jenkins/meta-build/dotnet-image');
	}
	stage('push'){
		docker.withRegistry('https://index.docker.io/v1/', 'thanujtk'){
			dockerImage.push();
		}
	}
}