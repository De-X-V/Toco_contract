// SPDX-License-Identifier: MIT

pragma solidity >=0.4.22 <0.9.0;

import "./ProjectFunding.sol";
import "./ChangesFunding.sol";

contract Administrator {
  
    address[] public pFundings; // 프로젝트 펀딩 CA 모음 
    address[] public cFundings; // 잔돈 펀딩 CA 모음

    struct Donator { // 기부자 정보
        address donatorAddr;
        address[] myDonatedPFList; // 기부한 프로젝트 펀딩 컨트랙트 리스트
        address[] myDonatedCFList; // 기부한 잔돈 펀딩 컨트랙트 리스트
    }

    mapping (address => Donator) donators; // 기부자들 모음

    // 프로젝트 펀딩 등록 - 프로젝트 펀딩 컨트랙트에서 펀딩 생성 시 작동 (최초 1회)
    function registerPFunding() public {
        pFundings.push(msg.sender);
    }

    // 잔돈 펀딩 등록 - 프로젝트 펀딩 컨트랙트에서 펀딩 생성 시 작동 (최초 1회)
    function registerCFunding() public {
        cFundings.push(msg.sender);
    }

    // 기부자 등록 -> 맨 처음 기부할 때 한 번만
    function setDonator(address _addr) public {
        if(donators[_addr].donatorAddr == address(0)) {
            donators[_addr].donatorAddr = _addr;
        }
    }

    function getDonator(address _addr) public view returns (Donator memory) {
        return donators[_addr];
    }

    // 기부 시 기부한 펀딩 리스트에 추가
    function addDonatedPFList(address _addr) public {
        donators[_addr].myDonatedPFList.push(msg.sender);
    }

    function addDonatedCFList(address _addr) public {
        donators[_addr].myDonatedCFList.push(msg.sender);
    }

}
