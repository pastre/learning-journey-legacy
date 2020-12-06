import SwiftUI
import Combine

struct LearningRoadView: View {
    let learningRoad: LearningRoad
    @State private var objectives: Loadable<LazyList<LearningObjective>>
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var routingState: Routing = .init()
    private var routeBinding: Binding<Routing> {
        $routingState.dispatched(
            to: injected.appStore,
            \.routing.learningRoadView
        )
    }
    
    var body: some View {
        AnyView(
            content
        )
        .navigationTitle(learningRoad.name)
    }
    
    var content: AnyView {
        switch objectives {
        case let .loaded(objectives): return AnyView(loadedView(objectives))
        case let .failed(error): return AnyView(Text("Other state \(error.localizedDescription)"))
        case .isLoading(last: _, cancelBag: _): return AnyView(Text("Loading"))
        case .notRequested: return AnyView(notRequestedView)
        }
    }
    
    init(learningRoad: LearningRoad, objectives: Loadable<LazyList<LearningObjective>> = .notRequested) {
        self.learningRoad = learningRoad
        self._objectives = .init(initialValue: objectives)
    }
    
    private func objectiveView(objective: LearningObjective) -> some View {
        Text(objective.name)
    }
    
}

extension LearningRoadView {
    var notRequestedView: some View {
        Text("VAZIO")
            .onAppear(perform: loadRoadObjectives)
    }
    
    func loadRoadObjectives() {
        injected.interactors.learningRoadInteractor.load(objectives: $objectives, road: learningRoad)
    }
}

extension LearningRoadView {
    func loadedView(_ objectives: LazyList<LearningObjective>) -> some View {
        List(objectives, id: \.code) { objective in
            Text(objective.name)
        }
    }
    
}

extension LearningRoadView {
    struct Routing: Equatable {
        var learningObjective: LearningObjective?
    }
}
