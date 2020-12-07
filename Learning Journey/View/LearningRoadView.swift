import SwiftUI
import Combine

struct LearningRoadView: View {
    
    // MARK: - Enviroment
    @Environment(\.injected) private var injected: DIContainer
    
    // MARK: - Routing state
    @State private var routingState: Routing = .init()
    private var routeBinding: Binding<Routing> {
        $routingState.dispatched(
            to: injected.appStore,
            \.routing.learningRoadView
        )
    }
    
    // MARK: - Dependencies
    @State private var objectives: Loadable<LazyList<LearningObjective>>
    let learningRoad: LearningRoad
    
    // MARK: - UI Components
    var body: some View {
        AnyView(
            content
        )
        .navigationTitle(learningRoad.name)
        .background(Color.ljGray)
    }
    
    private var content: AnyView {
        switch objectives {
        case let .loaded(objectives): return AnyView(loadedView(objectives))
        case let .failed(error): return AnyView(Text("Other state \(error.localizedDescription)"))
        case .isLoading(last: _, cancelBag: _): return AnyView(Text("Loading"))
        case .notRequested: return AnyView(notRequestedView)
        }
    }
    
    // MARK: - Initialization
    init(learningRoad: LearningRoad, objectives: Loadable<LazyList<LearningObjective>> = .notRequested) {
        self.learningRoad = learningRoad
        self._objectives = .init(initialValue: objectives)
    }
    
    // MARK: - UI state components
    private var notRequestedView: some View {
        Text("VAZIO")
            .onAppear(perform: loadRoadObjectives)
    }
    
    
    private func loadedView(_ objectives: LazyList<LearningObjective>) -> some View {
        ScrollView {
            LazyVGrid(
                columns: [GridItem].init(repeating: .init(.flexible()), count: 1),
                alignment: .center,
                content: {
                ForEach(objectives, id: \.code) { objective in
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.white)
                        VStack {
                            HStack {
                                Text(objective.code)
                                    .foregroundColor(Color.black)
                            }
                            Text(objective.learningObjective)
                                .foregroundColor(Color.black)
                            HStack {
                                Text("Your level")
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                }
                .padding(EdgeInsets.init(top: 8, leading: 24, bottom: 8, trailing: 24))
            })
        }
        
    }
    
    private func objectiveView1(objective: LearningObjective) -> some View {
        LearningObjectiveView(objective: objective)
    }
    
    // MARK: - Helpers
    private func loadRoadObjectives() {
        injected.interactors.learningRoadInteractor.load(objectives: $objectives, road: learningRoad)
    }
    
}

extension LearningRoadView {
    struct Routing: Equatable {
        var learningObjective: LearningObjective.Code?
    }
}


#if DEBUG

struct LearningRoadView_Previews: PreviewProvider {
    static var previews: some View {
        LearningRoadView(learningRoad: .init(name: "Fake", learningObjectives: [
            .random,
            .random,
            .random,
            .random,
            ]),
            objectives: .loaded([
                .random,
                .random,
                .random,
                .random,
            ].lazyList
            )
        )
    }
}
#endif
