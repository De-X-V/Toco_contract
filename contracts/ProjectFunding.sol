// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./Administrator.sol";

contract ProjectFunding {
  
    Administrator public admin;
    address owner;

    constructor(address _adminAddr) {
        owner = msg.sender;
        admin = Administrator(_adminAddr);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    struct funding {
        string fundingName; // 펀딩 이름
        uint targetAmount; // 목표 모금액
        uint currentAmount; // 현재 모금액
        uint fundingStartDate; // 펀딩 시작일(unix time) 예) 12/18 22:00
        uint fundingEndDate; // 펀딩 종료일(unix time) 예)  12/31 23:59
    }   

    funding public newFunding; // funding구조체형 변수 newFunding 선언
    
    // 펀딩 설정
    function setFunding( // 펀딩 생성 시 입력할 값
        string memory _fundingName, // 펀딩 이름
        uint _targetAmount, // 목표 모금액 -> 이더 단위로 입력
        uint _fundingStartDate, 
        uint _fundingEndDate 
    ) public {
        newFunding = funding({
            fundingName: _fundingName,
            targetAmount: _targetAmount * 10 ** 18,
            currentAmount: 0,
            fundingStartDate: _fundingStartDate,
            fundingEndDate: _fundingEndDate
        });

        // 운영진 컨트랙트에 만든 펀딩 추가
        admin.registerPFunding();
    }

    // 펀딩 정보 출력하는 함수 -> tuple로 출력
    function getFunding() public view returns (funding memory) {
        return newFunding;
    }

    // 기부 리스트
    mapping (address => uint) public donateList; // 각 펀딩 마다 기부한 사람 주소와 금액 알 수 있음

    // 기부하는 기능 - wei 단위로
    function donate(uint _amount) public payable { // 각 펀딩 컨트랙트에 기부금이 쌓임
        // 기부금이 0원 이상, 입력값이랑 같은지 확인
        require(msg.value > 0 && msg.value == _amount);
        // 현재 시간이 기부 시작일과 종료일 사이 인지 확인
        require(block.timestamp > newFunding.fundingStartDate && block.timestamp < newFunding.fundingEndDate);
        // 기부
        donateList[msg.sender] += _amount;

        // 해당 펀딩의 currentAmount 올려주기
        newFunding.currentAmount += _amount;
        // donator 정보 추가
        admin.setDonator(msg.sender);
        admin.addDonatedPFList(msg.sender);
    }

    // 컨트랙트 쌓인 잔고 보여주는 함수
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // 컨트랙트 쌓인 잔고 출금 함수 (오직 owner만)
    function withdrawMoney(address payable _to) public onlyOwner {
        _to.transfer(getBalance());
    }
}
