// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Storage{

    uint128 public  A=8;
    uint96 public B=7;
    uint16 public C=5;
    uint8 public D=15;

    function getvalue(uint _slot) public view  returns(bytes32 value1,uint Value2){

        assembly{
            value1:=sload(_slot)
            Value2:=sload(_slot)
        }


    }

    function getOffset() public view   returns(bytes32 value){
        assembly{
            let Value:=sload(D.slot)
            value:=shr(mul(D.offset,8),value)
            // Value:=and(0xffffffff,shifted)
        }
    }

    function setslot(uint _slot, uint value) public {
        assembly{
            sstore(_slot, value)
        }
    }




}