//
//  PlanModel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 02/04/2021.
//

import SwiftUI
import CoreData
import ShrimpExtensions
import ConsoleSwift
import PersistanceManager

final class PlanModel: ObservableObject {

    @Published private(set) var currentDays: [Date] {
        didSet {
            self.fetchPlans()
            self.fetchUnfinishedPlans()
        }
    }
    @Published private var amountOfDaysToDisplay: Int
    @Published private(set) var currentPlans: [Date: [CorePlan]] = [:] {
        didSet {
            self.fetchUnfinishedPlans()
        }
    }
    @Published private(set) var planToShow: CorePlan?
    @Published private(set) var unfinishedPlans: [CorePlan] = []

    private let persistenceController: PersistanceManager
    private let preview: Bool

    init(amountOfDaysToDisplay: Int, preview: Bool = false) {
        guard amountOfDaysToDisplay > 2 else { fatalError("The amount is too low") }
        let now = Date()
        let currentDays = (0..<amountOfDaysToDisplay).compactMap {
            Calendar.current.date(byAdding: .day, value: $0 - 1, to: now)
        }
        self.currentDays = currentDays
        self.amountOfDaysToDisplay = amountOfDaysToDisplay
        self.preview = preview
        if preview {
            self.persistenceController = PersistenceController.preview
        } else {
            self.persistenceController = PersistenceController.shared
        }
        self.fetchPlans()
        self.fetchUnfinishedPlans()
    }

    enum Errors: Error {
        case contextMissing
    }

    func setCurrentDaysToFromNow() {
        let now = Date()
        let newCurrentDays = (0..<amountOfDaysToDisplay).compactMap {
            Calendar.current.date(byAdding: .day, value: $0 - 1, to: now)
        }
        DispatchQueue.main.async { [weak self] in
            self?.currentDays = newCurrentDays
        }
    }

    func incrementCurrentDays(by increment: Int) {
        guard currentDays.count > 1 else { return }
        let newCurrentDays = currentDays[0].nextDays(till: amountOfDaysToDisplay, offset: increment)
        DispatchQueue.main.async { [weak self] in
            self?.currentDays = newCurrentDays
        }
    }

    func showPlan(_ plan: CorePlan?) {
        guard let plan = plan else { return }
        DispatchQueue.main.async { [weak self] in
            self?.planToShow = plan
        }
    }

    func showPlan(_ plan: CorePlan.RenderPlan?) {
        showPlan(plan?.original)
    }

    func showPlan(_ plan: CorePlan.RenderPlan) {
        showPlan(plan.original)
    }

    func setPlanToDone(_ plan: CorePlan) throws {
        guard plan.doneDate == nil else { return }
        let editedPlan = try plan.setPlanToDone().get()
        addEditedPlanToCurrentPlans(plan: editedPlan)
    }

    func editPlan(_ plan: CorePlan, with args: CorePlan.Args) throws {
        let editedPlan = try plan.editPlan(with: args).get()
        addEditedPlanToCurrentPlans(plan: editedPlan)
    }

    func setPlan(with args: CorePlan.Args) throws {
        guard let context = persistenceController.context else { throw Errors.contextMissing }
        let plan = try CorePlan.setPlan(args: args, managedObjectContext: context).get()
        var newCurrentPlans: [Date: [CorePlan]] = [:]
        currentDays.forEach { currentDay in
            var filteredCurrentPlans = currentPlans.first(where: { $0.key.isSameDay(as: currentDay) })?.value ?? []
            if plan.showInDate(currentDay) {
                filteredCurrentPlans.append(plan)
            }
            newCurrentPlans[currentDay] = filteredCurrentPlans
        }
        DispatchQueue.main.async { [weak self] in
            self?.currentPlans = newCurrentPlans
        }
    }

    #warning("optimise")
    private func fetchPlans() {
        let fetchPlansRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CorePlan.description())
        let fetchedPlans: [CorePlan]
        do {
            fetchedPlans = try persistenceController.context?.fetch(fetchPlansRequest) as? [CorePlan] ?? []
        } catch {
            console.error(Date(), error.localizedDescription, error)
            return
        }
        let groupedFetchedPlans: [Date: [CorePlan]] = groupPlansInDates(plans: fetchedPlans, dates: currentDays)
        DispatchQueue.main.async { [weak self] in
            self?.currentPlans = groupedFetchedPlans
        }
    }

    private func fetchUnfinishedPlans() {
        let todayAsNSDate = Date().endOfDay.asNSDate
        let fetchPlansRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CorePlan.description())
        let query = "endDate < %@ AND doneDate = nil"
        let predicate = NSPredicate(format: query, todayAsNSDate)
        fetchPlansRequest.predicate = predicate
        let fetchedPlans: [CorePlan]
        do {
            fetchedPlans = try self.persistenceController.context?.fetch(fetchPlansRequest) as? [CorePlan] ?? []
        } catch {
            console.error(Date(), error.localizedDescription, error)
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.unfinishedPlans = fetchedPlans
        }
    }

    private func addEditedPlanToCurrentPlans(plan editedPlan: CorePlan) {
        var newCurrentPlans: [Date: [CorePlan]]?
        for (currentDate, currentDatePlans) in currentPlans {
            if editedPlan.showInDate(currentDate),
               let planIndex = currentDatePlans.firstIndex(where: { $0.id == editedPlan.id }) {
                newCurrentPlans = currentPlans
                newCurrentPlans?[currentDate]?[planIndex] = editedPlan
                break
            }
        }
        guard let unwrappedNewCurrentPlans = newCurrentPlans else { return }
        let currentDaysCopy = self.currentDays
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.currentPlans = unwrappedNewCurrentPlans
            self.currentDays = currentDaysCopy
        }
    }

    private func groupPlansInDates(plans: [CorePlan], dates: [Date]) -> [Date: [CorePlan]] {
        var groupedFetchedPlans: [Date: [CorePlan]] = [:]
        dates.forEach { (currentDay: Date) in
            groupedFetchedPlans[currentDay] = plans.filter { $0.showInDate(currentDay) }
        }
        return groupedFetchedPlans
    }

}
