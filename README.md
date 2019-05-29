# Bash automated testing demonstration

## Summary
This script invokes the NASA near earth object web service and runs the following tests against the JSON response. 
1. Verify the status code returns a 200 success message (testApiStatus)
2. Verify the number of elements specified in element_count field match the calculated number of elements (testApiStructureInformation)2.
3. Verify the is_potentially hazardous_asteroid flag returns False for each element (testApiCollisionFlags)

Execution of the test script inside a docker container will derive  environment dependencies.  See Dockerfile.  

All test requests use the following public endpoint.
https://api.nasa.gov/neo/rest/v1/feed?

### Prerequisite
Docker installation

### Example Usage
Note: The docker build context should be set to /scripts project folder

```
cd scripts
docker build -f ../Dockerfile -t nasa-test .
docker run nasa-test
```
