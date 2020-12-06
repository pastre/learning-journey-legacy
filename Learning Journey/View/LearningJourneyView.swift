import SwiftUI
import Combine

struct LeariningJourneyView: View {
    
    @Environment(\.injected) private var injected: DIContainer
    
    @State private var routingState: Routing = .init()
    private var routeBinding: Binding<Routing> {
        $routingState.dispatched(
            to: injected.appStore,
            \.routing.learningRoadsListView
        )
    }
    
    @State private(set) var learningRoads: Loadable<LazyList<LearningRoad>>
    
    var body: some View {
        NavigationView {
            AnyView(
                content
            )
            .navigationBarTitle("🍎 👨‍💻 🏋️", displayMode: .large)
        }
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

private extension LeariningJourneyView {
    
    var notRequestedView: some View {
        Text("not requested")
            .onAppear(perform: reloadLearningRoads)
    }
    
    func reloadLearningRoads() {
        injected.interactors.learningRoadInteractor.load($learningRoads)
    }
    
}

private extension LeariningJourneyView {
    func loadedView(_ learningRoads: LazyList<LearningRoad>) -> some View {
        List(learningRoads, id: \.name) { road in
            NavigationLink (
                destination: self.roadView(road: road),
                tag: road.name,
                selection: self.routeBinding.learningRoad)
            {
                Text(road.name)
            }
        }
    }
    
    func roadView(road: LearningRoad) -> some View {
        LearningRoadView(learningRoad: road)
    }
}


extension LeariningJourneyView {
    struct Routing: Equatable{
        var learningRoad: LearningRoad.Code?
    }
}
