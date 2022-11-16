//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
contract Storememory{

    





    /// how tostore data in memory
    function StoreMemory(
        address from,
        address to,
        uint value
    ) public payable  returns (bytes32) {

        assembly{// Get a free memory pointer
            let ptr := mload(0x40)

            // Store to address to memory
            mstore(ptr, to)
            
            // Store from address to memory ptr + 32 bytes
            mstore(add(ptr, 32), from)


            // Store x uint to memory + 64 bytes
            mstore(add(ptr, 64), value)


            let success:=call(gas(),to,value,0,0,0,0)
            
            // Store the return value in memory ptr + 96
            mstore(add(ptr, 96), success)

            if eq(success,0){
                revert(0,0)
            }
            return (add(ptr,96),32)

            }




    }




}