//
//  ControlCenter.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 02/04/2021.
//

import SwiftUI
import PCLocale

struct ControlCenter: View {
    public let previousDate: () -> Void
    public let goToTodayDate: () -> Void
    public let nextDate: () -> Void

    public init(previousDate: @escaping () -> Void,
                goToTodayDate: @escaping () -> Void,
                nextDate: @escaping () -> Void) {
        self.previousDate = previousDate
        self.goToTodayDate = goToTodayDate
        self.nextDate = nextDate
    }

    var body: some View {
        HStack {
            Button(action: previousDate) {
                Image(systemName: "arrow.left")
            }
            Button(action: goToTodayDate) {
                Text(localized: .NOW)
                    .font(.body)
                    .fontWeight(.semibold)
            }
            Button(action: nextDate) {
                Image(systemName: "arrow.right")
            }
        }
    }
}

struct ControlCenter_Previews: PreviewProvider {
    static var previews: some View {
        ControlCenter(previousDate: { }, goToTodayDate: { }, nextDate: { })
    }
}
