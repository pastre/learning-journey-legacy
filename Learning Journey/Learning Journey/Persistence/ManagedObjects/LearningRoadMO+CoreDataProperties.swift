//
//  LearningRoadMO+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 27/12/20.
//
//

import Foundation
import CoreData


extension LearningRoadMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningRoadMO> {
        return NSFetchRequest<LearningRoadMO>(entityName: "LearningRoad")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var name: String?
    @NSManaged public var learningJourney: LearningJourneyMO?
    @NSManaged public var objectives: NSSet?

}

// MARK: Generated accessors for objectives
extension LearningRoadMO {

    @objc(addObjectivesObject:)
    @NSManaged public func addToObjectives(_ value: LearningObjectiveMO)

    @objc(removeObjectivesObject:)
    @NSManaged public func removeFromObjectives(_ value: LearningObjectiveMO)

    @objc(addObjectives:)
    @NSManaged public func addToObjectives(_ values: NSSet)

    @objc(removeObjectives:)
    @NSManaged public func removeFromObjectives(_ values: NSSet)

}

extension LearningRoadMO : Identifiable {

}
