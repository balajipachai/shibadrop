# Bring Your Own Token Contract

Token creators who would like to use their own token contract functionality can inherit `ERC721ShibaDrop`. There are also several extensions in `src/extensions` such as Burnable and RandomOffset.

ShibaDrop tokens use ERC721A for efficient multiple-quantity mint, along with additional tracking metadata like number of tokens minted by address used for enforcing wallet limits. Please do not override or modify any ShibaDrop-related functionality on the token like `getMintStats()` to remain compatible and secure with ShibaDrop.

For deploy steps, see [ShibaDrop Token Deployment](./ShibaDropTokenDeployment.md).
