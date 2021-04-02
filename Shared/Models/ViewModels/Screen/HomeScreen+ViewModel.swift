//
//  HomeScreen+ViewModel.swift
//  PlannerCal
//
//  Created by Kamaal Farah on 02/04/2021.
//

import Foundation
import Combine

extension HomeScreen {

    final class ViewModel: ObservableObject {

        @Published private(set) var viewWidth: CGFloat = 100

        init() { }

        func setViewWidth(with width: CGFloat) {
            guard width != viewWidth else { return }
            viewWidth = width
        }

    }

}
