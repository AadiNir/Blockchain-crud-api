const ethers = require('ethers');
const env = require('dotenv');
env.config();

const express = require('express');
const app = express();
app.use(express.json());
const PORT = 5000;
//Blockchain initalize
const contractadd=process.env.CONTRACT_ADDRESS;
const privatekey = process.env.SEPOLIA_PRIVATE_KEY;
const apiurl = process.env.INFURA_API_KEY;
const provider = new ethers.JsonRpcProvider(apiurl);
const signer = new ethers.Wallet(privatekey,provider);
const {abi}=require('./artifacts/contracts/restapi.sol/restapi.json');
const contract = new ethers.Contract(contractadd,abi,signer);
app.get('/product',async(req,res)=>{
    try{
    let product = await contract.getallproduct();
    const products = product.map(pro=>({
        id: pro.id.toString(),
        name:pro.productname,
        price: pro.price.toString(),
        quandity: pro.quandity.toString()
    }))
    res.json(products);
    }
    catch(err){
        console.log(err);
    }

})
app.post('/product',async(req,res)=>{
    try{
        const { productname,price,quandity}= req.body;
        const tx = await contract.addproduct(productname,price,quandity);
        await tx.wait();
        res.json({success: true})

    }catch(err){
        console.log(err);
    }
})
app.listen(PORT,()=>{
    console.log(`the app is been hosted in ${PORT}`)

})