//
//  CorePlan+extension.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import CoreData

extension CorePlan {
    @discardableResult
    static func setPlan(args: CorePlan.Args, managedObjectContext: NSManagedObjectContext, save: Bool = true) -> Result<CorePlan, Error> {
        let plan = CorePlan(context: managedObjectContext)

        let now = Date()
        plan.createdTime = now
        plan.updatedTime = now
        plan.date = args.date
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

    struct Args {
        let date: Date
        let title: String
        let notes: String?

        init(date: Date, title: String, notes: String? = nil) {
            self.date = date
            self.title = title
            self.notes = notes
        }
    }
}
