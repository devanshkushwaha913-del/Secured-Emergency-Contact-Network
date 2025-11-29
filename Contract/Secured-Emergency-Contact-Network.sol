
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Secured Emergency Contact Network
 * @notice A decentralized registry that allows users to securely store and manage
 *         their emergency contact information on-chain.
 */
contract Project {
    
    struct EmergencyContact {
        string name;          // Contact person's name
        string phoneNumber;   // Contact phone number
        uint256 lastUpdated;  // Last update timestamp
    }

    // Mapping: user address => emergency contact details
    mapping(address => EmergencyContact) private contacts;

    // Event triggered when emergency contact is added or updated
    event EmergencyContactUpdated(address indexed user, string name, string phoneNumber);

    /**
     * @notice Register or update your emergency contact information
     * @param _name The emergency contact's name
     * @param _phoneNumber The emergency contact's number
     */
    function setEmergencyContact(string calldata _name, string calldata _phoneNumber) external {
        require(bytes(_name).length > 0, "Name cannot be empty");
        require(bytes(_phoneNumber).length > 0, "Phone number cannot be empty");

        contacts[msg.sender] = EmergencyContact({
            name: _name,
            phoneNumber: _phoneNumber,
            lastUpdated: block.timestamp
        });

        emit EmergencyContactUpdated(msg.sender, _name, _phoneNumber);
    }

    /**
     * @notice Retrieve your emergency contact information
     * @return name, phoneNumber, lastUpdated timestamp
     */
    function getMyEmergencyContact()
        external
        view
        returns (string memory, string memory, uint256)
    {
        EmergencyContact memory ec = contacts[msg.sender];
        return (ec.name, ec.phoneNumber, ec.lastUpdated);
    }

    /**
     * @notice Retrieve emergency contact info for any user
     * @param user The address of the user whose emergency contact is requested
     * @return name, phoneNumber, lastUpdated timestamp
     */
    function getEmergencyContact(address user)
        external
        view
        returns (string memory, string memory, uint256)
    {
        EmergencyContact memory ec = contacts[user];
        return (ec.name, ec.phoneNumber, ec.lastUpdated);
    }
}
