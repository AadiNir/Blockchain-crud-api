// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract restapi{
    struct product{
        uint256 id;
        string productname;
        uint256 price;
        uint8 quandity;
    }
    mapping(uint256=>product) products;
    address owner;
    product[] numberofproducts;
    constructor(){
        owner = msg.sender;
    }
    modifier onlyowner{
        require(owner == msg.sender);
        _;
    }
    function addproduct(string memory productna,uint256 pri,uint8 qua) public onlyowner{
        product memory tempproduct = product({
            id: numberofproducts.length,
            productname: productna,
            price:pri,
            quandity:qua
        });
        products[numberofproducts.length]=tempproduct;
        numberofproducts.push(product(numberofproducts.length,productna,pri,qua));
    }
    function getallproduct() external view returns(product[] memory){
        return numberofproducts;
    }
    function getproduct(uint8 id) external view returns(product memory){
        return products[id];
    } 
    function deleteproduct(uint256 id) public{
        require(products[id].id>=0,"product not available");
        delete products[id];
        for(uint256 i=0;i<numberofproducts.length;i++){
            if(i==id){
                product memory temp = numberofproducts[i];
                numberofproducts[i]=numberofproducts[numberofproducts.length-1];
                numberofproducts[numberofproducts.length-1] = temp;
            }
        }
        numberofproducts.pop();
    }
    function updateproduct(uint256 id,string memory name,uint256 cost,uint8 quandity) public {
        require(products[id].id>=0,"product not available");
        deleteproduct(id);
        products[id]=product(id,name,cost,quandity);
        numberofproducts.push(product(id,name,cost,quandity));
        

    }
}