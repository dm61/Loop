//
//  MockHumanModel.swift
//  Loop
//
//  Created by Dragan Maksimovic on 4/30/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import Foundation
import HealthKit
import LoopKit
import MockKit

class MockHumanModel {
    
    public func nextGlucose(startingAt currentGlucose: GlucoseValue) {
        let nextGlucoseValue = currentGlucose.quantity.doubleValue(for: .milligramsPerDeciliter) + 1.0
        let nextGlucose = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: nextGlucoseValue)
        MockCGMState.mockHumanGlucose = nextGlucose
    }
    
}
