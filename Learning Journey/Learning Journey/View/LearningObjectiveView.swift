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
                .background(Color.white)
                .cornerRadius(10)
                .padding(24)
        )
        .navigationBarHidden(true)
    }

    private var content: some View {
        VStack {
            headerRow
                .padding(.bottom, 32)
            Group {
                buildLevel(
                    levelName: "Novice",
                    levelDescription: objective.noviceDescription,
                    goalColorScheme: .novice,
                    isGoal: true
                )
                    .padding(.bottom, 16)
                buildLevel(
                    levelName: "Intermediate",
                    levelDescription: objective.intermediateDescription,
                    goalColorScheme: .intermediate,
                    isGoal: true
                )
                    .padding(.bottom, 16)
                buildLevel(
                    levelName: "Proficient",
                    levelDescription: objective.proficientDescription,
                    goalColorScheme: .proficient,
                    isGoal: true
                )
                    .padding(.bottom, 16)
                buildLevel(
                    levelName: "Expert",
                    levelDescription: objective.expertDescription,
                    goalColorScheme: .expert,
                    isGoal: true
                )
            }
        }
        .padding(.init(
                    top: 32,
                    leading: 16,
                    bottom: 32,
                    trailing: 16
        ))
    }

    // MARK: - Initialization

    init(objective: LearningObjective) {
        self.objective = objective
    }
    
    // MARK: - UI Components
    
    private var headerRow: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(objective.code)
                    .foregroundColor(.gray)
                    .bold()
                    .font(.system(size: 10, weight: .bold))
                Spacer()
                TextPill.basicKnowledge
            }
            HStack {
                Text(objective.learningObjective)
                    .bold()
                    .font(.system(size: 20))
                Spacer()
            }
        }
    }
    
    private func buildLevel(
        levelName: String,
        levelDescription: String,
        goalColorScheme: PillColorScheme,
        isGoal: Bool = false,
        isDone: Bool = false
    ) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(levelName)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(
                        isGoal ? goalColorScheme.color
                            : isDone ? Color.LearningJourney.green
                            : Color.LearningJourney.darkGray
                    )
                Spacer()
                TextPill(
                    title: "Goal",
                    colorScheme: isGoal ? goalColorScheme : .disabled
                )
                TextPill(
                    title: "Done",
                    colorScheme: isDone ? .done : .disabled
                )
                
            }
            Text(levelDescription)
                .foregroundColor(.black)
        }
    }
    
    private func onGoalTap() {
        print("Goal")
    }
    
    private func onDoneTap() {
        print("Done")
    }

    // MARK: - Helpers
    
    private func loadDetails() {}
}
