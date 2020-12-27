import Combine
import Foundation

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

struct CoreDataLearningRoadsLocalRepository: LearningRoadsLocalRepository {
    private let databaseFacade: CoreDataFacade

    init(databaseFacade: CoreDataFacade) {
        self.databaseFacade = databaseFacade
    }

    func learningRoads() -> AnyPublisher<LazyList<LearningRoad>, Error> {
        guard let journey = databaseFacade.fetchLearningJourneys()?.first
        else { return CurrentValueSubject(.empty).eraseToAnyPublisher() }
        guard let roads = databaseFacade.fetchLearningRoads(for: journey)
        else { return CurrentValueSubject(.empty).eraseToAnyPublisher() }

        return CurrentValueSubject(roads.lazyList)
            .eraseToAnyPublisher()
    }

    func learningObjectives(for road: LearningRoad) -> AnyPublisher<LazyList<LearningObjective>, Error> {
        let objectives = databaseFacade.fetchLearningObjectives(for: road)?.lazyList ?? .empty
        return CurrentValueSubject(objectives)
            .eraseToAnyPublisher()
    }
    func updateObjective(_ newObjective: LearningObjective){}
}

enum A: Error {
    case a
}
