//
//  BeaconChain.swift
//  swift-beacon-chain
//
//  Created by Dean Eigenmann on 16.01.19.
//  Copyright © 2019 Dean Eigenmann. All rights reserved.
//

import Foundation

class BeaconChain {

    // var state: BeaconState!! // @todo we may not need this here if we make the chain "stateless" and require the state to be passed with function calls

    func getInitialBeaconState(initialValidatorDeposits: [Deposit], genesisTime: TimeInterval, lastDepositRoot: Data) -> BeaconState {
        let state = genesisState(genesisTime: genesisTime, lastDepositRoot: lastDepositRoot)

        for deposit in initialValidatorDeposits {
            processDeposit(state: state, deposit: deposit)
        }

        for (i, _) in state.validatorRegistry.enumerated() {
            if (getEffectiveBalance(state: state, index: i) >= MAX_DEPOSIT * GWEI_PER_ETH) {
                activateValidator(state: state, index: i, genesis: true)
            }
        }

        return state
    }

    func processDeposit(state: BeaconState, deposit: Deposit) {
        // @todo
    }

    func getEffectiveBalance(state: BeaconState, index: Int) -> Int {
        return min(state.validatorBalances[index], MAX_DEPOSIT * GWEI_PER_ETH)
    }

    private func genesisState(genesisTime: TimeInterval, lastDepositRoot: Data) -> BeaconState {
        return BeaconState(
            slot: GENESIS_SLOT,
            genesisTime: genesisTime,
            forkData: ForkData(
                preForkVersion: GENESIS_FORK_VERSION,
                postForkVersion: GENESIS_FORK_VERSION,
                forkSlot: GENESIS_SLOT
            ),
            validatorRegistry: [ValidatorRecord](),
            validatorBalances: [Int](),
            validatorRegistryLatestChangeSlot: GENESIS_SLOT,
            validatorRegistryExitCount: 0,
            validatorRegistryDeltaChainTip: ZERO_HASH,
            latestRandaoMixes: [](), // @todo
            latestVdfOutputs: [](), // @todo
            previousEpochStartShard: GENESIS_START_SHARD,
            currentEpochStartShard: GENESIS_START_SHARD,
            previousEpochCalculationSlot: GENESIS_SLOT,
            currentEpochCalculationSlot: GENESIS_SLOT,
            previousEpochRandaoMix: ZERO_HASH,
            currentEpochRandaoMix: ZERO_HASH,
            previousJustifiedSlot: GENESIS_SLOT,
            justifiedSlot: GENESIS_SLOT,
            justificationBitfield: 0,
            finalizedSlot: GENESIS_SLOT,
            latestCrosslinks: [CrosslinkRecord(slot: GENESIS_SLOT, shardBlockRoot: ZERO_HASH)], // for _ in range(SHARD_COUNT)],
            latestBlockRoots: [ZERO_HASH], // [ZERO_HASH for _ in range(LATEST_BLOCK_ROOTS_LENGTH)],
            latestPenalizedExitBalances: [0], // #[0 for _ in range(LATEST_PENALIZED_EXIT_LENGTH)],
            latestAttestations: [Attestation](),
            batchedBlockRoots: [Data](),

            latestDepositRoot: lastDepositRoot,
            depositRootVotes: [DepositRootVote]()
        )
    }

}

extension BeaconChain {

    func activateValidator(state: BeaconState, index: Int, genesis: Bool) {
        state.validatorRegistry[index].activationSlot = genesis ? GENESIS_SLOT : state.slot + ENTRY_EXIT_DELAY

        // @todo
    }

    func initiateValidatorExit(state: BeaconState, index: Int) {
        state.validatorRegistry[index].statusFlags |= INITIATED_EXIT
    }

    func exitValidator(state: BeaconState, index: Int) {
        if (state.validatorRegistry[index].exitSlot <= state.slot + ENTRY_EXIT_DELAY) {
            return
        }

        state.validatorRegistry[index].exitSlot = state.slot + ENTRY_EXIT_DELAY
        state.validatorRegistryExitCount += 1

        // @todo state.validator_registry_delta_chain_tip = hash_tree_root
    }
}