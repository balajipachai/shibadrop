// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {
    ERC1155ShibaDropContractOffererImplementation
} from "./ERC1155ShibaDropContractOffererImplementation.sol";

import { PublicDrop, MultiConfigureStruct } from "./ERC1155ShibaDropStructs.sol";

import { AllowListData, CreatorPayout } from "./ShibaDropStructs.sol";

import {
    IERC1155ContractMetadata
} from "../../interfaces/ERC1155/IERC1155ContractMetadata.sol";

import { IERC1155ShibaDrop } from "../../interfaces/ERC1155/IERC1155ShibaDrop.sol";

import { IERC173 } from "../../interfaces/ERC1155/IERC173.sol";

/**
 * @title  ERC1155ShibaDropConfigurer
 * @author James Wenzel (emo.eth)
 * @author Ryan Ghods (ralxz.eth)
 * @author Stephan Min (stephanm.eth)
 * @author Michael Cohen (notmichael.eth)
 * @notice A helper contract to configure parameters for ERC1155ShibaDrop.
 */
contract ERC1155ShibaDropConfigurer is
    ERC1155ShibaDropContractOffererImplementation
{
    /**
     * @notice Revert with an error if the sender is not the owner
     *         of the token contract.
     */
    error Unauthorized();

    /**
     * @dev Reverts if the sender is not the owner of the token.
     *
     *      This is used as a function instead of a modifier
     *      to save contract space when used multiple times.
     */
    function _onlyOwner(address token) internal view {
        if (msg.sender != IERC173(token).owner()) {
            revert Unauthorized();
        }
    }

    /**
     * @notice Configure multiple properties at a time.
     *
     *         Only the owner of the token can use this function.
     *
     *         Note: The individual configure methods should be used
     *         to unset or reset any properties to zero, as this method
     *         will ignore zero-value properties in the config struct.
     *
     * @param token  The ERC1155ShibaDrop contract address.
     * @param config The configuration struct.
     */
    function multiConfigure(
        address token,
        MultiConfigureStruct calldata config
    ) external {
        // Ensure the sender is the owner of the token.
        _onlyOwner(token);

        if (config.maxSupplyTokenIds.length != 0) {
            if (
                config.maxSupplyTokenIds.length !=
                config.maxSupplyAmounts.length
            ) {
                revert MaxSupplyMismatch();
            }
            for (uint256 i = 0; i < config.maxSupplyTokenIds.length; ) {
                IERC1155ContractMetadata(token).setMaxSupply(
                    config.maxSupplyTokenIds[i],
                    config.maxSupplyAmounts[i]
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (bytes(config.baseURI).length != 0) {
            IERC1155ContractMetadata(token).setBaseURI(config.baseURI);
        }
        if (bytes(config.contractURI).length != 0) {
            IERC1155ContractMetadata(token).setContractURI(config.contractURI);
        }
        if (config.provenanceHash != bytes32(0)) {
            IERC1155ContractMetadata(token).setProvenanceHash(
                config.provenanceHash
            );
        }
        if (
            _cast(config.royaltyReceiver != address(0)) &
                _cast(config.royaltyBps != 0) ==
            1
        ) {
            IERC1155ContractMetadata(token).setDefaultRoyalty(
                config.royaltyReceiver,
                config.royaltyBps
            );
        }

        if (config.publicDrops.length != 0) {
            if (config.publicDrops.length != config.publicDropsIndexes.length) {
                revert PublicDropsMismatch();
            }
            for (uint256 i = 0; i < config.publicDrops.length; ) {
                IERC1155ShibaDrop(address(token)).updatePublicDrop(
                    config.publicDrops[i],
                    config.publicDropsIndexes[i]
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (bytes(config.dropURI).length != 0) {
            IERC1155ShibaDrop(address(token)).updateDropURI(config.dropURI);
        }
        if (config.allowListData.merkleRoot != bytes32(0)) {
            IERC1155ShibaDrop(address(token)).updateAllowList(
                config.allowListData
            );
        }
        if (config.creatorPayouts.length != 0) {
            IERC1155ShibaDrop(address(token)).updateCreatorPayouts(
                config.creatorPayouts
            );
        }
        if (config.allowedFeeRecipients.length != 0) {
            for (uint256 i = 0; i < config.allowedFeeRecipients.length; ) {
                IERC1155ShibaDrop(address(token)).updateAllowedFeeRecipient(
                    config.allowedFeeRecipients[i],
                    true
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (config.disallowedFeeRecipients.length != 0) {
            for (uint256 i = 0; i < config.disallowedFeeRecipients.length; ) {
                IERC1155ShibaDrop(address(token)).updateAllowedFeeRecipient(
                    config.disallowedFeeRecipients[i],
                    false
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (config.allowedPayers.length != 0) {
            for (uint256 i = 0; i < config.allowedPayers.length; ) {
                IERC1155ShibaDrop(address(token)).updatePayer(
                    config.allowedPayers[i],
                    true
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (config.disallowedPayers.length != 0) {
            for (uint256 i = 0; i < config.disallowedPayers.length; ) {
                IERC1155ShibaDrop(address(token)).updatePayer(
                    config.disallowedPayers[i],
                    false
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (config.allowedSigners.length != 0) {
            for (uint256 i = 0; i < config.allowedSigners.length; ) {
                IERC1155ShibaDrop(address(token)).updateSigner(
                    config.allowedSigners[i],
                    true
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (config.disallowedSigners.length != 0) {
            for (uint256 i = 0; i < config.disallowedSigners.length; ) {
                IERC1155ShibaDrop(address(token)).updateSigner(
                    config.disallowedSigners[i],
                    false
                );
                unchecked {
                    ++i;
                }
            }
        }
        if (config.mintTokenIds.length != 0) {
            if (config.mintTokenIds.length != config.mintAmounts.length) {
                revert MintAmountsMismatch();
            }
            IERC1155ShibaDrop(token).multiConfigureMint(
                config.mintRecipient,
                config.mintTokenIds,
                config.mintAmounts
            );
        }
    }
}
