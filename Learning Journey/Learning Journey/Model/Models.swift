//// This file was generated from JSON Schema using quicktype, do not modify it directly.
//// To parse the JSON, add this file to your project and do:
////
////   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)
//
//import Foundation
//
//// MARK: - Welcome
//struct Welcome: Codable {
//    let learningJourneys: [LearningJourney]
//    
//    enum CodingKeys: String, CodingKey {
//        case learningJourneys = "learning_journeys"
//    }
//}
//
//// MARK: - LearningJourney
//struct LearningJourney: Codable {
//    let name: String
//    let learningRoads: [LearningRoad]
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case learningRoads = "learning_roads"
//    }
//}
//
//// MARK: - LearningRoad
//struct LearningRoad: Codable {
//    let name: String
//    let learningObjectives: [LearningObjective]
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case learningObjectives = "learning_objectives"
//    }
//    
//    typealias Code = String
//}
//
//// MARK: - LearningObjective
//struct LearningObjective: Codable {
//    let code, learningObjective, topic, subjectArea: String
//    let coreElective, enterpriseDelta, cluster, shared: String
//    let novice, intermediate, proficient, expert: String
//
//    enum CodingKeys: String, CodingKey {
//        case code
//        case learningObjective = "learning_objective"
//        case topic
//        case subjectArea = "subject_area"
//        case coreElective = "core/elective"
//        case enterpriseDelta = "enterprise_delta"
//        case cluster, shared, novice, intermediate, proficient, expert
//    }
//    
//    typealias Code = String
//}
//
//// MARK: - Learning Progress
//enum ProgressLevel: String, Codable {
//    case novice
//    case intermediate
//    case proficient
//    case expert
//}
//struct LearningProgress: Codable {
//    let learningObjectiveCode: String
//    let progress: ProgressLevel
//}
//
//struct FlatLearningObjective {
//    let code: String
//    let topic: String
//    let cluster: String
//    let shared: String
//    let novice: String
//    let intermediate: String
//    let proficient: String
//    let expert: String
//    let roadName: String
//    let enterpriseDelta: String
//    let learningObjective: String
//    
//    let isCore: Bool
//    let isBasic: Bool
//    
//    let current: ProgressLevel?
//    let goal: ProgressLevel?
//}
//
//#if DEBUG
//
//extension LearningObjective {
//    static let random = LearningObjective (
//        code: .random(),
//        learningObjective: .random(),
//        topic: .random(),
//        subjectArea: .random(),
//        coreElective: .random(),
//        enterpriseDelta: .random(),
//        cluster: .random(),
//        shared: .random(),
//        novice: .random(),
//        intermediate: .random(),
//        proficient: .random(),
//        expert: .random()
//    )
//}
//
//#endif
//
//
//extension LearningObjective: Codable {}
//
//extension LearningRoad: Codable {}
//
//extension LearningProgress: Codable {}
//
//extension LearningJourney: Codable {}
//