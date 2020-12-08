//
//  LearningObjective+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import Foundation
import CoreData


extension LearningObjective {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningObjective> {
        return NSFetchRequest<LearningObjective>(entityName: "LearningObjective")
    }

    @NSManaged public var cluster: String
    @NSManaged public var code: String
    @NSManaged public var enterpriseDelta: String
    @NSManaged public var expertDescription: String
    @NSManaged public var intermediateDescription: String
    @NSManaged public var isBasic: Bool
    @NSManaged public var isCore: Bool
    @NSManaged public var learningObjective: String
    @NSManaged public var noviceDescription: String
    @NSManaged public var proficientDescription: String
    @NSManaged public var shared: String
    @NSManaged public var topic: String
    @NSManaged public var current: LearningProgress?
    @NSManaged public var goal: LearningProgress?
    @NSManaged public var learningRoad: LearningRoad
    
    /*
     "current": null,
     "isCore": true,
     "isBasic": true,
     "enterpriseDelta": "",
     "learningObjective": "Use macOS applications and technologies for software development and design.",
     "goal": null
     */

}

extension LearningObjective : Identifiable {

}
