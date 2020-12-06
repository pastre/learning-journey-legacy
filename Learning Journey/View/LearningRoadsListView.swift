import SwiftUI
import Combine

struct LeariningRoadsListView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private(set) var learningRoads: Loadable<LazyList<LearningRoad>>
    
    var body: some View {
        content
    }
    
    init(
        learningRoads: Loadable<LazyList<LearningRoad>> = .notRequested
    ) {
        self._learningRoads = .init(initialValue: learningRoads)
    }
    
    var content: AnyView {
        switch learningRoads {
        case let .loaded(learningRoads): return AnyView(loadedView(learningRoads))
        case let .failed(error): return AnyView(Text("Other state \(error.localizedDescription)"))
        case .isLoading(last: _, cancelBag: _): return AnyView(Text("Loading"))
        case .notRequested: return AnyView(notRequestedView)
        }
    }
    
}

private extension LeariningRoadsListView {
    
    var notRequestedView: some View {
        Text("not requested")
            .onAppear(perform: reloadLearningRoads)
    }
    
    func reloadLearningRoads() {
        injected.interactors.learningRoadInteractor.load($learningRoads)
    }
    
}

private extension LeariningRoadsListView {
    func loadedView(_ learningRoads: LazyList<LearningRoad>) -> some View {
        List(learningRoads, id: \.name) { road in
            Text(road.name)
        }
    }
}
