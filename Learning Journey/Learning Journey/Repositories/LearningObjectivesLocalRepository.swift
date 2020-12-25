import Combine
import Foundation

protocol LearningRoadsLocalRepository {
    func learningRoads() -> AnyPublisher<LazyList<LearningRoad>, Error>
    func learningObjectives(for road: LearningRoad) -> AnyPublisher<LazyList<LearningObjective>, Error>
}

final class DefaultLearningRoadsLocalRepository: LearningRoadsLocalRepository {
    
    func learningRoads() -> AnyPublisher<LazyList<LearningRoad>, Error> {
        let list = LearningJourney.dummy.roads.lazyList
        return CurrentValueSubject(list)
            .eraseToAnyPublisher()
    }
    
    func learningObjectives(for road: LearningRoad) -> AnyPublisher<LazyList<LearningObjective>, Error> {
        return CurrentValueSubject(road.objectives.lazyList)
            .eraseToAnyPublisher()
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
}

enum A: Error {
    case a
}
