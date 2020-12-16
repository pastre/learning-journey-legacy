//
//  LearningRoad+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import CoreData
import Foundation

public extension LearningRoad {
    @nonobjc class func fetchRequest() -> NSFetchRequest<LearningRoad> {
        return NSFetchRequest<LearningRoad>(entityName: "LearningRoad")
    }

    @NSManaged var name: String
    @NSManaged var learningJourney: LearningJourney
}

extension LearningRoad: Identifiable {}
