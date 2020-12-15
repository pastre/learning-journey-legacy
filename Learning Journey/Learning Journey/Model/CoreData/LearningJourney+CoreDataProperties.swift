//
//  LearningJourney+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import Foundation
import CoreData


extension LearningJourney {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningJourney> {
        return NSFetchRequest<LearningJourney>(entityName: "LearningJourney")
    }

    @NSManaged public var name: String

}

extension LearningJourney : Identifiable {

}
