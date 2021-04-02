//
//  HomeScreen+ViewModel.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 02/04/2021.
//

import Combine
import CoreGraphics

extension HomeScreen {
    final class ViewModel: ObservableObject {
        @Published private(set) var viewWidth: CGFloat = 100

        let days = [
            "Mon",
            "Tue",
            "Wed"
        ]

        func setViewWidth(with width: CGFloat) {
            guard width != viewWidth else { return }
            viewWidth = width
        }
    }
}
