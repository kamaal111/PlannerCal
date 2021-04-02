//
//  PlanModel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 02/04/2021.
//

import Foundation
import Combine

final class PlanModel: ObservableObject {

    @Published private(set) var currentDays: [Date]

    init() {
        let now = Date()
        self.currentDays = (0..<5).compactMap {
            Calendar.current.date(byAdding: .day, value: $0 - 1, to: now)
        }
    }

}
