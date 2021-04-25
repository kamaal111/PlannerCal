//
//  AddGeneralItemScreen+ViewModel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 25/04/2021.
//

import Combine
import Dispatch

extension AddGeneralItemScreen {

    final class ViewModel: ObservableObject {

        @Published var title = ""
        @Published var notes = ""

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

    }

}
