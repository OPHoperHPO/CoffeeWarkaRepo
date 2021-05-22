pragma solidity ^0.8.4;

// SPDX-License-Identifier: UNLICENSED

contract CoffeeCoin {
    string private token_name;
    string private token_symbol;
    uint8 public decimals;
    uint256 private _totalSupply;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);


    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowed;


    constructor() {
        token_name = "CoffeeWarCoin";
        token_symbol = "CWC";
        decimals = 18;
        _totalSupply = 8 * 10 ** (8 + 18);

        balances[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);
    }

    function name() public view returns (string memory){
        return token_name;
    }
    function symbol() public  view returns (string memory) {
        return token_symbol;
    }

    function totalSupply() public view returns (uint) {
        return _totalSupply  - balances[address(0)];
    }

    function balanceOf(address tokenOwner) public view returns (uint balance) {
        return balances[tokenOwner];
    }

    function allowance(address tokenOwner, address spender) public view returns (uint remaining) {
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint tokens) public returns (bool success) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }

    function transfer(address to, uint tokens) public returns (bool success) {
        balances[msg.sender] = safeSub(balances[msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(msg.sender, to, tokens);
        return true;
    }

    function transferFrom(address from, address to, uint tokens) public returns (bool success) {
        balances[from] = safeSub(balances[from], tokens);
        allowed[from][msg.sender] = safeSub(allowed[from][msg.sender], tokens);
        balances[to] = safeAdd(balances[to], tokens);
        emit Transfer(from, to, tokens);
        return true;
    }

    function safeAdd(uint a, uint b) private pure returns (uint c) {
        c = a + b;
        require(c >= a);
    }

    function safeSub(uint a, uint b) private pure returns (uint c) {
        require(b <= a); c = a - b; }
    function safeMul(uint a, uint b) private pure returns (uint c)
        { c = a * b; require(a == 0 || c / a == b); }
    function safeDiv(uint a, uint b) private pure returns (uint c) { require(b > 0);
        c = a / b;
    }
}