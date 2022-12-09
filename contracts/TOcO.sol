// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
    
}