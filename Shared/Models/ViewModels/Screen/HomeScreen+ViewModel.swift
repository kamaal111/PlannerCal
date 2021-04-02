//
//  HomeScreen+ViewModel.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 02/04/2021.
//

import Foundation
import ShrimpExtensions

extension HomeScreen {

    final class ViewModel: ObservableObject {

        @Published private(set) var viewWidth: CGFloat = 100
        /// - TODO: Should be in a seperate enviroment view model
        @Published private(set) var currentDays: [Date] = [] {
            didSet {
                print(currentDays)
            }
        }

        let days = [
            "Mon",
            "Tue",
            "Wed"
        ]

        init() {
            let today = Date()
            self.currentDays = (0..<5).compactMap {
                Calendar.current.date(byAdding: .day, value: $0 - 1, to: today)
            }
        }

        func setViewWidth(with width: CGFloat) {
            guard width != viewWidth else { return }
            viewWidth = width
        }

    }

}
