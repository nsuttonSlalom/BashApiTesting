#!/bin/bash
###############################################################################
#
# Automated API testing - Neo Web Service
#
# Nate Sutton
# 5/20/2019
#
# Description:  Validate JSON responses from the NASA near earth object
#		web service: GET https://api.nasa.gov/neo/rest/v1/feed?
#
#		Dependencies:
#		jq
#		shunit2
#
###############################################################################


# Variables
apiKey='DEMO_KEY'
startDate='2019-05-01'
endDate='2019-05-01'
url='https://api.nasa.gov/neo/rest/v1/feed'
endPoint=$url'?start_date='$startDate'&end_date='$endDate'&api_key='$apiKey


# Make API Endpoint requests and collect information
function getApiStatus {
	httpCode=$(curl -o /dev/null -s -w "%{http_code}\n" -X GET $endPoint)
}
function getApiStructureInformation {
	elementCountField=$(curl -s GET $endPoint | jq '.element_count')
	calculatedElementCount=$(curl -s GET $endPoint | jq '.near_earth_objects["'$startDate'"] | length')
}
function getApiCollisionFlag {
	collisionFlag=$(curl -s GET $endPoint | jq '.near_earth_objects["2019-05-01"]['$1'].is_potentially_hazardous_asteroid')
}

# Verify response characteristics
function testApiStatus {
	getApiStatus
	assertEquals 'Verifying Service HTTP status code' 200 $httpCode
}

function testApiStructureInformation {
	getApiStructureInformation
	assertEquals 'Verifying element count field matches calculated elements' $elementCountField $calculatedElementCount
}

function testApiCollisionFlags {
	iteration=$((calculatedElementCount - 1))
	for i in $(seq 0 $iteration)
	do
		echo 'TESTING JSON Element: '$i
		getApiCollisionFlag $i
		assertEquals 'True Collision flag at element '$i' detected' 'false' $collisionFlag
	done
}

# Load shUnit2 testing framework.
. shunit2.sh
