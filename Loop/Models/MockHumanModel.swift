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
    
    private var initialDataDate: Date = simDate.currentDate()
    
    private var firstDataPoint: Bool = false
        
    private var elapsedTime: TimeInterval {
        return simDate.currentDate().timeIntervalSince(initialDataDate)
    }
    
    private let trueInsulinSensitivityMultiplier: Double = 1.0
    
    private var userSettingsISF: Double {
        if let isf = UserDefaults.appGroup?.insulinSensitivitySchedule?.averageQuantity().doubleValue(for: .milligramsPerDeciliter) {
            return isf
        } else {
            return 100.0
        }
    }
    
    private var userSettingsCR: Double {
        if let cr = UserDefaults.appGroup?.carbRatioSchedule?.averageQuantity().doubleValue(for: .gram()) {
            return cr
        } else {
            return 10.0
        }
    }
    
    private var userSettingsCSF: Double {
        return userSettingsISF / userSettingsCR
    }
    
    let mealCarbs: Double = 50
    let startMealMinutes: Double = 240
    let mealDurationMinutes: Double = 240
    let mealPeakMinutes: Double = 90
    
    private var unannouncedMealGlucoseEffect: Double {
        
        let mealPeakEffect = 10.0 * userSettingsCSF * mealCarbs / mealDurationMinutes
        let time = elapsedTime.minutes - startMealMinutes
        switch time {
        case let t where t <= 0:
            return 0.0
        case let t where t > 0.0 && t <= mealPeakMinutes:
            return mealPeakEffect * t / mealPeakMinutes
        case let t where t > mealPeakMinutes && t <= mealDurationMinutes:
            return mealPeakEffect * (mealDurationMinutes - t) / (mealDurationMinutes - mealPeakMinutes)
        default:
            return 0.0
        }
    }
    
    public func nextGlucose(startingAt currentGlucose: GlucoseValue, predictedGlucose: [PredictedGlucoseValue]) {
        let currentGlucoseValue = currentGlucose.quantity.doubleValue(for: .milligramsPerDeciliter)
        var nextGlucoseValue = predictedGlucose[1].quantity.doubleValue(for: .milligramsPerDeciliter)
        let trueInsulinEffect = trueInsulinSensitivityMultiplier * (nextGlucoseValue - currentGlucoseValue)
        if trueInsulinEffect != 0.0  {
            if !firstDataPoint {
                initialDataDate = currentGlucose.startDate
                firstDataPoint = true
            }
            nextGlucoseValue = currentGlucoseValue + trueInsulinEffect + unannouncedMealGlucoseEffect
            let nextGlucose = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: nextGlucoseValue)
            MockCGMState.mockHumanGlucose = nextGlucose
        }
    }
    
}
