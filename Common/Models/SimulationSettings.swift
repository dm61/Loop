//
//  SimulationSettings.swift
//  Loop
//
//  Created by Dragan Maksimovic on 4/29/20.
//  Copyright © 2020 LoopKit Authors. All rights reserved.
//

import Foundation
import LoopKit
import HealthKit
import LoopCore
import MockKit

public func simulationSettings() {
    
    let simulationBasalRateSchedule = BasalRateSchedule(dailyItems: [RepeatingScheduleValue(startTime: 0, value: 1.0)])!
    let simulationInsulinSensitivitySchedule = InsulinSensitivitySchedule(unit: .milligramsPerDeciliter, dailyItems: [RepeatingScheduleValue(startTime: 0, value: 100.0)])!
    let simluationCarbRatioSchedule = CarbRatioSchedule(unit: .gram(), dailyItems: [RepeatingScheduleValue(startTime: 0, value: 10.0)])!
    let simulationGlucoseTargetRangeSchedule = GlucoseRangeSchedule(unit: .milligramsPerDeciliter, dailyItems: [RepeatingScheduleValue(startTime: 0, value: DoubleRange(minValue: 100, maxValue: 100))])!

    let simulationSuspendThreshold = GlucoseThreshold(unit: .milligramsPerDeciliter, value: 70)
    let simulationInsulinModelSettings = InsulinModelSettings(model: ExponentialInsulinModelPreset.humalogNovologAdult)
    let simulationDosingStrategy: DosingStrategy = .automaticBolus
    
    let simulationMaximumBolus = 5.0
    let simulationMaximumBasalRatePerHour = 5.0
    
    MockCGMState.mockHumanGlucose = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: 135)
        
    // set user defaults

    UserDefaults.appGroup?.loopSettings?.dosingStrategy = simulationDosingStrategy
    
    UserDefaults.appGroup?.basalRateSchedule = simulationBasalRateSchedule
    UserDefaults.appGroup?.carbRatioSchedule = simluationCarbRatioSchedule
    UserDefaults.appGroup?.insulinSensitivitySchedule = simulationInsulinSensitivitySchedule
    UserDefaults.appGroup?.loopSettings?.glucoseTargetRangeSchedule = simulationGlucoseTargetRangeSchedule
    UserDefaults.appGroup?.loopSettings?.dosingEnabled = true
    
    UserDefaults.appGroup?.insulinModelSettings = simulationInsulinModelSettings
    
    UserDefaults.appGroup?.loopSettings?.maximumBasalRatePerHour = simulationMaximumBasalRatePerHour
    UserDefaults.appGroup?.loopSettings?.maximumBolus = simulationMaximumBolus
    UserDefaults.appGroup?.loopSettings?.suspendThreshold = simulationSuspendThreshold
    
}
