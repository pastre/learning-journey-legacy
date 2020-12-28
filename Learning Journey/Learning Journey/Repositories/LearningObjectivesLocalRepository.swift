import Combine
import CoreData

protocol LearningRoadsLocalRepository {
    func learningRoads() -> AnyPublisher<LazyList<LearningRoad>, Error>
    func learningObjectives(for road: LearningRoad) -> AnyPublisher<LazyList<LearningObjective>, Error>
    func updateObjective(_ newObjective: LearningObjective)
}

final class DefaultLearningRoadsLocalRepository: LearningRoadsLocalRepository {
    
    private var _learningRoads: [LearningRoad] = LearningJourney.dummy.roads.map { $0 }
    
    func learningRoads() -> AnyPublisher<LazyList<LearningRoad>, Error> {
        CurrentValueSubject(_learningRoads.lazyList)
            .eraseToAnyPublisher()
    }
    
    func learningObjectives(for road: LearningRoad) -> AnyPublisher<LazyList<LearningObjective>, Error> {
        CurrentValueSubject(road.objectives.lazyList)
            .eraseToAnyPublisher()
    }
    
    func updateObjective(_ newObjective: LearningObjective) {
        _learningRoads.removeAll(where: { $0.name == newObjective.learningRoad.name })
        var newRoad = newObjective.learningRoad
        newRoad.objectives.removeAll(where: { $0.details.code == newObjective.details.code })
        newRoad.objectives.append(newObjective)
        _learningRoads.append(newRoad)
    }
    
}

protocol LearningRoadsDBRepository {
    func hasLoadedJourney() -> AnyPublisher<Bool, Error>
    
    func store(
        journey: LearningJourney
    ) -> AnyPublisher<Void, Error>
    func journey(
        search: String, locale: Locale
    ) -> AnyPublisher<LearningJourney, Error>
    
    func store(
        learningRoads: [LearningRoad],
        for journey: LearningJourney
    ) -> AnyPublisher<Void, Error>
    func learningRoads(journey: LearningJourney) -> AnyPublisher<LazyList<LearningRoad>, Error>
    
    func store(learningObjectives: [LearningObjective])
    func learningObjectives(road: LearningRoad)

}

struct DefaultLearningRoadsDBRepository: LearningRoadsDBRepository {
    
    // MARK: - Dependencies
    
    let persistentStore: PersistentStore
    
    // MARK: - LearningRoadsDBRepository
    
    func hasLoadedJourney() -> AnyPublisher<Bool, Error> {
        persistentStore
            .count(LearningJourneyMO.justOne())
            .map { $0 > 0 }
            .eraseToAnyPublisher()
    }
    
    func store(journey: LearningJourney) -> AnyPublisher<Void, Error> {
        persistentStore.update { context in
            journey.store(in: context)
        }
    }
    
    func journey(
        search: String,
        locale: Locale
    ) -> AnyPublisher<LearningJourney, Error> {
        persistentStore
            .fetch(LearningJourneyMO.justOne()) {
            LearningJourney(managedObject: $0)
        }
        .compactMap { $0.first }
        .eraseToAnyPublisher()
    }
    
    func store(learningRoads: [LearningRoad], for journey: LearningJourney) -> AnyPublisher<Void, Error> {
        persistentStore
            .update { context in
                learningRoads.forEach {
                    $0.store(
                        in: context,
                        using: journey
                    )
                }
        }
    }
    
    func learningRoads(journey: LearningJourney) -> AnyPublisher<LazyList<LearningRoad>, Error> {
        fatalError("NYI")
    }
    
    func store(learningObjectives: [LearningObjective]) {
        fatalError("NYI")
    }
    
    func learningObjectives(road: LearningRoad) {
        fatalError("NYI")
    }
    
}

// MARK: - Query wrappers

extension LearningJourneyMO {
    static func justOne() -> NSFetchRequest<LearningJourneyMO> {
        let request = newFetchRequest()
        request.predicate = NSPredicate(format: "name == %@", "Apple Developer Academy")
        request.fetchLimit = 1
        return request
    }
}

// MARK: - Adapters
extension LearningJourneyMO: ManagedEntity {}
extension LearningRoadMO: ManagedEntity {}
extension LearningObjectiveMO: ManagedEntity {}
extension LevelMO: ManagedEntity {}

