const Web3 = require("web3");
const web3 = new Web3("");
const privatekey = "";
web3.eth.accounts.privateKeyToAccount(privatekey);
const account = web3.eth.accounts.privateKeyToAccount(privatekey);
web3.eth.defaultAccount = account.address;
web3.eth.accounts.wallet.add(account);

let ABI = [
  {
    inputs: [
      {
        internalType: "address payable",
        name: "_adminAddr",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "admin",
    outputs: [
      {
        internalType: "contract Administrator",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address",
        name: "",
        type: "address",
      },
    ],
    name: "donateList",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "newFunding",
    outputs: [
      {
        internalType: "string",
        name: "fundingName",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "fundingStartDate",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "fundingEndDate",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "string",
        name: "_fundingName",
        type: "string",
      },
      {
        internalType: "uint256",
        name: "_fundingStartDate",
        type: "uint256",
      },
      {
        internalType: "uint256",
        name: "_fundingEndDate",
        type: "uint256",
      },
    ],
    name: "setFunding",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_fundingEndDate",
        type: "uint256",
      },
    ],
    name: "extendEndDate",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [],
    name: "getFunding",
    outputs: [
      {
        components: [
          {
            internalType: "string",
            name: "fundingName",
            type: "string",
          },
          {
            internalType: "uint256",
            name: "fundingStartDate",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "fundingEndDate",
            type: "uint256",
          },
        ],
        internalType: "struct ProjectFunding.funding",
        name: "",
        type: "tuple",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "uint256",
        name: "_amount",
        type: "uint256",
      },
    ],
    name: "donate",
    outputs: [],
    stateMutability: "payable",
    type: "function",
  },
  {
    inputs: [],
    name: "getBalance",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [],
    name: "getMyDonateAmount",
    outputs: [
      {
        internalType: "uint256",
        name: "",
        type: "uint256",
      },
    ],
    stateMutability: "view",
    type: "function",
  },
  {
    inputs: [
      {
        internalType: "address payable",
        name: "_to",
        type: "address",
      },
    ],
    name: "withdrawMoney",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];
let CA = "0xf515195d63E6BFBF392FBC6b259b8B638FfE5C85";

let CON_PF = new web3.eth.Contract(ABI, CA);

CON_PF.methods // 제목 / 모금 시작 시간 / 모금 종료 시간
  .setFunding("장애인 월세 기부하기", 1673751600, 1675134000)
  .send({
    from: web3.eth.defaultAccount,
    gasPrice: "30000000000",
    gas: "150000",
  })
  .then(console.log);
