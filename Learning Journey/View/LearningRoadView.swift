import SwiftUI
import Combine

struct LearningRoadView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var routingState: Routing = .init()
    private var routeBinding: Binding<Routing> {
        $routingState.dispatched(
            to: injected.appStore,
            \.routing.learningRoadView
        )
    }
    
    @State private var objectives: Loadable<LazyList<LearningObjective>>
    let learningRoad: LearningRoad
    
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

private extension LearningRoadView {
    func loadedView(_ objectives: LazyList<LearningObjective>) -> some View {
        List(objectives, id: \.name) { objective in
            NavigationLink(
                destination: self.objectiveView(objective: objective),
                tag: objective.alpha3Code,
                selection: self.routeBinding.learningObjective
            ) {
                Text(objective.name)
            }
        }
    }
    
    func objectiveView(objective: LearningObjective) -> some View {
        LearningObjectiveView(objective: objective)
    }
    
}

extension LearningRoadView {
    struct Routing: Equatable {
        var learningObjective: LearningObjective.Code?
    }
}
