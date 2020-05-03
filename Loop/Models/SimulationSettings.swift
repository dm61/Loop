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
    
    // initial BG
    MockCGMState.mockHumanGlucose = HKQuantity(unit: .milligramsPerDeciliter, doubleValue: 200)
    
    // basal setting
    let simulationBasalRateSchedule = BasalRateSchedule(dailyItems: [RepeatingScheduleValue(startTime: 0, value: 0.65)])!
    
    // ISF setting
    let simulationInsulinSensitivitySchedule = InsulinSensitivitySchedule(unit: .milligramsPerDeciliter, dailyItems: [RepeatingScheduleValue(startTime: 0, value: 60.0)])!

    // CR setting
    let simulationCarbRatioSchedule = CarbRatioSchedule(unit: .gram(), dailyItems: [RepeatingScheduleValue(startTime: 0, value: 9.0)])!
    
    // Correction range setting
    let simulationGlucoseTargetRangeSchedule = GlucoseRangeSchedule(unit: .milligramsPerDeciliter, dailyItems: [RepeatingScheduleValue(startTime: 0, value: DoubleRange(minValue: 90, maxValue: 95))])!

    // Suspend threshold setting
    let simulationSuspendThreshold = GlucoseThreshold(unit: .milligramsPerDeciliter, value: 75)
    
    // Dosing strategy setting
    let simulationDosingStrategy: DosingStrategy = .automaticBolus

    // Maximum bolus and basal rate settings
    let simulationMaximumBolus = 10.0
    let simulationMaximumBasalRatePerHour = 5.0

    // Insulin model setting
    let simulationInsulinModelSettings = InsulinModelSettings(model: ExponentialInsulinModelPreset.humalogNovologAdult)
    
    // IRC switch setting
    let simulationIntegralRetrospectiveCorrectionEnabled: Bool = false
    
    
    // ***********************************************************
    // User defaults based on the above settings
    // Do not change anything below this line

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
    
    UserDefaults.appGroup?.loopSettings?.integralRetrospectiveCorrectionEnabled = simulationIntegralRetrospectiveCorrectionEnabled
}
