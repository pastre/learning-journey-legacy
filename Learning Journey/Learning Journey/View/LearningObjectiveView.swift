import Combine
import SwiftUI

struct LearningObjectiveView: View {
    // MARK: - Enviroment

    @Environment(\.injected) private var injected: DIContainer

    // MARK: - Dependencies

    let objective: LearningObjective

    // MARK: - View UI

    var body: some View {
        AnyView(
            content
        )
        .navigationTitle(objective.learningObjective)
    }

    private var content: some View {
        Text(objective.code)
    }

    // MARK: - Initialization

    init(objective: LearningObjective) {
        self.objective = objective
    }

    // MARK: - Helpers

    private func loadDetails() {}
}
