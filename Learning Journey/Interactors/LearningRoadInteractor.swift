import SwiftUI
import Combine

protocol LearningRoadInteractor {
    func load(_ learningRoads: LoadableSubject<LazyList<LearningRoad>>)
    func load(objectives: LoadableSubject<LazyList<LearningObjective>>, road: LearningRoad)
}

struct DefaultLearningRoadInteractor: LearningRoadInteractor {
    let appStore: Store<AppState>
    let localRepository: LearningRoadsLocalRepository
    
    func load(_ learningRoads: LoadableSubject<LazyList<LearningRoad>>) {
        let cancelBag = CancelBag()
        learningRoads.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        Just<Void>
            .withErrorType(Error.self)
            .flatMap {[localRepository] in
                localRepository.learningRoads()
            }
            .sinkToLoadable { learningRoads.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
    func load(objectives: LoadableSubject<LazyList<LearningObjective>>, road: LearningRoad) {
        
        let cancelBag = CancelBag()
        objectives.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        Just<Void>
            .withErrorType(Error.self)
            .flatMap { [localRepository] in
                localRepository.learningObjectives(for: road)
            }
            .sinkToLoadable { objectives.wrappedValue = $0 }
            .store(in: cancelBag)
    }
    
}

struct LearningRoadInteractorStub: LearningRoadInteractor {
    func load(objectives: LoadableSubject<LazyList<LearningObjective>>, road: LearningRoad) {
        // TODO
    }
    
    
    func load(_ learningRoads: LoadableSubject<LazyList<LearningRoad>>) {
        print("LOADINGGGG STUB")
    }
}
