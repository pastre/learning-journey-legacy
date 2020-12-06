import Combine

protocol LearningRoadsLocalRepository {
    func learningObjectives() -> AnyPublisher<LazyList<LearningRoad>, Error>
}

struct MockLearningRoadsLocalRepository: LearningRoadsLocalRepository {
    func learningObjectives() -> AnyPublisher<LazyList<LearningRoad>, Error> {
        CurrentValueSubject([
            LearningRoad(
                name: "Coding",
                learningObjectives: [
                    .init(
                        name: "Storyboard",
                        code: "CD01"
                    ),
                    .init(
                        name: "Storyboard",
                        code: "CD01"
                    ),
                    .init(
                        name: "Storyboard",
                        code: "CD01"
                    ),
                ]
            ),
            LearningRoad(
                name: "Design",
                learningObjectives: [
                    .init(
                        name: "UI",
                        code: "DE01"
                    ),
                    .init(
                        name: "UI",
                        code: "DE01"
                    ),
                    .init(
                        name: "UI",
                        code: "DE01"
                    ),
                ]
            ),
            LearningRoad(
                name: "Soft Skills",
                learningObjectives: [
                    .init(
                        name: "Storyboard",
                        code: "SS01"
                    ),
                    .init(
                        name: "Storyboard",
                        code: "CD01"
                    ),
                    .init(
                        name: "Storyboard",
                        code: "CD01"
                    ),
                ]
            ),
            
        ].lazyList)
            .eraseToAnyPublisher()
    }
}

