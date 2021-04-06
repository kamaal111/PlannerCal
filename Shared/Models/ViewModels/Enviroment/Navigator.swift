//
//  Navigator.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import SwiftUI

final class Navigator: ObservableObject {
    @Published var screenSelection: ScreenSelection.RawValue? = nil {
        didSet { self.screenOptions = [:] }
    }
    @Published private(set) var screenOptions: [String: Any] = [:]

    enum ScreenSelection: String {
        case home
        case addNewPlan
    }

    func navigate(to screen: ScreenSelection, options: [String: Any] = [:]) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.screenSelection = screen.rawValue
            self.screenOptions = options
        }
    }
}
