def dockerImage;

node('docker'){
	stage('SCM'){
		checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/thanujkumar/docker-hub']]]);
	}
	stage('build'){
		dockerImage = docker.build('thanujtk/jenkins:lts-jdk11-v$BUILD_NUMBER', './images');
	}
	stage('push'){
		docker.withRegistry('https://index.docker.io/v1/', 'thanujtk'){
			dockerImage.push();
		}
	}
}