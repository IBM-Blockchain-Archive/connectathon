# Connect-A-Thon

## Follow these steps and quickly join a Marbles Trading Network

### Prerequisites
- [Docker v1.12 or higher](https://www.docker.com/products/overview)
- [Docker-Compose v1.8 or higher](https://docs.docker.com/compose/overview/)

### Register a user

- Go to [User Registration Website](http://connectathon-cop.blockchain.ibm.com)
- It will ask you for an `enrollID` and your `email`.
- Please enter a unique `enrollID`.
- The credentials will sent to you via your provided `email`.  Save these credentials; you
will need the `enrollID` and `enrollSecret` to properly authenticate your marbles
application onto the network.  

#### What will this step do?
  ```
  Behind the scenes this will make a REST call to the fabric-COP and  
  register a user with the unique `enrollID` you have provided.
  This user represents the admin for your organization, and will be used by the
  app to authenticate to the chain.
  ```

### Clone the repo
```bash
git clone https://github.com/IBM-Blockchain/connectathon.git
cd connectathon/marbles
```

### Use the credentials to join the chain

- Ensure that you are in the correct working directory:
  ```
  /connectathon/marbles
  ```
  and that you are on the public branch.  You can confirm this by typing:
  ```
  git branch
  ```
  you should see
  ```
  master
  * public
  ```
  Now execute the shell script. This script will pull the dependent Fabric
  images, and spin up two containers - one for your endorsing peer and
  one for the marbles node.js application.  The `enrollID` and `enrollSecret`
  which you received in your email upon registration will be used at this point:
  ```bash
  ./marbles.sh up <enrollID> <enrollSecret> <company> <user1> <user2> <user3>
  #enrollId is what you used alongside your email when you requested an enrollSecret
  #enrollSecret is what was returned to you via email
  #company is the name of your organization, and is how you will be represented on the chain
  #user1, user2, and user3 are the users registered under your organization
  ```
  Ensure that you populate all of the required fields.  Recall that this demo is
  simulating an organizational admin who authenticates to a blockchain network,
  and then permissions users to transact on the network via their organization's
  endorsing peer.  A sample command line prompt might look similar to the
  following:
  ```
  ./marbles.sh up Admin1 xYzAAbbc1234 JPM eric kenny stan
  ```
### View the Marbles UI
  By executing the shell script you have kicked off the marbles application.  It
  is running as a container on your local machine.  To see your currently
  running containers:
  ```
  docker ps
  ```
  Assuming you have no other processes running, you should see three distinct
  containers.  One for your peer, one for the marbles app, and one for the
  marbles chaincode running on your peer.

  Open up a browser and visit `localhost:3000`.  This will take you to an
  initial administrative screen.  Login as the `admin` at the bottom of the
  page, after which three processes will take place.  

  * You will be logged in as the admin.
  * The application will find the chaincode and the current state of the ledger.
  * Your users will be registered and allocated their marbles.

  Upon success of these three processes, you will be able to view the entire
  marbles trading market.  Organizations and users represented within those
  organizations will appear on the screen.  You will also notice that you have
  the ability to transfer assets (marbles) for your registered users, but
  cannot distribute another organization's assets.  Happy trading.

  To see the logs and peer processes for your endorsing peer:
  ```
  docker logs peer
  ```
  This will allow you to see realtime invocations and block commits happening
  on your network's chain.  

### Troubleshooting
  If you see an error similar to:
  ```
  ERROR: In file './docker-compose-no-cdb.yml' service 'version' doesn't have
  any configuration options. All top level keys in your docker-compose.yml must
  map to a dictionary of configuration options.
  ```
  You will need to upgrade your Docker-Compose version in order to achieve
  compatibility with the docker-compose.yaml scripts.  
  
### Helpful Docker Commands 

1. View running containers:

  ```
docker ps
```
2. View all containers (active and non-active):

  ```
docker ps -a
```
3. Stop all Docker containers:

  ```
docker stop $(docker ps -a -q)
```
4. Remove all containers.  Adding the `-f` will issue a "force" removal:

  ```
docker rm -f $(docker ps -aq)
```
5. Remove all images:

  ```
docker rmi -f $(docker images -q)
```
6. Remove all images except for hyperledger/fabric-baseimage:

  ```
docker rmi $(docker images | grep -v 'hyperledger/fabric-baseimage:latest' | awk {'print $3'})
```
7. Start a container:

  ```
docker start <containerID>
```
8. Stop a containerID:

  ```
docker stop <containerID>
```
9. View network settings for a specific container:

   ```
docker inspect <containerID>
```
10. View logs for a specific containerID:

  ```
docker logs -f <containerID>
```


### Stop Peer and Application
  ```
  ./marbles.sh down
  ```
