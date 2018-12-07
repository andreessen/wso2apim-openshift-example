## Deploy wso2apim on Openshift
### Deploy project via oc CLI

#### Basic project creation
-----------
To create app:
```
$ git clone https://github.com/andreessen/wso2apim-openshift-example
$ cd wso2apim-openshift-example/
$ oc --as=system:admin -n wso2apim create quota terminating --hard=cpu=4,memory=4G --scopes=Terminating
$ oc --as=system:admin -n wso2apim create quota logical --hard=pods=10,services=5,secrets=10,persistentvolumeclaims=5
$ oc --as=system:admin -n wso2apim create quota resources --hard=cpu=4,memory=4G --scopes=NotTerminating
$ oc --as=system:admin -n wso2apim create -f limit-ranges.yaml
$ oc create -f wso2_apim_tpl.yaml
$ oc new-app wso2-apim -p APP_NAME=wso2-apim
```

