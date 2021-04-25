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
                ModifyPlanWithDates(title: $viewModel.editedTitle,
                                    startDate: $viewModel.editedStartDate,
                                    endDate: $viewModel.editedEndDate,
                                    notes: $viewModel.editedNotes)
            } else {
                VStack {
                    PlanSelectionInfoRow(label: .TITLE_INPUT_FIELD_LABEL, value: unwrappedPlanTitle)
                        .padding(.bottom, 8)
                    PlanSelectionInfoRow(label: .START_DATE_LABEL,
                                         value: Self.dateFormatter.string(from: unwrappedPlanStartDate))
                        .padding(.bottom, 8)
                    PlanSelectionInfoRow(label: .END_DATE_LABEL,
                                         value: Self.dateFormatter.string(from: planEndDate))
                        .padding(.bottom, 8)
                    if let planDoneDate = planModel.planToShow?.doneDate {
                        PlanSelectionInfoRow(label: .DONE, value: Self.dateFormatter.string(from: planDoneDate))
                            .padding(.bottom, 8)
                    }
                    if let notes = planModel.planToShow?.notes {
                        PlanSelectionInfoRow(label: .NOTES, value: notes)
                            .padding(.bottom, 8)
                    }
                    Spacer()
                    if planModel.planToShow?.doneDate == nil {
                        Button(action: {
                            guard let plan = planModel.planToShow else { return }
                            do {
                                try planModel.setPlanToDone(plan)
                            } catch {
                                console.error(Date(), error.localizedDescription, error)
                                return
                            }
                        }) {
                            Text(localized: .DONE)
                        }
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
                    Text(localized: .CANCEL)
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
                    viewModel.editedTitle = unwrappedPlanTitle
                    viewModel.editedStartDate = unwrappedPlanStartDate
                    viewModel.editedEndDate = planEndDate
                    viewModel.editedNotes = planModel.planToShow?.notes ?? ""
                    withAnimation { viewModel.editMode = true }
                }
            }) {
                Text(localized: viewModel.editMode ? .SAVE : .EDIT)
            }
        })
    }

    private var unwrappedPlanTitle: String {
        planModel.planToShow?.title ?? ""
    }

    private var unwrappedPlanStartDate: Date {
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

struct PlanSelectionScreen_Previews: PreviewProvider {
    static var previews: some View {
        let planModel = PlanModel(amountOfDaysToDisplay: 5, preview: true)
        planModel.showPlan(planModel.currentPlans.first(where: { $0.value.first != nil })?.value.first?.renderPlan)
        return PlanSelectionScreen()
            .environmentObject(planModel)
    }
}
