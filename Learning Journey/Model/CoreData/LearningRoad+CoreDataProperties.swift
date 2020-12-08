//
//  LearningRoad+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import Foundation
import CoreData


extension LearningRoad {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningRoad> {
        return NSFetchRequest<LearningRoad>(entityName: "LearningRoad")
    }

    @NSManaged public var name: String
    @NSManaged public var learningJourney: LearningJourney

}

extension LearningRoad : Identifiable {

}
