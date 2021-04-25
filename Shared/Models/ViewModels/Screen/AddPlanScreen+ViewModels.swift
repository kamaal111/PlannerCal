//
//  AddPlanScreen+ViewModels.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 06/04/2021.
//

import Combine
import Dispatch
import Foundation

extension AddPlanScreen {

    final class ViewModel: ObservableObject {

        @Published var planTitle = ""
        @Published var planNotes = ""
        @Published var planStartDate = Date()
        @Published var planEndDate = Date()
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

        func prepareArgsForPlan() -> CorePlan.Args? {
            guard planValidation() else { return nil }
            var notes: String?
            if !planNotes.trimmingByWhitespacesAndNewLines.isEmpty {
                notes = planNotes
            }
            let args = CorePlan.Args(startDate: planStartDate, endDate: planEndDate, title: planTitle, notes: notes)
            return args
        }

        private func planValidation() -> Bool {
            let args = CorePlan.Args(startDate: planStartDate, endDate: planEndDate, title: planTitle, notes: planNotes)
            guard let errorMessage = Validator.planValidation(args) else { return true }
            errorAlertMessage = (errorMessage.title, errorMessage.message)
            return false
        }

    }

}
