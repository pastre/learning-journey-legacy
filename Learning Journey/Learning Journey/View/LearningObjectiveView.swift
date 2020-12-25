import Combine
import SwiftUI

struct LearningObjectiveView: View {
    // MARK: - Enviroment

    @Environment(\.injected) private var injected: DIContainer

    // MARK: - Dependencies

    let objective: LearningObjective

    // MARK: - Initialization

    init(objective: LearningObjective) {
        self.objective = objective
    }
    
    
    // MARK: - UI Components

    var body: some View {
        AnyView(
            content
                .background(Color.white)
                .cornerRadius(24)
                .padding(24)
        )
        .navigationBarHidden(true)
    }

    private var content: some View {
        VStack {
            closeRow
                .padding(.bottom, 32)
            headerRow
                .padding(.bottom, 16)
            Group {
                ForEach(objective.levels, id: \.name) {
                    buildLevel(
                        levelName: $0.name,
                        levelDescription: $0.description,
                        goalColorScheme: .done
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
                if objective.details.isCore {
                    coreTag
                } else {
                    electiveTag
                }
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
    
    // MARK: - Gestures
    private func onGoalTap() {
        print("Goal")
    }
    
    private func onDoneTap() {
        print("Done")
    }

    private func navigateBack() {
        
    }
}
