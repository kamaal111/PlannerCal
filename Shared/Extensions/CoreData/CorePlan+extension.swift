//
//  CorePlan+extension.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import CoreData

extension CorePlan {
    var renderPlan: RenderPlan {
        .init(id: self.id, startDate: self.startDate, endDate: self.endDate, title: self.title, notes: self.notes)
    }

    @discardableResult
    static func setPlan(args: CorePlan.Args, managedObjectContext: NSManagedObjectContext, save: Bool = true) -> Result<CorePlan, Error> {
        let plan = CorePlan(context: managedObjectContext)

        let now = Date()
        plan.createdTime = now
        plan.updatedTime = now
        plan.startDate = args.startDate
        plan.endDate = args.endDate
        plan.id = UUID()
        plan.notes = args.notes
        plan.title = args.title

        if save {
            do {
                try managedObjectContext.save()
            } catch {
                return .failure(error)
            }
        }

        return .success(plan)
    }

    struct RenderPlan: Identifiable, Hashable {
        let id: UUID
        let startDate: Date
        let endDate: Date
        let title: String
        let notes: String?
    }

    struct Args {
        let startDate: Date
        let endDate: Date
        let title: String
        let notes: String?

        init(startDate: Date, endDate: Date, title: String, notes: String? = nil) {
            self.startDate = startDate
            self.endDate = endDate
            self.title = title
            self.notes = notes
        }
    }
}
