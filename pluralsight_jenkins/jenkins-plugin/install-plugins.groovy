#!groovy
//This script will be placed in ${JENKINS_HOME}/init.groovy.d/ folder
//Dockerfile ENTRYPOINT java -Duser.home=${JENKINS_HOME} -Djenkins.install.runSetupWizard=false ....
//COPY  install-plugins.groovy ${JENKINS_HOME}/init.groovy.d/

import jenkins.model.Jenkins;

pm = Jenkins.instance.pluginManager
uc = Jenkins.instance.updateManager

pm.doCheckUpdatesServer()

["git", "mstest", "slack", "workflow-aggregator"].each {
     if (!pm.getPlugin(it)) {
          deployment = uc.getPlugin(it).deploy(true)
          deployment.get();
     }
}

