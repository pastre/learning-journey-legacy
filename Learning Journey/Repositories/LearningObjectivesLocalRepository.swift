import Combine
import Foundation

protocol LearningRoadsLocalRepository {
    func learningRoads() -> AnyPublisher<LazyList<LearningRoad>, Error>
}

struct MockLearningRoadsLocalRepository: LearningRoadsLocalRepository {
    func learningRoads() -> AnyPublisher<LazyList<LearningRoad>, Error> {
        
        let roads = loadJourneysFromLocalJSON() ?? []
        
        return CurrentValueSubject(
            roads.lazyList
        )
        .eraseToAnyPublisher()
    }
    
    enum Errors: Error {
        case notLoaded
    }
    
    private func loadJourneysFromLocalJSON() -> [LearningRoad]? {
        guard let path = Bundle.main.path(forResource: "", ofType: "json")
        else { return nil }
        
        do {
          let data = try Data(
            contentsOf: URL(fileURLWithPath: path),
            options: .mappedIfSafe
          )
            let transformed = try JSONDecoder().decode(Welcome.self, from: data)
            return transformed.learningJourneys.first?.learningRoads
        } catch let error {
            print("ERROR WHEN PARSING JSON", error)
        }
        
        
        return nil
    }
}

