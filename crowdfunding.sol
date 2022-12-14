// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract crowdfunding
{
    address owner;
    constructor()
    {
        owner = msg.sender;
    }

    struct details
    {
        uint date;
        address add;
        uint amount;
        bool store;
    }

    details[] funder_details;

    function donate() public payable
    {
        funder_details.push(details(block.timestamp, msg.sender, msg.value, true));
    }

    function withdraw() public
    {
        uint length = funder_details.length;
        for(uint i=0; i<length; i++)
        {
            if (block.timestamp < funder_details[i].date+172800) //if the owner withdraws the funds within 2 days
            {
                if (funder_details[i].store==true)
                {
                    payable(owner).transfer(funder_details[i].amount); //transferring the funds to the owner's account
                }
                else continue;
            }
            else
            {
                payable(funder_details[i].add).transfer(funder_details[i].amount); //if owner tries to withdraw after 2 days, the funds will be transferred to the funder's account
            }
        }
    }
}
