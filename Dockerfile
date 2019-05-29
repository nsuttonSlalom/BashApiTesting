FROM ubuntu:18.04
COPY . .
RUN apt-get update && apt-get install -y curl &&apt-get install -y jq
CMD bash nasa-api-tests.sh
