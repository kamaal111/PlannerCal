//
//  Navigator.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 29/03/2021.
//

import Combine
import Dispatch

final class Navigator: ObservableObject {
    @Published var sidebarSelection: SidebarSelection.RawValue? = SidebarSelection.home.rawValue

    enum SidebarSelection: String {
        case home
    }

    func navigate(to screen: SidebarSelection) {
        DispatchQueue.main.async { [weak self] in
            self?.sidebarSelection = screen.rawValue
        }
    }
}
