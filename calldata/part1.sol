// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ExternalCall{


    // "165c4a16": "multiply(uint256,uint256)",
    // "054c1a75": "get1()",
    // "d2178b08": "get2()",
    function extrnalCall(address contractadd) public  returns(bytes32) {
        assembly{
            mstore(0x00,0xd2178b08)
                              // last 4 bytes function hash(28 ,32)of calling function//          
                              // store return data to memory range(oxoo,0x20) //   
                    let success:=call(gas(),contractadd,callvalue(),28,32,0x00,0x40)
            if iszero(success){
                revert(0,0)
            }
            return(0x00,0x20)
        }

    }


    function getViaRevert(address contractadd) view public returns(bytes32,bytes32) {
    assembly{
        mstore(0x00,0xd2178b08)
        pop(staticcall(gas(),contractadd,28,32,0x00,0x40))
        return(0x00,0x40)
    }
}


function getmultiply(address contractadd, uint val1, uint val2) public view returns(uint256 result){
    assembly{
            let ptr:=mload(0x40)
            mstore(ptr,0x165c4a16)
            mstore(add(ptr,32), val1)
            mstore(add(ptr,64), val2)
            mstore(0x40,add(ptr,0x60))
            let success:=staticcall(gas(),contractadd,add(0x80,28),mload(0x40),0x00,0x20)
            if iszero(success){
                revert(0,0)
            }
            result:=mload(0x00)

    }
}

    function ExtrnalChangeCall(address contractadd, uint val1, uint val2) public returns(uint result) {
        assembly{
            let ptr:=mload(0x40)
            mstore(ptr,0x165c4a16)
            mstore(add(ptr,32), val1)
            mstore(add(ptr,64), val2)
            mstore(0x40,add(ptr,0x60))
            let success:=call(gas(),contractadd,callvalue(),add(0x80,28),mload(0x40),0x00,0x20)
            if iszero(success){
                revert(0,0)
            }
            result:=mload(0x00)

    }
    }


// when you don't known the size of return data
    function UnknownreturnSize(address contractadd, uint val1, uint val2) public returns(uint result) {
        assembly{
            let ptr:=mload(0x40)
            mstore(ptr,0x165c4a16)
            mstore(add(ptr,32), val1)
            mstore(add(ptr,64), val2)
            mstore(0x40,add(ptr,0x60))
            let success:=call(gas(),contractadd,callvalue(),add(0x80,28),mload(0x40),0x00,0x00)
            if iszero(success){
                revert(0,0)
            }
            returndatacopy(0,0,returndatasize())
            result:=mload(0x00)

    }
    }



}