//
//  CorePlan+CoreDataProperties.swift
//  PlannerCal
//
//  Created by Kamaal M Farah on 04/04/2021.
//
//

import Foundation
import CoreData


extension CorePlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CorePlan> {
        return NSFetchRequest<CorePlan>(entityName: "CorePlan")
    }

    @NSManaged public var createdTime: Date
    @NSManaged public var endDate: Date
    @NSManaged public var id: UUID
    @NSManaged public var notes: String?
    @NSManaged public var startDate: Date
    @NSManaged public var title: String
    @NSManaged public var updatedTime: Date
    @NSManaged public var doneDate: Date?
    @NSManaged public var category: String?

}

extension CorePlan : Identifiable {

}
