//
//  PlanSelectionScreen+ViewModel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 17/04/2021.
//

import Combine
import Foundation

extension PlanSelectionScreen {
    final class ViewModel: ObservableObject {
        @Published var editMode = false
        @Published var editedTitle = ""
        @Published var editedStartDate = Date()
        @Published var editedEndDate = Date()
        @Published var editedNotes = ""
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
            let args = CorePlan.Args(startDate: editedStartDate,
                                     endDate: editedEndDate,
                                     title: editedTitle,
                                     notes: editedNotes)
            guard let errorMessage = Validator.planValidation(args) else { return true }
            errorAlertMessage = (errorMessage.title, errorMessage.message)
            return false
        }
    }
}
