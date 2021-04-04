//
//  Navigator.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI

final class Navigator: ObservableObject {
    @Published var screenSelection: ScreenSelection.RawValue? = nil

    enum ScreenSelection: String {
        case home
        case addNewPlan
    }

    func navigate(to screen: ScreenSelection) {
        DispatchQueue.main.async { [weak self] in
            self?.screenSelection = screen.rawValue
        }
    }
}
