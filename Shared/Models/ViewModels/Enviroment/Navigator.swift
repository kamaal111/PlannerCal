//
//  Navigator.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import Combine
import Dispatch

final class Navigator: ObservableObject {
    @Published var screenSelection: ScreenSelection.RawValue? = ScreenSelection.home.rawValue

    enum ScreenSelection: String {
        case home
    }

    func navigate(to screen: ScreenSelection) {
        DispatchQueue.main.async { [weak self] in
            self?.screenSelection = screen.rawValue
        }
    }
}
