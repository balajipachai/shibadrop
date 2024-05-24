// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { ERC1155 } from "../../solady/tokens/ERC1155.sol";

/**
 * @title  ERC1155ConduitPreapproved
 * @notice Solady's ERC1155 with the ShibaSea conduit preapproved.
 */
abstract contract ERC1155ConduitPreapproved is ERC1155 {
    /// @dev The canonical ShibaSea conduit.
    address internal constant _CONDUIT =
        0x9BCb5d51439d218d227D1979d327f7DcD71943F8;

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes calldata data
    ) public virtual override {
        _safeTransfer(_by(), from, to, id, amount, data);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) public virtual override {
        _safeBatchTransfer(_by(), from, to, ids, amounts, data);
    }

    function isApprovedForAll(
        address owner,
        address operator
    ) public view virtual override returns (bool) {
        if (operator == _CONDUIT) return true;
        return ERC1155.isApprovedForAll(owner, operator);
    }

    function _by() internal view virtual returns (address result) {
        assembly {
            // `msg.sender == _CONDUIT ? address(0) : msg.sender`.
            result := mul(iszero(eq(caller(), _CONDUIT)), caller())
        }
    }
}
