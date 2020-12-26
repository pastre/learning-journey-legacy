import SwiftUI
import Combine

protocol LearningObjectiveInteractor {
    func onGoalTapped(_ objective: LearningObjective, level: LearningObjective.Level)
    func onDoneTapped(_ objective: LearningObjective, level: LearningObjective.Level)
}

struct DefaultLearningObjectiveInteractor: LearningObjectiveInteractor {
    let appStore: Store<AppState>
    let localRepository: LearningRoadsLocalRepository
    
    // TODO Review this when changing local repository
    func onGoalTapped(_ objective: LearningObjective, level: LearningObjective.Level) {
        var updatedObjective = objective
        updatedObjective.currentGoal = level == objective.currentGoal ? nil : level
        localRepository.updateObjective(updatedObjective)
        appStore[\.userData.learningObjectiveDidChange] = updatedObjective
    }
    
    // TODO Review this when changing local repository
    func onDoneTapped(_ objective: LearningObjective, level: LearningObjective.Level) {
        var updatedObjective = objective
        updatedObjective.currentLevel = level == objective.currentLevel ? nil : level
        localRepository.updateObjective(updatedObjective)
        appStore[\.userData.learningObjectiveDidChange] = updatedObjective
    }
}

struct LearningObjectiveInteractorStub: LearningObjectiveInteractor {
    func onGoalTapped(_ objective: LearningObjective, level: LearningObjective.Level) {}
    
    func onDoneTapped(_ objective: LearningObjective, level: LearningObjective.Level) {}
}
