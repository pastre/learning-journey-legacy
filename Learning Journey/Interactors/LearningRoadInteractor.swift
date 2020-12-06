import SwiftUI
import Combine

protocol LearningRoadInteractor {
    func load(_ learningRoads: LoadableSubject<LazyList<LearningRoad>>)
}

struct DefaultLearningRoadInteractor: LearningRoadInteractor {
    let appStore: Store<AppState>
    let localRepository: LearningRoadsLocalRepository
    
    func load(_ learningRoads: LoadableSubject<LazyList<LearningRoad>>) {
        let cancelBag = CancelBag()
        learningRoads.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
            print("LOADINGGGG LOCAL")
        Just<Void>
            .withErrorType(Error.self)
            .flatMap {[localRepository] in
                localRepository.learningObjectives()
            }
            .sinkToLoadable { learningRoads.wrappedValue = $0 }
            .store(in: cancelBag)
    }
}

struct LearningRoadInteractorStub: LearningRoadInteractor {
    func load(_ learningRoads: LoadableSubject<LazyList<LearningRoad>>) {
        print("LOADINGGGG STUB")
    }
}
