CHART_REPO := http://jenkins-x-chartmuseum:8080
DIR := "env"
NAMESPACE := "jx-staging"
OS := $(shell uname)

build: clean
	rm -rf requirements.lock
	helm version
	helm init --upgrade --stable-repo-url https://kubernetes.oss-cn-hangzhou.aliyuncs.com/charts
	helm repo add releases ${CHART_REPO}
	helm dependency build ${DIR}
	helm lint ${DIR}

install: 
	helm upgrade ${NAMESPACE} ${DIR} --install --namespace ${NAMESPACE} --debug

delete:
	helm delete --purge ${NAMESPACE}  --namespace ${NAMESPACE}

clean:


