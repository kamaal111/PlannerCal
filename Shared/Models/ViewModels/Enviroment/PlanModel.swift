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

final class PlanModel: ObservableObject {

    @Published private(set) var currentDays: [Date] {
        didSet { fetchPlans() }
    }
    @Published private var amountOfDaysToDisplay: Int
    @Published private(set) var currentPlans: [Date: [CorePlan]] = [:] {
        didSet { print(currentPlans) }
    }

    private let persistenceController = PersistenceController.shared

    init(amountOfDaysToDisplay: Int) {
        guard amountOfDaysToDisplay > 2 else { fatalError("The amount is too low") }
        let now = Date()
        let currentDays = (0..<amountOfDaysToDisplay).compactMap {
            Calendar.current.date(byAdding: .day, value: $0 - 1, to: now)
        }
        self.currentDays = currentDays
        self.amountOfDaysToDisplay = amountOfDaysToDisplay
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

    func setPlan(date: Date, title: String, notes: String) throws {
        guard let context = persistenceController.context else { throw Errors.contextMissing }
        let checkedNotes: String?
        if notes.trimmingByWhitespacesAndNewLines.isEmpty {
            checkedNotes = nil
        } else {
            checkedNotes = notes
        }
        let args = CorePlan.Args(date: date, title: title, notes: checkedNotes)
        let plan = try CorePlan.setPlan(args: args, managedObjectContext: context).get()
        guard let currentDaySameAsPlanDate = currentDays.first(where: { $0.isSameDay(as: plan.date) })
        else { return }
        DispatchQueue.main.async { [weak self] in
            self?.currentPlans[currentDaySameAsPlanDate]?.append(plan)
        }
    }

    func fetchPlans() {
        guard let firstCurrentDate = currentDays.first?.asNSDate,
              let lastCurrentDate = currentDays.last?.asNSDate else { return }
        let fetchPlansRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CorePlan.description())
        let query = NSPredicate(format: "date >= %@ AND date <= %@", firstCurrentDate, lastCurrentDate)
        fetchPlansRequest.predicate = query
        let fetchedPlans: [CorePlan]
        do {
            fetchedPlans = try persistenceController.context?.fetch(fetchPlansRequest) as? [CorePlan] ?? []
        } catch {
            console.error(Date(), error.localizedDescription, error)
            return
        }
        var groupedFetchedPlans: [Date: [CorePlan]] = [:]
        for currentDay in currentDays {
            groupedFetchedPlans[currentDay] = fetchedPlans.filter { $0.date.isSameDay(as: currentDay) }
        }
        DispatchQueue.main.async { [weak self] in
            self?.currentPlans = groupedFetchedPlans
        }
    }

}

extension Date {
    var asNSDate: NSDate { self as NSDate }
}
