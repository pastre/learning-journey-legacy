struct LearningJourney {
    let name: String
    var roads: [LearningRoad]
}

struct LearningRoad {
    let name: String
    let imageName: String
    let learningJourney: LearningJourney
    var objectives: [LearningObjective]
}

struct LearningObjective {
    let learningRoad: LearningRoad
    let details: Details
    let levels: [Level]
    var currentLevel: Level?
    var currentGoal: Level?
    var basicLevel: Level?
    
    struct Details {
        let code: String
        let name: String
        let isCore: Bool
        let isBasic: Bool
    }
    
    struct Level {
        let name: String
        let description: String
        let colorScheme: PillColorScheme
    }
}


extension LearningJourney: Equatable {}
extension LearningRoad: Equatable {}
extension LearningObjective: Equatable {}
extension LearningObjective.Level: Equatable {}
extension LearningObjective.Details: Equatable {}

#if DEBUG

extension LearningJourney {
    static var dummy: LearningJourney = {
        var journey: LearningJourney = .init(
            name: "Dummy Journey",
            roads: []
        )
        journey.roads.append(.dummy(journey))
        return journey
    }()
}

extension LearningRoad {
    static func dummy(_ journey: LearningJourney) -> LearningRoad {
        var road: LearningRoad = .init(
            name: "Coding",
            imageName: "swiftIcon",
            learningJourney: journey,
            objectives: []
        )
        road.objectives.append(.dummy(road))
        return road
    }
}

extension LearningObjective {
    static func dummy(_ road: LearningRoad) -> LearningObjective {
         .init(
            learningRoad: road,
            details: .init(
                code: "CD 00",
                name: "Design an App that targets multiple languages and culture providing a localized user experience.",
                isCore: false,
                isBasic: true
            ),
            levels: [
                .init(
                    name: "Novice",
                    description: "Understand the impact in terms of market opportunities of a localized App and the differences between App translation and localization.",
                    colorScheme: .novice
                ),
                .init(
                    name: "Intermediate",
                    description: "Understand Xcode base internalization functionalities and classes (NSLocalizableString, Locale) useful to localize an App.",
                    colorScheme: .intermediate
                ),
                .init(
                    name: "Proficient",
                    description: "Provide a localized user experience by taking advantage of the Locale class opportunities and the Localizable.strings file.",
                    colorScheme: .proficient
                ),
                .init(
                    name: "Expert",
                    description: "Understand .xliff file formats and determine best practices for exporting an App for translation.",
                    colorScheme: .expert
                ),
            ],
            currentLevel: nil,
            basicLevel: nil
        )
    }
}

#endif

