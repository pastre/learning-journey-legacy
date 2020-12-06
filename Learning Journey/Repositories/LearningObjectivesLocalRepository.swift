import Combine

protocol LearningRoadsLocalRepository {
    func learningJourneys() -> AnyPublisher<LazyList<LearningRoad>, Error>
}

struct MockLearningRoadsLocalRepository: LearningRoadsLocalRepository {
    func learningJourneys() -> AnyPublisher<LazyList<LearningRoad>, Error> {
        CurrentValueSubject([
            LearningRoad(
                name: "Coding",
                learningObjectives: [
                    .init(
                        name: "Storyboard1",
                        code: "CD01",
                        alpha3Code: "a"
                    ),
                    .init(
                        name: "Storyboard2",
                        code: "CD02",
                        alpha3Code: "s"
                    ),
                    .init(
                        name: "Storyboard3",
                        code: "CD03",
                        alpha3Code: "d"
                    ),
                ],
                alpha3Code: "Coding"
            ),
            LearningRoad(
                name: "Design",
                learningObjectives: [
                    .init(
                        name: "UI1",
                        code: "DE01",
                        alpha3Code: "q"
                    ),
                    .init(
                        name: "UI2",
                        code: "DE02",
                        alpha3Code: "w"
                    ),
                    .init(
                        name: "UI3",
                        code: "DE03",
                        alpha3Code: "e"
                    ),
                ],
                alpha3Code: "Design"
            ),
            LearningRoad(
                name: "Soft Skills",
                learningObjectives: [
                    .init(
                        name: "Storyboard",
                        code: "SS01",
                        alpha3Code: "1"
                    ),
                    .init(
                        name: "Storyboard",
                        code: "SS02",
                        alpha3Code: "2"
                    ),
                    .init(
                        name: "Storyboard",
                        code: "SS03",
                        alpha3Code: "3"
                    ),
                ],
                alpha3Code: "Soft Skills"
            ),
        ].lazyList)
        .eraseToAnyPublisher()
    }
}

