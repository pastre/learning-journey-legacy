import Foundation

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())

        let localRepository =
         DefaultLearningRoadsLocalRepository()

        let interactors: DIContainer.Interactors = .init(
            learningRoadInteractor: DefaultLearningRoadInteractor(
                appStore: appState,
                localRepository: localRepository
            )
        )

        return .init(
            container: .init(
                appStore: appState,
                interactors: interactors
            )
        )
    }

    // This is ugly
    struct FlatLearningObjective: Codable {
        let cluster: String
        let code: String
        let enterpriseDelta: String
        let expert: String
        let intermediate: String
        let isBasic: Bool
        let isCore: Bool
        let learningObjective: String
        let novice: String
        let proficient: String
        let shared: String
        let topic: String
        let current: String?
        let goal: String?
        let roadName: String
    }

    private static func configureDefaultDataIfNeeded(_ facade: CoreDataFacade) {
        return
        let areDefaultLearningJourneysConfigured = facade.fetchLearningJourneys()?.isEmpty ?? true
        guard areDefaultLearningJourneysConfigured,
            let url = Bundle.main.url(
                forResource: "FlatLearningJourney",
                withExtension: ".json"
            ),
            let data = try? Data(
                contentsOf: url,
                options: .mappedIfSafe
            ),
            let fromJson = try? JSONDecoder().decode(
                [FlatLearningObjective].self,
                from: data
            )
        else { return }

        facade.addLearningJourney(journey: "oi")
        guard let journey = facade.fetchLearningJourneys()?.first
        else { return }

        Set(fromJson.map { $0.roadName }).forEach {
            facade.addLearningRoad(
                name: $0,
                journey: journey
            )
        }

        fromJson.forEach { objective in
            guard let road = facade.fetchLearningRoads(for: journey)?.filter { $0.name == objective.roadName }.first
            else { return }
            facade.addObjective(
                cluster: objective.cluster,
                code: objective.code,
                enterpriseDelta: objective.enterpriseDelta,
                expertDescription: objective.expert,
                intermediateDescription: objective.intermediate,
                isBasic: objective.isBasic, isCore: objective.isCore,
                learningObjective: objective.learningObjective,
                noviceDescription: objective.novice,
                proficientDescription: objective.proficient,
                shared: objective.shared,
                topic: objective.topic,
                current: objective.current,
                goal: objective.goal,
                learningRoad: road
            )
        }

//        var objectives: [LearningObjective] = []
//        roads.forEach { road in
//            let flatObjectives = fromJson.filter { road.name == $0.roadName }
//            flatObjectives.forEach { objective in
//                let newObjective = LearningObjective()
//                newObjective.cluster = objective.cluster
//                newObjective.code = objective.code
//                newObjective.enterpriseDelta = objective.enterpriseDelta
//                newObjective.expertDescription = objective.expert
//                newObjective.intermediateDescription = objective.intermediate
//                newObjective.isBasic = objective.isBasic
//                newObjective.isCore = objective.isCore
//                newObjective.learningObjective = objective.learningObjective
//                newObjective.noviceDescription = objective.novice
//                newObjective.proficientDescription = objective.proficient
//                newObjective.shared = objective.shared
//                newObjective.topic = objective.topic
//                newObjective.current = nil
//                newObjective.goal = nil
//                newObjective.learningRoad = road
//                objectives.append(newObjective)
//            }
//        }
//
//        facade.addLearningJourney(journey: journey)
//        roads.forEach { facade.addLearningRoad(road: $0) }
//        objectives.forEach { facade.addObjective(objective: $0) }
    }
}
