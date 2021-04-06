//
//  AddPlanScreen+ViewModels.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 06/04/2021.
//

import Combine
import Dispatch
import Foundation
import PCLocale

extension AddPlanScreen {
    final class ViewModel: ObservableObject {
        @Published var planTitle = ""
        @Published var planNotes = ""
        @Published var planDate = Date()
        @Published private(set) var errorAlertMessage: (title: String, message: String) = ("", "") {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self, !self.errorAlertMessage.title.isEmpty else { return }
                    self.showErrorAlert = true
                }
            }
        }
        @Published var showErrorAlert = false {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self, !self.showErrorAlert, !self.errorAlertMessage.title.isEmpty else { return }
                    self.errorAlertMessage = ("", "")
                }
            }
        }

        func planValidation() -> Bool {
            if planTitle.trimmingByWhitespacesAndNewLines.isEmpty {
                errorAlertMessage = (PCLocale.getLocalizableString(of: .TITLE_IS_EMPTY_ALERT_TITLE),
                                     PCLocale.getLocalizableString(of: .TITLE_IS_EMPTY_ALERT_MESSAGE))
                return false
            }
            return true
        }
    }
}
