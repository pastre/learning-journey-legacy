//
//  LearningObjectiveMO+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 27/12/20.
//
//

import Foundation
import CoreData


extension LearningObjectiveMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningObjectiveMO> {
        return NSFetchRequest<LearningObjectiveMO>(entityName: "LearningObjective")
    }

    @NSManaged public var code: String?
    @NSManaged public var isBasic: Bool
    @NSManaged public var isCore: Bool
    @NSManaged public var name: String?
    @NSManaged public var basicLevel: LevelMO?
    @NSManaged public var currentGoal: LevelMO?
    @NSManaged public var currentLevel: LevelMO?
    @NSManaged public var learningRoad: LearningRoadMO?
    @NSManaged public var levels: NSSet?

}

// MARK: Generated accessors for levels
extension LearningObjectiveMO {

    @objc(addLevelsObject:)
    @NSManaged public func addToLevels(_ value: LevelMO)

    @objc(removeLevelsObject:)
    @NSManaged public func removeFromLevels(_ value: LevelMO)

    @objc(addLevels:)
    @NSManaged public func addToLevels(_ values: NSSet)

    @objc(removeLevels:)
    @NSManaged public func removeFromLevels(_ values: NSSet)

}

extension LearningObjectiveMO : Identifiable {

}
