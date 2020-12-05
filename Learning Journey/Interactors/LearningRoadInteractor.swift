protocol LearningRoadInteractor {
    func load()
}

struct DefaultLearningRoadInteractor: LearningRoadInteractor {
    let appStore: Store<AppState>
    func load() {
        // TODO
    }
}

struct LearningRoadInteractorStub: LearningRoadInteractor {
    func load() {
        // TODO
    }
}
