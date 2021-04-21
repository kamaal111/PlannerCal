//
//  CorePlan+extension.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//

import CoreData

extension CorePlan {
    var renderPlan: RenderPlan {
        RenderPlan(original: self)
    }

    #warning("Test this")
    func showInDate(_ date: Date) -> Bool {
        let startDateIsSameDayAsDate = self.startDate.isSameDay(as: date)
        if let doneTime = self.doneDate {
            let doneTimeIsEarlierThanStartDate = doneTime.compare(self.startDate) == .orderedAscending
            if doneTimeIsEarlierThanStartDate {
                let dateIsEarlierThanDoneTime = date.compare(doneTime) == .orderedAscending
                return dateIsEarlierThanDoneTime
            }
            return startDateIsSameDayAsDate
                || doneTime.isSameDay(as: date)
                || date.isBetween(date: self.startDate, andDate: doneTime)
        }
        return startDateIsSameDayAsDate
            || self.endDate.isSameDay(as: date)
            || date.isBetween(date: self.startDate, andDate: self.endDate)
    }

    @discardableResult
    func setPlanToDone(save: Bool = true) -> Result<CorePlan, Error> {
        let now = Date()
        self.doneDate = now
        self.updatedTime = now

        if save {
            do {
                try self.managedObjectContext?.save()
            } catch {
                return .failure(error)
            }
        }

        return .success(self)
    }

    @discardableResult
    func editPlan(with args: CorePlan.Args, save: Bool = true) -> Result<CorePlan, Error> {
        self.updatedTime = Date()
        self.startDate = args.startDate
        self.endDate = args.endDate
        self.notes = args.notes
        self.title = args.title

        if save {
            do {
                try self.managedObjectContext?.save()
            } catch {
                return .failure(error)
            }
        }

        return .success(self)
    }

    @discardableResult
    static func setPlan(args: CorePlan.Args,
                        managedObjectContext: NSManagedObjectContext,
                        save: Bool = true) -> Result<CorePlan, Error> {
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
        let doneDate: Date?
        let title: String
        let notes: String?
        let original: CorePlan?

        init(id: UUID,
             startDate: Date,
             endDate: Date,
             doneDate: Date?,
             title: String,
             notes: String?,
             original: CorePlan? = nil) {
            self.id = id
            self.startDate = startDate
            self.endDate = endDate
            self.doneDate = doneDate
            self.title = title
            self.notes = notes
            self.original = original
        }

        init(original: CorePlan) {
            self.id = original.id
            self.startDate = original.startDate
            self.endDate = original.endDate
            self.doneDate = original.doneDate
            self.title = original.title
            self.notes = original.notes
            self.original = original
        }
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
