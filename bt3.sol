// SPDX-License-Identifier: MIT

pragma solidity >=0.5.0 <0.9.0;

contract demo{
    uint x;

    fallback() external{
        x = 2;
    }

    function get() public view returns(uint){
        return x;
    }

}

contract StudentMgmt {

    function callDemo(demo d) public returns (bool){
        (bool success,) = address(d).call(abi.encodeWithSignature("nonExistingFunction()"));
        require(success);
        address payable i = payable(address(d));
        return i.send(2 ether);
    }

    struct Student {
        int256 stud_id;
        string name;
        string department;
    }
    Student[] Students;

    function addStudent(
        int256 stud_id,
        string memory name,
        string memory department
    ) public {
        Student memory stud = Student(stud_id, name, department);
        Students.push(stud);
    }

    function getStudent(int256 stud_id)
        public
        view
        returns (string memory, string memory)
    {
        for (uint256 i = 0; i < Students.length; i++) {
            Student memory stud = Students[i];
            if (stud.stud_id == stud_id) {
                return (stud.name, stud.department);
            }
        }
        return ("Not Found", "Not Found");
    }

}
