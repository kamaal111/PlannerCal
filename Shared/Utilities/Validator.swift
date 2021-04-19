//
//  Validator.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 17/04/2021.
//

import Foundation
import PCLocale

struct Validator {
    private init() { }

    static func planValidation(_ args: CorePlan.Args) -> (title: String, message: String)? {
        if args.title.trimmingByWhitespacesAndNewLines.isEmpty {
            return (PCLocale.Keys.TITLE_IS_EMPTY_ALERT_TITLE.localized,
                    PCLocale.Keys.TITLE_IS_EMPTY_ALERT_MESSAGE.localized)
        }
        if args.startDate.compare(args.endDate) == .orderedDescending {
            return (PCLocale.Keys.END_DATE_BEFORE_START_ALERT_TITLE.localized,
                    PCLocale.Keys.END_DATE_BEFORE_START_ALERT_MESSAGE.localized)
        }
        return nil
    }
}
