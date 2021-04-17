//
//  PlanSelectionScreen.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 11/04/2021.
//

import SwiftUI
import PCLocale
import ConsoleSwift

struct PlanSelectionScreen: View {
    @EnvironmentObject
    private var planModel: PlanModel

    @ObservedObject
    private var viewModel = ViewModel()

    var body: some View {
        ZStack {
            if viewModel.editMode {
                ModifyPlan(title: $viewModel.editedTitle,
                           startDate: $viewModel.editedStartDate,
                           endDate: $viewModel.editedEndDate,
                           notes: $viewModel.editedNotes)
            } else {
                VStack {
                    PlanSelectionInfoRow(label: .TITLE_INPUT_FIELD_LABEL, value: planTitle)
                        .padding(.bottom, 8)
                    PlanSelectionInfoRow(label: .START_DATE_LABEL,
                                         value: Self.dateFormatter.string(from: planStartDate))
                        .padding(.bottom, 8)
                    PlanSelectionInfoRow(label: .END_DATE_LABEL,
                                         value: Self.dateFormatter.string(from: planEndDate))
                        .padding(.bottom, 8)
                    if let notes = planModel.planToShow?.notes {
                        PlanSelectionInfoRow(label: .NOTES, value: notes)
                            .padding(.bottom, 8)
                    }
                    Spacer()
                    Button(action: { }) {
                        Text("Done")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .padding(.all, 24)
        .alert(isPresented: $viewModel.showErrorAlert, content: {
            Alert(title: Text(viewModel.errorAlertMessage.title), message: Text(viewModel.errorAlertMessage.message))
        })
        .toolbar(content: {
            if viewModel.editMode {
                Button(action: {
                    withAnimation { viewModel.editMode = false }
                }) {
                    #warning("Localize this")
                    Text("Cancel")
                }
            }
            Button(action: {
                if viewModel.editMode {
                    guard viewModel.planValidation() else { return }
                    if let planToEdit = planModel.planToShow {
                        var notes: String?
                        if !viewModel.editedNotes.trimmingByWhitespacesAndNewLines.isEmpty {
                            notes = viewModel.editedNotes
                        }
                        #warning("Put this in view model")
                        let args = CorePlan.Args(startDate: viewModel.editedStartDate,
                                                 endDate: viewModel.editedEndDate,
                                                 title: viewModel.editedTitle,
                                                 notes: notes)
                        do {
                            try planModel.editPlan(planToEdit, with: args)
                        } catch {
                            console.error(Date(), error.localizedDescription, error)
                        }
                    }
                    withAnimation { viewModel.editMode = false }
                } else {
                    viewModel.editedTitle = planTitle
                    viewModel.editedStartDate = planStartDate
                    viewModel.editedEndDate = planEndDate
                    viewModel.editedNotes = planModel.planToShow?.notes ?? ""
                    withAnimation { viewModel.editMode = true }
                }
            }) {
                #warning("Localize this")
                Text(viewModel.editMode ? "Save" : "Edit")
            }
        })
    }

    private var planTitle: String {
        planModel.planToShow?.title ?? ""
    }

    private var planStartDate: Date {
        planModel.planToShow?.startDate ?? Date()
    }

    private var planEndDate: Date {
        planModel.planToShow?.endDate ?? Date()
    }

    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
}

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

struct PlanSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        let planModel = PlanModel(amountOfDaysToDisplay: 5, preview: true)
        planModel.showPlan(planModel.currentPlans.first(where: { $0.value.first != nil })?.value.first?.renderPlan)
        return PlanSelectionScreen()
            .environmentObject(planModel)
    }
}
