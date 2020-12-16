//
//  LearningProgress+CoreDataProperties.swift
//  Learning Journey
//
//  Created by Bruno Pastre on 08/12/20.
//
//

import CoreData
import Foundation

public extension LearningProgress {
    @nonobjc class func fetchRequest() -> NSFetchRequest<LearningProgress> {
        return NSFetchRequest<LearningProgress>(entityName: "LearningProgress")
    }

    @NSManaged var expert: String?
    @NSManaged var intermediate: String?
    @NSManaged var novice: String?
    @NSManaged var proficient: String?
}

extension LearningProgress: Identifiable {}
