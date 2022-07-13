#!/bin/sh
git describe --contains --all HEAD > .version
BRANCH=`cat .version`
echo $BRANCH
source src/venv/scripts/activate
coverage run --source='src\tutorialsite' src/tutorialsite/manage.py test polls
coverage xml
deactivate
sonar-scanner.bat -D"sonar.projectKey=Polls" -D"sonar.sources=src\tutorialsite" -D"sonar.host.url=http://localhost:9500" -D"sonar.login=PleaseChangeMe" -Dsonar.projectVersion=$BRANCH -D"sonar.python.coverage.reportPaths=coverage.xml"
