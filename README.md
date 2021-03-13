# multi tools docker image
* multi function docker image based on centos8 for testing purposes with ansible
* removed python3 and AWS CLI from the image
* "ansible" user added, password "123". sudo enabled for this user.
simple use:
```
docker run -it --name multi mstelles/multi:latest sh
```
