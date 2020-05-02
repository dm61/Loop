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
    
    public static var launchDate = simDate.currentDate()
    
    private var elapsedTime: TimeInterval {
        let currentDate = simDate.currentDate()
        let elapsedTime = currentDate.timeIntervalSince(MockHumanModel.launchDate)
        return elapsedTime
    }
    
    private var unannouncedCarbsGlucoseEffect: Double {
        let startMealMinutes: Double = 360
        let endMealMinutes: Double = 480
        let effectAmplitude = 5.0
        let scale = effectAmplitude * pow(2.0/(endMealMinutes - startMealMinutes), 2.0)
        let time = elapsedTime.minutes
        if time < startMealMinutes || time > endMealMinutes {
            return 0.0
        } else {
            return scale * (time - startMealMinutes) * (endMealMinutes - time)
        }
    }
    
    public func nextGlucose(startingAt currentGlucose: GlucoseValue, predictedGlucose: [PredictedGlucoseValue]) {
        let currentGlucoseValue = currentGlucose.quantity.doubleValue(for: .milligramsPerDeciliter)
        var nextGlucoseValue = predictedGlucose[1].quantity.doubleValue(for: .milligramsPerDeciliter)
        if nextGlucoseValue != currentGlucoseValue  {
            nextGlucoseValue = nextGlucoseValue + unannouncedCarbsGlucoseEffect
            let nextGlucose = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: nextGlucoseValue)
            MockCGMState.mockHumanGlucose = nextGlucose
        }
    }
    

    
}
