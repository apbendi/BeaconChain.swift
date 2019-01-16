//
//  DepositData.swift
//  swift-beacon-chain
//
//  Created by Dean Eigenmann on 16.01.19.
//  Copyright © 2019 Dean Eigenmann. All rights reserved.
//

import Foundation

struct DepositData {
    let amount: Int;
    let timestamp: TimeInterval;
    let depositInput: DepositInput;
}
