//
//  Color+extensions.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 30/03/2021.
//

import SwiftUI

extension Color {
    static let appSecondary: Color = {
        #if os(macOS)
        return Color(NSColor.separatorColor)
        #else
        return Color(.systemGray4)
        #endif
    }()
}
