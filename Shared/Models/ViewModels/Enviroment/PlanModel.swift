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
        didSet { fetchPlans() }
    }
    @Published private var amountOfDaysToDisplay: Int
    @Published private(set) var currentPlans: [Date: [CorePlan]] = [:]
    @Published private(set) var planToShow: CorePlan?

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

    func showPlan(_ plan: CorePlan.RenderPlan) {
        guard let originalPlan = plan.original  else { return }
        DispatchQueue.main.async { [weak self] in
            self?.planToShow = originalPlan
        }
    }

    func showPlan(_ plan: CorePlan.RenderPlan?) {
        guard let originalPlan = plan?.original  else { return }
        DispatchQueue.main.async { [weak self] in
            self?.planToShow = originalPlan
        }
    }

    func setPlan(startDate: Date, endDate: Date, title: String, notes: String) throws {
        guard let context = persistenceController.context else { throw Errors.contextMissing }
        let checkedNotes: String?
        if notes.trimmingByWhitespacesAndNewLines.isEmpty {
            checkedNotes = nil
        } else {
            checkedNotes = notes
        }
        let args = CorePlan.Args(startDate: startDate, endDate: endDate, title: title, notes: checkedNotes)
        let plan = try CorePlan.setPlan(args: args, managedObjectContext: context).get()
        var newCurrentPlans: [Date: [CorePlan]] = [:]
        currentDays.forEach { currentDay in
            var filteredCurrentPlans = currentPlans.first(where: { $0.key.isSameDay(as: currentDay) })?.value ?? []
            if plan.startDate.isSameDay(as: currentDay)
                || plan.endDate.isSameDay(as: currentDay)
                || currentDay.isBetween(date: plan.startDate.startOfDay, andDate: plan.endDate.endOfDay) {
                filteredCurrentPlans.append(plan)
            }
            newCurrentPlans[currentDay] = filteredCurrentPlans
        }
        DispatchQueue.main.async { [weak self] in
            self?.currentPlans = newCurrentPlans
        }
    }

    func fetchPlans() {
        guard let firstCurrentDate = currentDays.first?.asNSDate,
              let lastCurrentDate = currentDays.last?.asNSDate else { return }
        let fetchPlansRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CorePlan.description())
        let query = "(startDate >= %@ AND startDate <= %@) OR (endDate >= %@ AND endDate <= %@)"
        let predicate = NSPredicate(format: query, firstCurrentDate, lastCurrentDate, firstCurrentDate, lastCurrentDate)
        fetchPlansRequest.predicate = predicate
        let fetchedPlans: [CorePlan]
        do {
            fetchedPlans = try persistenceController.context?.fetch(fetchPlansRequest) as? [CorePlan] ?? []
        } catch {
            console.error(Date(), error.localizedDescription, error)
            return
        }
        var groupedFetchedPlans: [Date: [CorePlan]] = [:]
        currentDays.forEach { (currentDay: Date) in
            groupedFetchedPlans[currentDay] = fetchedPlans.filter {
                $0.startDate.isSameDay(as: currentDay)
                    || $0.endDate.isSameDay(as: currentDay)
                    || currentDay.isBetween(date: $0.startDate.startOfDay, andDate: $0.endDate.endOfDay)
            }
        }
        DispatchQueue.main.async { [weak self] in
            self?.currentPlans = groupedFetchedPlans
        }
    }

}

extension Date {
    var asNSDate: NSDate { self as NSDate }

    func isBetween(date date1: Date, andDate date2: Date) -> Bool {
        date1.compare(self) == self.compare(date2)
    }
}
