//
//  LearningJourneyMO+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 27/12/20.
//
//

import Foundation
import CoreData


extension LearningJourneyMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningJourneyMO> {
        return NSFetchRequest<LearningJourneyMO>(entityName: "LearningJourney")
    }

    @NSManaged public var name: String
    @NSManaged public var roads: NSSet

}

// MARK: Generated accessors for roads
extension LearningJourneyMO {

    @objc(addRoadsObject:)
    @NSManaged public func addToRoads(_ value: LearningRoadMO)

    @objc(removeRoadsObject:)
    @NSManaged public func removeFromRoads(_ value: LearningRoadMO)

    @objc(addRoads:)
    @NSManaged public func addToRoads(_ values: NSSet)

    @objc(removeRoads:)
    @NSManaged public func removeFromRoads(_ values: NSSet)

}

extension LearningJourneyMO : Identifiable {

}
