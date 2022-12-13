// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 운영진 컨트랙트
contract Administrator {
    struct pFunding {
        address addr;
        // 추가로 더 들어갈 수 있음
    }

    mapping (address => pFunding) pFundingList;
    ProjectFunding public pF;

    // 프로젝트 펀딩 등록 - 프로젝트 펀딩 컨트랙트에서 펀딩 생성 시 작동
    function registerPFunding() public {
        pF = ProjectFunding(msg.sender);
        pFundingList[msg.sender] = pFunding( // msg.sender는 각 프로젝트 펀딩 컨트랙트 주소
            msg.sender

            );
    }

}

// 프로젝트 펀딩 컨트랙트
contract ProjectFunding {
    
    enum Status { in_progress, done, not_started }
    
    struct funding {
        string fundingName; // 펀딩 이름
        uint targetAmount; // 목표 모금액
        uint currentAmount; // 현재 모금액
        uint fundingStartDate; // 펀딩 시작일
        uint fundingEndDate; // 펀딩 종료일 
        Status fundingState; // 펀딩 상태
    }   
    
    // 펀딩 설정
    function setFunding( // 펀딩 생성 시 입력할 값
        string memory _fundingName, // 펀딩 이름
        uint _targetAmount, // 목표 모금액
        uint _fundingStartDate, // 펀딩 시작일 설정 : 지금으로부터 며칠 뒤에 시작할건지 예) 3 입력하면 3일 뒤부터 시작
        uint _fundingDays // 펀딩 진행 일 수 예) 30 입력하면 시작일로부터 30일 동안 진행
    ) public {
        funding memory newFunding = funding({
            fundingName: _fundingName,
            targetAmount: _targetAmount,
            currentAmount: 0,
            fundingStartDate: block.timestamp + _fundingStartDate * 1 days,
            fundingEndDate: _fundingStartDate + _fundingDays * 1 days,
            fundingState: Status.not_started
        });
    }
}