# Connectathon

## Steps to follow to trade marbles

### Pre-requisites
- docker v1.12+
- docker-compose latest

### Register a user

- Go to [User Registration Website](http://connectathon-cop.blockchain.ibm.com)
- It will ask you for an `enrollID` and your `email`.
- Please enter a unique `enrollID`.
- The credentials will sent to you on your `email`.

#### What will this step do?
  ```
  Behind the scenes this will make a REST call to the fabric-COP and will try and 
  register a user with the `enrollID` that you have given.
  This user will be used by the app to transactions in the chain.
  ```

### Clone the repo
```bash
git clone https://github.ibm.com/IBM-Blockchain/connectathon.git
cd marbles
git checkout public
```

### Use the credentials to join the chain

- Edit marbles.json
  ```
  Replace `ID` with the enrollId that you enrolled with (2 places)
  Replace `SECRET` with the enrollSecret that you received in your email (2 places)
  ```

### Join the chain
```bash 
./marbles.sh up
```
