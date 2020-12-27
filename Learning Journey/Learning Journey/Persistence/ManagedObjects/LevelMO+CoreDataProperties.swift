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

    @NSManaged public var name: NSObject?
    @NSManaged public var levelDescription: NSObject?
    @NSManaged public var colorScheme: NSObject?
    @NSManaged public var learningObjective: LearningObjectiveMO?

}

extension LevelMO : Identifiable {

}
