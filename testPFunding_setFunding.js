const Web3 = require("web3");
const web3 = new Web3(
  "https://goerli.infura.io/v3/e7e63350a02446cd83ab4073d9c266d4"
);
const privatekey =
  "b184a24d648059951744a7e7767eed36df31475a0d92db1f82894ebfe075edf4";
web3.eth.accounts.privateKeyToAccount(privatekey);
const account = web3.eth.accounts.privateKeyToAccount(privatekey);
web3.eth.defaultAccount = account.address;
web3.eth.accounts.wallet.add(account);

let ABI = [
  {
    inputs: [
      { internalType: "address payable", name: "_adminAddr", type: "address" },
    ],
    stateMutability: "nonpayable",
    type: "constructor",
  },
  {
    inputs: [],
    name: "admin",
    outputs: [
      { internalType: "contract Administrator", name: "", type: "address" },
    ],
    stateMutability: "view",
    type: "function",
    constant: true,
  },
  {
    inputs: [{ internalType: "address", name: "", type: "address" }],
    name: "donateList",
    outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
    stateMutability: "view",
    type: "function",
    constant: true,
  },
  {
    inputs: [],
    name: "newFunding",
    outputs: [
      { internalType: "string", name: "fundingName", type: "string" },
      { internalType: "uint256", name: "fundingStartDate", type: "uint256" },
      { internalType: "uint256", name: "fundingEndDate", type: "uint256" },
      { internalType: "string", name: "docId", type: "string" },
    ],
    stateMutability: "view",
    type: "function",
    constant: true,
  },
  {
    inputs: [
      { internalType: "string", name: "_fundingName", type: "string" },
      { internalType: "uint256", name: "_fundingStartDate", type: "uint256" },
      { internalType: "uint256", name: "_fundingEndDate", type: "uint256" },
      { internalType: "string", name: "_docId", type: "string" },
    ],
    name: "setFunding",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
  {
    inputs: [
      { internalType: "uint256", name: "_fundingEndDate", type: "uint256" },
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
          { internalType: "string", name: "fundingName", type: "string" },
          {
            internalType: "uint256",
            name: "fundingStartDate",
            type: "uint256",
          },
          { internalType: "uint256", name: "fundingEndDate", type: "uint256" },
          { internalType: "string", name: "docId", type: "string" },
        ],
        internalType: "struct ProjectFunding.funding",
        name: "",
        type: "tuple",
      },
    ],
    stateMutability: "view",
    type: "function",
    constant: true,
  },
  {
    inputs: [{ internalType: "uint256", name: "_amount", type: "uint256" }],
    name: "donate",
    outputs: [],
    stateMutability: "payable",
    type: "function",
    payable: true,
  },
  {
    inputs: [],
    name: "getBalance",
    outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
    stateMutability: "view",
    type: "function",
    constant: true,
  },
  {
    inputs: [{ internalType: "address", name: "_user", type: "address" }],
    name: "getMyDonateAmount",
    outputs: [{ internalType: "uint256", name: "", type: "uint256" }],
    stateMutability: "view",
    type: "function",
    constant: true,
  },
  {
    inputs: [{ internalType: "address payable", name: "_to", type: "address" }],
    name: "withdrawMoney",
    outputs: [],
    stateMutability: "nonpayable",
    type: "function",
  },
];
let CA = "0x654d15BDdf53cb9738F653ac110a012Ebf281DBf";

let CON_PF = new web3.eth.Contract(ABI, CA);

// setFunding
// 제목 / 모금 시작 시간 / 모금 종료 시간 / DB의 DocId
// CON_PF.methods
//   .setFunding("운영진에게 기부하기", 1672542000, 1704078000, "z_adminFunding")
//   .send({
//     from: web3.eth.defaultAccount,
//     gasPrice: "30000000000",
//     gas: "170000",
//   })
//   .then(console.log);

// 기부하기
// CON_PF.methods
//   .donate(BigInt(10000000000000000))
//   .send({
//     from: web3.eth.defaultAccount,
//     gasPrice: "30000000000",
//     gas: "150000",
//     value: "10000000000000000",
//   })
//   .then(console.log);

// 나의 모금액 확인하기
// CON_PF.methods
//   .getMyDonateAmount("0xBE356D158Da29D762cE271DbB5f1E00D5C925542")
//   .call()
//   .then(console.log);

// 출금
// CON_PF.methods
//   .withdrawMoney("0xbe356d158da29d762ce271dbb5f1e00d5c925542")
//   .send({
//     from: web3.eth.defaultAccount,
//     gasPrice: "30000000000",
//     gas: "50000",
//   })
//   .then(console.log);
