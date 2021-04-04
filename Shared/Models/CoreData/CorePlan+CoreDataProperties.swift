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
        return NSFetchRequest<CorePlan>(entityName: CorePlan.description())
    }

    @NSManaged public var createdTime: Date
    @NSManaged public var updatedTime: Date
    @NSManaged public var date: Date
    @NSManaged public var title: String
    @NSManaged public var notes: String?
    @NSManaged public var id: UUID

}

extension CorePlan : Identifiable {

}
