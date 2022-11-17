// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Memory{
    struct Point{
        uint256 x;
        uint256 y;
        uint256 z;
    }

    event LogMemoryPointer(bytes32);
    event LogMemoryPointersize(bytes32,bytes32);



    function MemoryPointer() public {
        bytes32 mem;
        assembly{
            mem:=mload(0x40)
        }
        emit LogMemoryPointer(mem);
        Point memory temp=Point(1,5,6);

        //update free memory pointer (expand memory )     
        assembly{ 
            mem:=mload(0x40)
        }

        emit LogMemoryPointer(mem);
    }

    function MemoryPointer2() public {
        bytes32 mem;
        bytes32 Msizepointer;
        assembly{
            mem:=mload(0x40)
            // Msizepointer:=msize()

        }
        emit LogMemoryPointer(mem);
        Point memory temp=Point(1,5,6);

        //update free memory pointer (expand memory )     
        assembly{ 
            mem:=mload(0x40)
        }

        emit LogMemoryPointer(mem);
    }

    function FixedArray() public {
        bytes32 Freememvalue;
        assembly{
            Freememvalue:= sload(0x40)
            
        }
        emit LogMemoryPointer(Freememvalue);
        uint256[2] memory array=[uint256(2),uint256(3)];
        assembly{
            Freememvalue:=sload(0x40)
        }
        emit LogMemoryPointer(Freememvalue);

    }

    
    function Abiencode() public returns(bytes memory Data) {
        bytes32 mem;
        assembly{
            mem:=mload(0x40)
            // Msizepointer:=msize()

        }
        emit LogMemoryPointer(mem);
        Data=abi.encode(uint256(4),uint256(9));

        //update free memory pointer (expand memory )     
        assembly{ 
            mem:=mload(0x40)
        }



        emit LogMemoryPointer(mem);
    }



    function Viewarray(uint256[] memory arr) public pure returns(bytes32 location,
        bytes32 len,
        bytes32 ivalue1,
        bytes32 ivalue21) {
        bytes32 location;
        bytes32 len;
        bytes32 ivalue1;
        bytes32 ivalue2;
        assembly{
            location:=arr
            len:=mload(arr)
            ivalue1:=mload(add(arr,0x20))
            ivalue1:=mload(add(arr,0x40))
        }
    }



}