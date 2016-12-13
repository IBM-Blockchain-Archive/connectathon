#!/bin/bash

UPDOWN=$1
ADMIN=$2
ADMINPW=$3
COMPANY=$4
USER1=$5
USER2=$6
USER3=$7

function printHelp {
	echo "Usage: ./marbles.sh <up/down> <enrollId> <enrollSecret> <company> <user1> <user2> <user3>"
}

function validateInput {
	if [ -z "${UPDOWN}" ]; then
		echo "up/down not mentioned"
		printHelp
		exit 1
	fi

	if [ "${UPDOWN}" == "down" ]; then
		return
	fi
	
	if [ -z "${ADMIN}" ]; then
		echo "enrollId not provided"
		printHelp
		exit 1
	fi


	if [ -z "${ADMINPW}" ]; then
		echo "enrollSecret not provided"
		printHelp
		exit 1
	fi

	if [ -z "${COMPANY}" ]; then
		echo "Company not provided"
		printHelp
		exit 1
	fi

	if [ -z "${USER1}" ]; then
		echo "user1 not provided"
		printHelp
		exit 1
	fi

	if [ -z "${USER2}" ]; then
		echo "user2 not provided"
		printHelp
		exit 1
	fi

	if [ -z "${USER3}" ]; then
		echo "user3 not provided"
		printHelp
		exit 1
	fi

}

function prepareCredentials {
	cp mycreds.json marbles.json
	sed -i -e 's/NETWORK_ID/nid_1/g' marbles.json
	sed -i -e 's/PEER1_HOST/peer/g' marbles.json
	sed -i -e 's/PEER1_PORT/7051/g' marbles.json
	sed -i -e 's/COP_HOST/connectathon-cop.blockchain.ibm.com/g' marbles.json
	sed -i -e 's/COP_PORT/30303/g' marbles.json
	sed -i -e 's/ORDERER_HOST/connectathon-orderer.blockchain.ibm.com/g' marbles.json
	sed -i -e 's/ORDERER_PORT/30303/g' marbles.json

	sed -i -e "s/ADMINPW/${ADMINPW}/g" marbles.json
	sed -i -e "s/ADMIN/${ADMIN}/g" marbles.json
	sed -i -e "s/COMPANY/${COMPANY}/g" marbles.json
	sed -i -e "s/CHAINCODE_ID/marbles/g" marbles.json
	sed -i -e "s/USER1/${USER1}/g" marbles.json
	sed -i -e "s/USER2/${USER2}/g" marbles.json
	sed -i -e "s/USER3/${USER3}/g" marbles.json
        chmod 766 marbles.json

}

function runPeerMarbles {
	docker pull connectathon/fabric-ccenv
	docker tag connectathon/fabric-ccenv hyperledger/fabric-ccenv
	sudo chmod 766 /var/run/docker.sock
	docker-compose -f docker-compose-no-cdb.yml -f marbles.yml pull
	docker-compose -f docker-compose-no-cdb.yml -f marbles.yml up -d 
}

validateInput

if [ "${UPDOWN}" == "up" ]; then
	prepareCredentials
	runPeerMarbles
elif [ "${UPDOWN}" == "down" ]; then
	docker-compose -f docker-compose-no-cdb.yml -f marbles.yml down
else
	printHelp
	exit 1
fi

