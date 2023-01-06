// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./Administrator.sol";

contract ProjectFunding {
  
    Administrator public admin;
    address owner;
    address payable adminCA;

    constructor(address payable _adminAddr) {
        owner = msg.sender;
        admin = Administrator(_adminAddr);
        adminCA = _adminAddr;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    struct funding {
        string fundingName; // 펀딩 이름
        uint fundingStartDate; // 펀딩 시작일(unix time) 
        uint fundingEndDate; // 펀딩 종료일(unix time) 
    }   

    funding public newFunding; // funding구조체형 변수 newFunding 선언
    
    // 펀딩 설정
    function setFunding( // 펀딩 생성 시 입력할 값
        string memory _fundingName, // 펀딩 이름
        uint _fundingStartDate, 
        uint _fundingEndDate 
    ) public {
        newFunding = funding({
            fundingName: _fundingName,
            fundingStartDate: _fundingStartDate,
            fundingEndDate: _fundingEndDate
        });
    }

    // 모금 시간 연장
    function extendEndDate(uint _fundingEndDate) public onlyOwner {
        newFunding.fundingEndDate = _fundingEndDate;
    }

    // 펀딩 정보 출력하는 함수 -> tuple로 출력
    function getFunding() public view returns (funding memory) {
        return newFunding;
    }

    // 기부 리스트
    mapping (address => uint) public donateList; // 각 펀딩 마다 기부한 사람 주소와 금액 알 수 있음

    // 기부하는 기능 - wei 단위로
    function donate(uint _amount) public payable { // 각 펀딩 컨트랙트에 기부금이 쌓임
        // 기부금이 0원 이상
        require(msg.value > 0);
        // 현재 시간이 기부 시작일과 종료일 사이 인지 확인
        require(block.timestamp > newFunding.fundingStartDate && block.timestamp < newFunding.fundingEndDate);
        
        // donator 정보 추가
        admin.setDonator(msg.sender);
        // 최초 한 번만 리스트에 해당 펀딩 추가
        if(donateList[msg.sender] == 0) {
            admin.addDonatedPFList(msg.sender);
        }
        
        // 기부
        donateList[msg.sender] += _amount;
    }

    // 컨트랙트 쌓인 잔고 보여주는 함수
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // 나의 기부액 출력
    function getMyDonateAmount() public view returns (uint) {
        return donateList[msg.sender];
    }

    // 컨트랙트 쌓인 잔고 출금 함수 (오직 owner만)
    function withdrawMoney(address payable _to) public onlyOwner {
        // 쌓인 잔고의 95% 송금
        _to.transfer((getBalance() * 95) / 100);

        // 나머지 운영비 5% admin으로 송금
        adminCA.transfer((getBalance()));
    }
}
