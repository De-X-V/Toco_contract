// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./Administrator.sol";

contract ChangesFunding {
  // 기부 기능 및 응모권 부여
    // 펀딩 설정하기 (시작일 날짜로 설정할 수 있게 - 시작일, 진행 일 수 입력받아서 종료일 계산해서 설정)
    // 래플 기능
    Administrator public admin;

    address public owner;

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
        uint fundingStartDate; // 펀딩 시작일
        uint fundingEndDate; // 펀딩 종료일 
    }

    funding public newFunding; // funding구조체형 변수 newFunding 선언

    // 유저 구조체
    struct users {
        address userAddress; // 기부자 주소
        uint tickets; // 응모권 수
        uint donateAmount; // 기부량
    }

    mapping(string => funding) Funding;
    mapping(address => users) Users;
  
    // 펀딩 생성
    function createFunding( // 펀딩 생성 시 입력할 값
        string memory _fundingName, // 펀딩 이름
        uint _targetAmount, // 목표 모금액
        uint _fundingStartDate, // 펀딩 시작일 설정
        uint _fundingEndDate // 펀딩 종료일 
    ) public {
        newFunding = funding({
            fundingName: _fundingName,
            targetAmount: _targetAmount,
            currentAmount: 0,
            fundingStartDate: _fundingStartDate,
            fundingEndDate: _fundingEndDate
        });
        // 운영진 컨트랙트에 만든 펀딩 추가
        admin.registerCFunding();
    }

    // 펀딩 정보 출력하는 함수 -> tuple로 출력되는데 FE에서 잘 보여질까...??
    function getFunding() public view returns (funding memory) {
        return newFunding;
    }

    function getBlockNumber() public view returns(uint) {
        return block.number ;
    }
    
    mapping(address => uint) userBalance;

    // 기부 기능
    function donate() public payable {
        require(msg.value > 0);
        // 현재 시간이 기부 시작일과 종료일 사이 인지 확인
        require(block.timestamp > newFunding.fundingStartDate && block.timestamp < newFunding.fundingEndDate);
        
        userBalance[msg.sender] += msg.value;
        uint ticket = msg.value/10**16; // 응모권 생성
        
        if(Users[msg.sender].tickets == 0) { // 처음 등록하는 사람인지 확인
            setDonatePerson(); // 등록
        } 
        Users[msg.sender].tickets += ticket; // 응모권 부여
        Users[msg.sender].donateAmount += msg.value; // 기부량 증가
    }

    // 기부자 등록
    function setDonatePerson() public {
        Users[msg.sender] = users(msg.sender, 0, 0);
    }

    // 기부자 조회
    function getDonatePerson(address _a) public view returns(address, uint, uint) {
        return (Users[_a].userAddress, Users[_a].tickets, Users[_a].donateAmount);
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
