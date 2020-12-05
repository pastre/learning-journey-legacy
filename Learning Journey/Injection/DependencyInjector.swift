import SwiftUI
import Combine

typealias Store<State> = CurrentValueSubject<State, Never>

struct DIContainer: EnvironmentKey {
    // MARK: - Dependencies
    let appStore: Store<AppState>
    let interactors: Interactors
    
    // MARK: - Initialization
    init(appStore: Store<AppState>, interactors: Interactors) {
        self.appStore = appStore
        self.interactors = interactors
    }
    
    init(appState: AppState, interactors: Interactors) {
        self.init(appStore: Store<AppState>(appState), interactors: interactors)
    }
    
    // MARK: - Singleton
    static var defaultValue: Self { Self.default }
    private static let `default` = Self(appState: AppState(), interactors: .stub)
    
}

extension EnvironmentValues {
    // MARK: - SwiftUI injection
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}

extension DIContainer {
    // MARK: - Interactors
    struct Interactors {
        let learningRoadInteractor: LearningRoadInteractor
        static let stub: Interactors = .init(
            learningRoadInteractor: LearningRoadInteractorStub()
        )
    }
    
}

extension View {
    func inject(
        _ appState: AppState,
        _ interactors: DIContainer.Interactors
    ) -> some View {
        let container = DIContainer(
            appStore: .init(appState),
            interactors: interactors
        )
        return inject(container)
    }
    
    func inject(_ container: DIContainer) -> some View {
        self.modifier(LJViewAppearance())
            .environment(\.injected, container)
    }
}

struct LJViewAppearance: ViewModifier {
    @Environment(\.injected) private var injected: DIContainer
    
    func body(content: Content) -> some View {
        contentgi
    }
}

#if DEBUG
extension DIContainer {
    static let preview = DIContainer(
        appStore: .init(AppState.preview),
        interactors: .stub
    )
}
#endif
