import Combine
import SwiftUI

struct LearningRoadView: View {
    // MARK: - Enviroment

    @Environment(\.injected) private var injected: DIContainer

    // MARK: - Routing state

    @State private var routingState: Routing = .init()
    private var routeBinding: Binding<Routing> {
        $routingState.dispatched(
            to: injected.appStore,
            \.routing.learningRoadView
        )
    }

    // MARK: - Details presentation
    // @TODO Reconsider if routing is necessary
    @State private var isPresentingObjective: Bool = false
    @State private var selectedObjective: LearningObjective?
    
    // MARK: - Dependencies

    @State private var objectives: Loadable<LazyList<LearningObjective>>
    let learningRoad: LearningRoad

    // MARK: - UI Components

    var body: some View {
        AnyView(
            content
        )
        .navigationTitle(learningRoad.name)
        .background(Color.LearningJourney.gray)
    }

    private var content: AnyView {
        switch objectives {
        case let .loaded(objectives): return AnyView(loadedView(objectives))
        case let .failed(error): return AnyView(Text("Other state \(error.localizedDescription)"))
        case .isLoading(last: _, cancelBag: _): return AnyView(Text("Loading"))
        case .notRequested: return AnyView(notRequestedView)
        }
    }

    // MARK: - Initialization

    init(learningRoad: LearningRoad, objectives: Loadable<LazyList<LearningObjective>> = .notRequested) {
        self.learningRoad = learningRoad
        _objectives = .init(initialValue: objectives)
    }

    // MARK: - UI state components

    private var notRequestedView: some View {
        Text("VAZIO")
            .onAppear(perform: loadRoadObjectives)
    }

    private func loadedView(_ objectives: LazyList<LearningObjective>) -> some View {
        ZStack {
            GeometryReader { geometry in
                ScrollView {
                    LazyVGrid(
                        columns: [GridItem].init(repeating: .init(.flexible()), count: 1),
                        alignment: .center,
                        content: {
                            ForEach(objectives, id: \.details.code) { objective in
                                objectiveCell(objective, geometry.size)
                            }
                        }
                    )
                }
            }
            if isPresentingObjective {
                blackOverlayView
                objectiveView
            }
        }
    }

    // MARK: - UI Components
    private func objectiveCell(_ objective: LearningObjective, _ size: CGSize) -> some View {
        Group {
            VStack {
                Group {
                    HStack {
                        Text(objective.details.code)
                            .bold()
                            .font(.system(
                                size: 14,
                                weight: .heavy
                            ))
                            .foregroundColor(Color.LearningJourney.darkGray)
                        Spacer()
                        self.coreElectiveTag(objective: objective)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                    .frame(maxWidth: .infinity)

                    Text(objective.details.name)
                        .bold()
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(0.5)

                    HStack {
                        VStack(alignment: .leading) {
                            Text("Current level")
                                .bold()
                                .foregroundColor(Color.LearningJourney.darkGray)
                                .font(.system(size: 12))
                            Button("Set your level") {
                                presentObjectiveView(objective)
                            }
                        }

                        Spacer()

                        VStack(alignment: .trailing) {
                            Text("Goal")
                                .bold()
                                .foregroundColor(Color.LearningJourney.darkGray)
                                .font(.system(size: 12))
                            Button {
                                print("Hi!")
                            } label: {
                                TextPill.expert
                            }
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(16)
            .frame(width: size.width * 0.9)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
    }
    
    private func presentObjectiveView(_ objective: LearningObjective) {
        withAnimation {
            self.isPresentingObjective = true
            self.selectedObjective = objective
        }
    }
    
    private var blackOverlayView: some View {
        Color
            .black
            .opacity(0.3)
            .ignoresSafeArea()
            .transition(.opacity)
    }
    
    private var objectiveView: AnyView {
        guard let objective = selectedObjective
        else { fatalError("No object to present! This should never happen") }
        
        return AnyView(
            LearningObjectiveView(objective: objective)
                .transition(.scale)
        )
    }
    
    // MARK: - UI Helpers
    private func coreElectiveTag(objective: LearningObjective) -> some View {
        objective.details.isCore ? TextPill.core : TextPill.elective
    }
    
    // MARK: - Helpers

    private func loadRoadObjectives() {
        injected.interactors.learningRoadInteractor.load(
            objectives: $objectives,
            road: learningRoad
        )
    }
}

extension LearningObjective {
    typealias Code = String
}

extension LearningRoadView {
    struct Routing: Equatable {
        var learningObjective: LearningObjective.Code?
    }
}

#if DEBUG
    struct LearningRoadView1_Previews: PreviewProvider {
        static var previews: some View {
            Text("asd")
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    struct LearningRoadView_Previews: PreviewProvider {
        static var previews: some View {
            LearningRoadView(learningRoad: .dummy(.dummy))
        }
    }
#endif
