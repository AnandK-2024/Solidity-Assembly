// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17; // use (0.8.17+commit.8df45f5f) in remix ide

contract AssemblyLoop {
    //    optimization desable          ||  optimization enable
    // execution cost=25073 gas         ||  execution cost=23129 gas
    // FunctionHash: "forloop()"="bc68f960"
    // return sum=45
    function forloop() public pure returns (uint256 sum) {
        for (uint256 i; i < 10; ++i) {
            sum = sum + i;
        }
        return sum;
    }


    function loop1() public pure returns (uint sum ){
        assembly {
            for {let i:=0 } lt(i,10){i:=add(i,1)} {
                sum:=add(sum,i)
            
        }
        mstore(0x0,sum)
        return(0x0, 32)
        
        
           }  
    } 
}
