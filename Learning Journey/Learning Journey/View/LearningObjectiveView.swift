import Combine
import SwiftUI

struct LearningObjectiveView: View {
    // MARK: - Enviroment

    @Environment(\.injected) private var injected: DIContainer

    // MARK: - Routing
    @Binding var isDisplayed: Bool
    
    @State private var isDirty: Bool = false
    
    // MARK: - Dependencies

    @State var objective: LearningObjective
    
    // MARK: - UI Components

    var body: some View {
        AnyView(
            content
                .background(Color.white)
                .cornerRadius(24)
                .padding([.horizontal, .bottom], 24)
        )
        .navigationBarHidden(true)
        .onReceive(dataUpdate) {
            guard let newObjective = $0.learningObjectiveDidChange
            else { return }
            objective = newObjective
            isDirty.toggle()
        }
    }

    private var content: some View {
        VStack {
//            closeRow
//                .padding(.bottom, 32)
            headerRow
                .padding(.bottom, 16)
            Group {
                ForEach(objective.levels, id: \.name) {
                    buildLevel(
                        level: $0,
                        isGoal: $0 == objective.currentGoal,
                        isDone: $0 == objective.currentLevel
                    ).padding(.top, 16)
                }
            }
        }
        .padding(.init(
                    top: 32,
                    leading: 16,
                    bottom: 32,
                    trailing: 16
        ))
    }

    
    private var closeRow: some View {
        HStack(alignment: .center) {
            Text(objective.learningRoad.name)
                .font(.system(
                        size: 14,
                        weight: .bold
                ))
            Spacer()
            Button {
                navigateBack()
            } label: {
                Image.closeIcon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24, alignment: .center)
            }

        }
    }
    
    private var headerRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(objective.details.code)
                    .foregroundColor(.gray)
                    .bold()
                    .font(.system(size: 10, weight: .bold))
                Spacer()
                
                if objective.details.isCore { coreTag }
                else { electiveTag }
                
                if objective.details.isBasic {
                    basicTag
                }
            }
            HStack {
                Text(objective.details.name)
                    .bold()
                    .font(.system(size: 20))
                Spacer()
            }
        }
    }
    
    private var coreTag: some View {
            Text("Core")
                .foregroundColor(Color.LearningJourney.Green.dark)
                .font(.system(size: 10, weight: .bold))
    }
    
    
    private var electiveTag: some View {
            Text("Elective")
                .foregroundColor(Color.LearningJourney.Orange.dark)
                .font(.system(size: 10, weight: .bold))
    }
    
    private var basicTag: some View {
            Text("Basic knowledge")
                .foregroundColor(Color.LearningJourney.Purple.dark)
                .font(.system(size: 10, weight: .bold))
    }
    
    // MARK: -  UI Helpers
    private func buildLevel(
        level: LearningObjective.Level,
        isGoal: Bool = false,
        isDone: Bool = false
    ) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(level.name)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(
                        isGoal ? level.colorScheme.color
                            : isDone ? Color.LearningJourney.Green.dark
                            : Color.LearningJourney.darkGray
                    )
                if isDone { Image.checkmarkIcon }
                Spacer()
                TextPill(
                    title: "Goal",
                    colorScheme: isGoal ? level.colorScheme : .disabled
                ).onTapGesture {
                    onGoalTap(level)
                }
                TextPill(
                    title: "Done",
                    colorScheme: isDone ? .done : .disabled
                ).onTapGesture {
                    onDoneTap(level)
                }
                
            }
            Text(level.description)
                .foregroundColor(.black)
        }
    }
    
    // MARK: - Gestures
    private func onGoalTap(_ level: LearningObjective.Level) {
        print("Goal")
        injected
            .interactors
            .learningObjectiveInteractor
            .onGoalTapped(objective, level: level)
    }
    
    private func onDoneTap(_ level: LearningObjective.Level) {
        print("Done")
        injected
            .interactors
            .learningObjectiveInteractor
            .onDoneTapped(objective, level: level)
    }

    private func navigateBack() {
        isDisplayed = false
    }
}
extension LearningObjectiveView {
    struct Routing: Equatable {
        var objectiveSheet: Bool = false
    }
    
    struct DataUpdating: Equatable {
        var newData: String
    }
}

private extension LearningObjectiveView {
    var routingUpdate: AnyPublisher<Routing, Never> {
        injected
            .appStore
            .updates(
                for: \.routing.learningObjectiveView
            )
    }
    
    var dataUpdate: AnyPublisher<AppState.UserData, Never> {
        injected.appStore.updates(
            for: \.userData
        )
    }
}
