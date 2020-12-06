import SwiftUI
import Combine

struct LearningObjectView: View {
    
    // MARK: - Enviroment
    @Environment(\.injected) private var injected: DIContainer
    
    // MARK: - Dependencies
    let objective: LearningObjective
    @State private var details: Loadable<LearningObjective>
    
    // MARK: - View UI
    var body: some View {
        Group {
            content
        }
    }
    
    private var content: AnyView {
        switch details {
        case let .loaded(objective): return AnyView(loadedView(objective: objective))
        case let .failed(error): return AnyView(Text("Other state \(error.localizedDescription)"))
        case .isLoading(last: _, cancelBag: _): return AnyView(Text("Loading"))
        case .notRequested: return AnyView(notRequestedView)
        }
    }
    
    // MARK: - Load state UI
    private var notRequestedView: some View {
        Text("")
            .onAppear(perform: loadDetails)
    }
    
    private func loadedView(objective: LearningObjective) -> some View {
        Text(objective.name)
    }
    
    // MARK: - Initialization
    init(objective: LearningObjective, details: Loadable<LearningObjective> = .notRequested) {
        self.objective = objective
        self._details = .init(initialValue: details)
    }
    
    // MARK: - Helpers
    
    private func loadDetails() {
        
    }
}

