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



    function Viewarray(uint256[] memory arr) public pure returns(bytes32 ),
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

    function breakfreememPointer(uint[1] memory arr) public returns(uint256){
        assembly{
        mstore(0x40,0x80)
        }
        uint256[2] memory array=[uint256(2),uint256(3)];
        return arr[0];

    }


    uint8[] StorageArray=[1,2,4,5,6,7,8];
    function UnpackedMem() public {
        uint8[] memory array=StorageArray;


    }


    function returnmultivalue(uint256 val1, uint256 val2, string memory val3) public pure returns(uint ,uint , string memory){
        assembly{
            let ptr:=mload(0x40)
            mstore(ptr,val1)
            mstore(add(ptr,32),val2)
            mstore(add(ptr,64),val3)
            return(ptr,add(ptr,64))

        }
    }
    
    function Revert() public {
   assembly{ if eq(caller(),0x5B38Da6a701c568545dCfcB03FcB875f56beddC4){
                mstore(0x00,"function revert not excute")
                revert(0x00,0x20)
    }}
}




}