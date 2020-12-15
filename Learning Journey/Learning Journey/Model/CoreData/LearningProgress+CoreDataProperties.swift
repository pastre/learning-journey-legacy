//
//  LearningProgress+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import Foundation
import CoreData


extension LearningProgress {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LearningProgress> {
        return NSFetchRequest<LearningProgress>(entityName: "LearningProgress")
    }

    @NSManaged public var expert: String?
    @NSManaged public var intermediate: String?
    @NSManaged public var novice: String?
    @NSManaged public var proficient: String?

}

extension LearningProgress : Identifiable {

}
