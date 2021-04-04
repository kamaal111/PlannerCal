//
//  PlanModel.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 02/04/2021.
//

import SwiftUI
import CoreData

final class PlanModel: ObservableObject {

    @Published private(set) var currentDays: [Date] {
        didSet {
            self.planToAddDate = self.currentDays[1]
        }
    }
    @Published private var amountOfDaysToDisplay: Int
    @Published private(set) var plans: [CorePlan] = []
    @Published var planToAddDate: Date

    init(amountOfDaysToDisplay: Int) {
        guard amountOfDaysToDisplay > 2 else { fatalError("The amount is too low") }
        let now = Date()
        let currentDays = (0..<amountOfDaysToDisplay).compactMap {
            Calendar.current.date(byAdding: .day, value: $0 - 1, to: now)
        }
        self.currentDays = currentDays
        self.amountOfDaysToDisplay = amountOfDaysToDisplay
        self.planToAddDate = currentDays[1]
        self.fetchPlans()
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
        guard let secondDate = Calendar.current.date(byAdding: .day, value: increment, to: currentDays[1])
        else { return }
        let newCurrentDays = (0..<amountOfDaysToDisplay).compactMap {
            Calendar.current.date(byAdding: .day, value: $0 - 1, to: secondDate)
        }
        DispatchQueue.main.async { [weak self] in
            self?.currentDays = newCurrentDays
        }
    }

    func fetchPlans() {
        guard let firstCurrentDate = currentDays.first, let lastCurrentDate = currentDays.last else { return }
        let fetchPlanRequest = NSFetchRequest<NSFetchRequestResult>(entityName: CorePlan.description())
        fetchPlanRequest.predicate = NSPredicate(value: true)
        let fetchedPlan: [CorePlan]
        do {
            fetchedPlan = try PersistenceController.shared.context?.fetch(fetchPlanRequest) as? [CorePlan] ?? []
        } catch {
            print(error)
            return
        }
        plans = fetchedPlan
    }

    func addPlanItem(_ date: Date) {
        planToAddDate = date
    }

}

extension Date {
    var startOfDay : Date {
        let calendar = Calendar.current
        let unitFlags = Set<Calendar.Component>([.year, .month, .day])
        let components = calendar.dateComponents(unitFlags, from: self)
        return calendar.date(from: components)!
   }

    var endOfDay : Date {
        var components = DateComponents()
        components.day = 1
        let date = Calendar.current.date(byAdding: components, to: self.startOfDay)
        return (date?.addingTimeInterval(-1))!
    }
}