extension LearningJourney {
    init(managedObject: LearningJourneyMO) {
        name = managedObject.name
        roads = []
        roads = managedObject.roads
            .compactMap { $0 as? LearningRoadMO }
            .map { LearningRoad(
                managedObject: $0,
                learningJourney: self)
            }
    }
}

extension LearningRoad {
    init(
        managedObject: LearningRoadMO,
        learningJourney: LearningJourney
    ) {
        name = managedObject.name
        imageName = managedObject.imageName
        self.learningJourney = learningJourney
        self.objectives = []
        self.objectives = managedObject.objectives
            .compactMap { $0 as? LearningObjectiveMO }
            .map { LearningObjective(
                managedObject: $0,
                learningRoad: self
            )}
    }
}

extension LearningObjective {
    init(managedObject: LearningObjectiveMO, learningRoad: LearningRoad) {
        details = .init(
            code: managedObject.code,
            name: managedObject.name,
            isCore: managedObject.isCore,
            isBasic: managedObject.isBasic
        )
        self.learningRoad = learningRoad
        levels = managedObject.levels
            .compactMap { $0 as? LevelMO}
            .map { Level(
                name: $0.name,
                description: $0.levelDescription,
                colorScheme: .done
            )
        }
    }
}

extension LearningObjective.Level {
    
}

// MARK: - Transformers
extension LearningJourney {
    @discardableResult
    func store(in context: NSManagedObjectContext) -> LearningJourneyMO? {
        guard let newJourney = LearningJourneyMO.insertNew(in: context)
        else { return nil }
        newJourney.name = name
        newJourney.roads = NSSet(array: roads.compactMap { road in
            guard let newRoad = LearningRoadMO.insertNew(in: context)
            else { return nil }
            newRoad.name = road.name
            newRoad.imageName = road.name
            newRoad.learningJourney = newJourney
            newRoad.objectives = NSSet(array: road.objectives.compactMap { objective in
                guard let newObjective = LearningObjectiveMO.insertNew(in: context)
                else { return nil }
                
                newObjective.code = objective.details.code
                newObjective.name = objective.details.name
                newObjective.isCore = objective.details.isCore
                newObjective.isBasic = objective.details.isBasic
                newObjective.levels = NSSet(array: objective.levels.compactMap { level in
                    guard let newLevel = LevelMO.insertNew(in: context)
                    else { return nil }
                    newLevel.learningObjective = newObjective
                    newLevel.levelDescription = level.description
                    newLevel.name = level.name
                    newLevel.colorScheme = level.colorScheme.toString()
                    return newLevel
                })
                
                if let currentLevel = objective.currentLevel,
                   let mappedLevel = newObjective.levels
                    .compactMap({ $0 as? LevelMO })
                    .first(where: { $0.name == currentLevel.name })
                { newObjective.currentLevel = mappedLevel }
                
                if let currentGoal = objective.currentGoal,
                   let mappedLevel = newObjective.levels
                    .compactMap({ $0 as? LevelMO })
                    .first(where: { $0.name == currentGoal.name })
                { newObjective.currentGoal = mappedLevel }
                
                if let basicLevel = objective.basicLevel,
                   let mappedLevel = newObjective.levels
                    .compactMap({ $0 as? LevelMO })
                    .first(where: { $0.name == basicLevel.name })
                { newObjective.basicLevel = mappedLevel }
                return newObjective
            })
            return newRoad
        })
        return newJourney
    }
}

extension LearningRoad {
    
    @discardableResult
    func store(in context: NSManagedObjectContext, using journey: LearningJourney) -> LearningRoadMO? {
        // TODO finish thisg
        guard let newRoad = LearningRoadMO.insertNew(in: context)
        else { return nil }
        return nil
    }
}

extension PillColorScheme {
    
    func toString() -> String {
        switch self {
        case .done: return "done"
        case .disabled: return "disabled"
        case .novice: return "novice"
        case .intermediate: return "intermediate"
        case .proficient: return "proficient"
        case .expert: return "expert"
        default: return "unknown"
        }
    }
    
    init(from string: String) {
        switch string {
        case "done": self = .done
        case "disabled": self = .disabled
        case "novice": self = .novice
        case "intermediate": self = .intermediate
        case "proficient": self = .proficient
        case "expert": self = .expert
        default: self = .disabled
        }
    }
}
