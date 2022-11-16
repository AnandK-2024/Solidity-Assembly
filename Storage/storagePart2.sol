// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ComplexStorage{
    uint256 [3] public fixedArray;
    uint256 [] public bigArray;
    uint8 [] public smallArray;

    mapping(uint256=>uint256) public Mymapping;
    mapping(uint256=>mapping (uint256=>uint256)) public nestedMapping;
    mapping(address=>uint256[]) public AddressToList;

   constructor(){
       fixedArray=[2,67,80];
   }



    function FixedArrayView(uint256 index) public view returns(uint256 value){
        assembly{
            value:=sload(add(fixedArray.slot,index))
        }
    } 
 


}