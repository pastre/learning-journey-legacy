struct LearningRoad: Codable, Equatable {
    let name: String
    let learningObjectives: [LearningObjective]
    let alpha3Code: Code
    
    typealias Code = String
}

struct LearningObjective: Codable, Equatable {
    let name: String
    let code: String
    let alpha3Code: Code
    
    typealias Code = String
}


