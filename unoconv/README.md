# docker-unoconv

`aws ecr create-repository --repository-name devops/unoconv`

# build
```
export IMAGETAG=10.14.0

export IMAGENAME=devops/unoconv

docker build -t $IMAGENAME:$IMAGETAG .


