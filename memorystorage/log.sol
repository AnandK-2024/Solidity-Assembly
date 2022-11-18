// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Log{
    event Logfire(uint256 indexed value1,uint256 indexed value2);
    event Logfire2(uint256 indexed value3,bool);

    function eventfire() public {
        emit Logfire(2,15);
    }

    function eventFireYUl() external{
        bytes32 hash=keccak256("Logfire(uint256,uint256)");
        assembly{

            log3(0,0,hash,5,9)
        }
    } 


    function eventfire2()external{
        bytes32 hash=keccak256("Logfire2(uint256,bool)");
        assembly{
            mstore(0x00,1)            

   
            log2(0x00,0x40,hash,45)
        }


    }   


    function Destruct() external{
    assembly{
        selfdestruct(caller())
    }
}


}