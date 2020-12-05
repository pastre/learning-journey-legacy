struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let interactors: DIContainer.Interactors = .init(
            learningRoadInteractor: DefaultLearningRoadInteractor(appStore: appState)
        )
        
        return .init(
            container: .init(
                appStore: appState,
                interactors: interactors
            )
        )
    }
}
