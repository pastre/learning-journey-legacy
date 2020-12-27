//
//  LevelMO+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 27/12/20.
//
//

import Foundation
import CoreData


extension LevelMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LevelMO> {
        return NSFetchRequest<LevelMO>(entityName: "Level")
    }

    @NSManaged public var colorScheme: String?
    @NSManaged public var levelDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var learningObjective: LearningObjectiveMO?

}

extension LevelMO : Identifiable {

}
