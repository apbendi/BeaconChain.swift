//
//  ValidatorRecord.swift
//  swift-beacon-chain
//
//  Created by Dean Eigenmann on 15.01.19.
//  Copyright © 2019 Dean Eigenmann. All rights reserved.
//

import Foundation

struct ValidatorRecord {
    let pubkey: Data
    let withdrawalCredentials: Data
    let randaoCommitment: Data
    let randaoLayers: Int
    var activationSlot: Int
    var exitSlot: Int
    let withdrawalSlot: Int
    let penalizedSlot: Int
    let exitCount: Int
    var statusFlags: Int
    let custodyCommitment: Int
    let latestCustodyReseedSlot: Int
    let penultimateCustodyReseedSlot: Int
}
