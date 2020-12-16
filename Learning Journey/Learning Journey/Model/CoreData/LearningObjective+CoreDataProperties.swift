//
//  LearningObjective+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import CoreData
import Foundation

public extension LearningObjective {
    @nonobjc class func fetchRequest() -> NSFetchRequest<LearningObjective> {
        return NSFetchRequest<LearningObjective>(entityName: "LearningObjective")
    }

    @NSManaged var cluster: String
    @NSManaged var code: String
    @NSManaged var enterpriseDelta: String
    @NSManaged var expertDescription: String
    @NSManaged var intermediateDescription: String
    @NSManaged var isBasic: Bool
    @NSManaged var isCore: Bool
    @NSManaged var learningObjective: String
    @NSManaged var noviceDescription: String
    @NSManaged var proficientDescription: String
    @NSManaged var shared: String
    @NSManaged var topic: String
    @NSManaged var current: LearningProgress?
    @NSManaged var goal: LearningProgress?
    @NSManaged var learningRoad: LearningRoad

    /*
     "current": null,
     "isCore": true,
     "isBasic": true,
     "enterpriseDelta": "",
     "learningObjective": "Use macOS applications and technologies for software development and design.",
     "goal": null
     */
}

extension LearningObjective: Identifiable {}
