# Automated testing of NASA near earth object API

## Summary
This script invokes the NASA near earth object web service and runs the following tests against the JSON response. 
Verify the status code returns a 200 success message (testApiStatus)
Verify the number of elements specified in element_count field matches the calculated number of elements (testApiStructureInformation)
Verify the is_potentially hazardous_asteroid flag returns False for each element (testApiCollisionFlags)
Execute inside a docker container to derive environment and dependencies.
Requests use this 
https://api.nasa.gov/neo/rest/v1/feed?

### Prerequisites
Docker installation

###Example Usage
Note: The docker build context should utilize the /scripts project folder

```
cd scripts

docker build -f ../Dockerfile -t nasa-test .

docker run nasa-test
```
