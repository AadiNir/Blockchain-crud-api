const ethers = require('ethers');
const env = require('dotenv');
env.config();
const contractadd=process.env.CONTRACT_ADDRESS;
const privatekey = process.env.SEPOLIA_PRIVATE_KEY;
const apiurl = process.env.INFURA_API_KEY