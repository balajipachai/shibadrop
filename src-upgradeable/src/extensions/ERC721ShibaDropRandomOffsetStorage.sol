// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {
    ERC721ShibaDropRandomOffsetUpgradeable
} from "./ERC721ShibaDropRandomOffsetUpgradeable.sol";

import {
    ERC721ContractMetadataUpgradeable
} from "../ERC721ContractMetadataUpgradeable.sol";

library ERC721ShibaDropRandomOffsetStorage {
    struct Layout {
        /// @notice The random offset, between 1 and the MAX_SUPPLY at the time of
        ///         being set.
        uint256 randomOffset;
        /// @notice If the collection has been revealed and the randomOffset has
        ///         been set.
        bool revealed;
    }

    bytes32 internal constant STORAGE_SLOT =
        keccak256("openzepplin.contracts.storage.ERC721ShibaDropRandomOffset");

    function layout() internal pure returns (Layout storage l) {
        bytes32 slot = STORAGE_SLOT;
        assembly {
            l.slot := slot
        }
    }
}
