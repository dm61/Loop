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
    
    let simulationBasalRateSchedule = BasalRateSchedule(dailyItems: [RepeatingScheduleValue(startTime: 0, value: 0.65)])!
    let simulationInsulinSensitivitySchedule = InsulinSensitivitySchedule(unit: .milligramsPerDeciliter, dailyItems: [RepeatingScheduleValue(startTime: 0, value: 60.0)])!
    let simulationCarbRatioSchedule = CarbRatioSchedule(unit: .gram(), dailyItems: [RepeatingScheduleValue(startTime: 0, value: 10.0)])!
    let simulationGlucoseTargetRangeSchedule = GlucoseRangeSchedule(unit: .milligramsPerDeciliter, dailyItems: [RepeatingScheduleValue(startTime: 0, value: DoubleRange(minValue: 90, maxValue: 95))])!

    let simulationSuspendThreshold = GlucoseThreshold(unit: .milligramsPerDeciliter, value: 75)
    let simulationInsulinModelSettings = InsulinModelSettings(model: ExponentialInsulinModelPreset.humalogNovologAdult)
    let simulationDosingStrategy: DosingStrategy = .automaticBolus
    
    let simulationMaximumBolus = 10.0
    let simulationMaximumBasalRatePerHour = 5.0
    
    MockCGMState.mockHumanGlucose = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: 200)
    
    MockHumanModel.launchDate = simDate.currentDate()
        
    // set user defaults

    UserDefaults.appGroup?.loopSettings?.dosingStrategy = simulationDosingStrategy
    
    UserDefaults.appGroup?.basalRateSchedule = simulationBasalRateSchedule
    UserDefaults.appGroup?.carbRatioSchedule = simulationCarbRatioSchedule
    UserDefaults.appGroup?.insulinSensitivitySchedule = simulationInsulinSensitivitySchedule
    UserDefaults.appGroup?.loopSettings?.glucoseTargetRangeSchedule = simulationGlucoseTargetRangeSchedule
    UserDefaults.appGroup?.loopSettings?.dosingEnabled = true
    
    UserDefaults.appGroup?.insulinModelSettings = simulationInsulinModelSettings
    
    UserDefaults.appGroup?.loopSettings?.maximumBasalRatePerHour = simulationMaximumBasalRatePerHour
    UserDefaults.appGroup?.loopSettings?.maximumBolus = simulationMaximumBolus
    UserDefaults.appGroup?.loopSettings?.suspendThreshold = simulationSuspendThreshold
    
}
