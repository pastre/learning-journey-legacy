struct AppState {
    var userData = UserData()
    var routing = ViewRouting()
    var system = System()
    var permissions = Permissions()
}

extension AppState {
    struct UserData: Equatable {
        var learningObjectiveDidChange: LearningObjective?
        
        init(learningObjectiveDidChange: LearningObjective? = nil) {
            self.learningObjectiveDidChange = learningObjectiveDidChange
        }
    }
}

extension AppState {
    struct ViewRouting: Equatable {
        var learningRoadsListView = LeariningJourneyView.Routing()
        var learningRoadView = LearningRoadView.Routing()
        var learningObjectiveView = LearningObjectiveView.Routing()
    }
}

extension AppState {
    struct System: Equatable { /* TODO: */ }
}

extension AppState {
    struct Permissions: Equatable { /* TODO: */ }
}

#if DEBUG
extension AppState {
    static let preview = AppState()
}
#endif
