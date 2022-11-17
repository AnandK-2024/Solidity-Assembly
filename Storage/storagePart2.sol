// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

 contract ComplexStorage{
    uint256 [3] public fixedArray;
    uint256 [] public bigArray;
    uint64 [] public smallArray;

    mapping(uint256=>uint256) public Mymapping;
    mapping(uint256=>mapping (uint256=>uint256)) public nestedMapping;
    mapping(address=>uint256[]) public AddressToList;

   constructor(){
       fixedArray=[2,67,80];
       bigArray=[1,2,3,5,5,6,7,8];
       smallArray=[9,8,7,6,8];
   }



    function FixedArrayView(uint256 index) public view returns(uint256 value){
        assembly{
            value:=sload(add(fixedArray.slot,index))
        }
    }

    function BigArrayView(uint index) public view returns(uint256 value,bytes32 location){
        uint Slot;
        assembly{
            Slot:=bigArray.slot
        }
        location=keccak256(abi.encode(Slot));
        assembly{
            value:=sload(add(location,index))
        }
        
    } 

    function SmallArrayView(uint index) public view returns(uint256 value,bytes32 location){
        uint Slot;
        assembly{
            Slot:=smallArray.slot
        }
        location=keccak256(abi.encode(Slot));
        assembly{
            value:=sload(add(location,index))
        }
        
    } 

    function ViewMymapping(uint key) public view returns(bytes32 location,uint value){
        uint Slot;
        assembly{
            Slot:=Mymapping.slot
        }
        location=keccak256(abi.encode(key,uint256(Slot)));
        assembly{
            value:=sload(location)
        }
    }

    function ViewNestedmapp(uint key1, address key2) public view returns(bytes32 location,uint256 value){
        uint256 Slot;
        assembly{
            Slot:=nestedMapping.slot
        }
        location= keccak256(abi.encode(address(key2),keccak256(abi.encode(uint256(key1),Slot))));
        assembly{
            value:=sload(location)
        }
    }


    function slotView(uint _slot) public view returns(bytes32 value){
        assembly{
            value:=sload(_slot)

        }
    }
 


}