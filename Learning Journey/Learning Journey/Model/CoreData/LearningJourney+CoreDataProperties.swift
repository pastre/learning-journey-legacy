//
//  LearningJourney+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import CoreData
import Foundation

public extension LearningJourney {
    @nonobjc class func fetchRequest() -> NSFetchRequest<LearningJourney> {
        return NSFetchRequest<LearningJourney>(entityName: "LearningJourney")
    }

    @NSManaged var name: String
}

extension LearningJourney: Identifiable {}
