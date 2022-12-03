// SPDX-License-Identifier: No License (None)
pragma solidity 0.8.17;

interface IMyContract{

function add(uint x, uint y) external view   returns(uint result);

// function Transfer(address _address, uint amount) external    returns(bool success);
}

 contract CallData is IMyContract{

    // IMyContract public MyContract;
    // constructor(IMyContract _address){
    //     MyContract=IMyContract(_address);
    // }

    function add(uint x, uint y) public  virtual  view  returns(uint  result){
        return (x+y);
        
    }


}

contract Main is CallData{
function Call() public view returns(uint){
    return super.add(23,45);
}

function add(uint x, uint y) public override view returns(uint  value){
    assembly{
            value:=sload(add(x,y))
    }
}
}


