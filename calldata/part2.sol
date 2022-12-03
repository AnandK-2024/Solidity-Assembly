// SPDX-License-Identifier: No License (None)
pragma solidity 0.8.17;

contract Call{


// fallback function has not any function signature//
        fallback(bytes calldata data) external payable returns(bytes memory returndata){
                assembly{
                    let cd:=calldataload(0)
                    let selector:=shr(0xe0,cd)
                    switch selector

                    case 0xb8966352 {
                        Get(2)
                    }

                    case 0x6d4ce63c{
                            Get(getnovalue())
                    }
                    default{
                        revert(0,0)
                    }       

                    function Get( x)   {
                    mstore(0,x)
                    return(0,32)
                }


                function getnovalue()->returnvalue{
                    if gt(calldatasize(),32){
                        revert(0,0)
                    }
                    let argument:=calldataload(4)
                    if eq(argument,4){
                        returnvalue:=8
                        leave
                    }
                    returnvalue:=99
                }

                }



        }



}
