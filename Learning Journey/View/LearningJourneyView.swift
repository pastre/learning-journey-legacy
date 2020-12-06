import SwiftUI
import Combine

struct LeariningJourneyView: View {
    
    // MARK: - Enviroment
    @Environment(\.injected) private var injected: DIContainer
    
    // MARK: - Routing state
    @State private var routingState: Routing = .init()
    private var routeBinding: Binding<Routing> {
        $routingState.dispatched(
            to: injected.appStore,
            \.routing.learningRoadsListView
        )
    }
    
    // MARK: - Dependencies
    @State private(set) var learningRoads: Loadable<LazyList<LearningRoad>>
    
    // MARK: - Initialization
    init(
        learningRoads: Loadable<LazyList<LearningRoad>> = .notRequested
    ) {
        self._learningRoads = .init(initialValue: learningRoads)
    }
    
    // MARK: - UI Components
    var body: some View {
        NavigationView {
            AnyView(
                content
            )
            .navigationBarTitle("🍎 👨‍💻 🏋️", displayMode: .large)
        }
    }
    
    private var content: AnyView {
        switch learningRoads {
        case let .loaded(learningRoads): return AnyView(loadedView(learningRoads))
        case let .failed(error): return AnyView(Text("Other state \(error.localizedDescription)"))
        case .isLoading(last: _, cancelBag: _): return AnyView(Text("Loading"))
        case .notRequested: return AnyView(notRequestedView)
        }
    }
    
    
    private var notRequestedView: some View {
        Text("not requested")
            .onAppear(perform: reloadLearningRoads)
    }
    
    private func loadedView(_ learningRoads: LazyList<LearningRoad>) -> some View {
        List(learningRoads, id: \.name) { road in
            NavigationLink (
                destination: self.roadView(road: road),
                tag: road.name,
                selection: self.routeBinding.learningRoad)
            {
                roadCell(road)
            }
        }
    }
    
    private func roadView(road: LearningRoad) -> some View {
        LearningRoadView(learningRoad: road)
    }
    
    private func roadCell(_ road: LearningRoad) -> some View {
        VStack {
            getIcon(for: road.name)
            Text(road.name)
        }
    }
    
    // MARK: - Helpers
    func reloadLearningRoads() {
        injected.interactors.learningRoadInteractor.load($learningRoads)
    }
    
    private func getIcon(for roadName: String) -> Image {
        switch roadName {
        case "Coding": return Image.swiftIcon
        case "Design": return Image.designIcon
        case "Success Skills": return Image.trophyIcon
        case "Process / CBL": return Image.cblIcon
        case "IT": return Image.serverIcon
        case "Personal Growth": return Image.caseIcon
        default: break
        }
        return Image(systemName: "faceids")
    }
}

extension LeariningJourneyView {
    struct Routing: Equatable{
        var learningRoad: LearningRoad.Code?
    }
}
