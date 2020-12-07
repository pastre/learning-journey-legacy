import SwiftUI
import Combine

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
    
    // MARK: - Dependencies
    @State private var objectives: Loadable<LazyList<LearningObjective>>
    let learningRoad: LearningRoad
    
    // MARK: - UI Components
    var body: some View {
        AnyView(
            content
        )
        .navigationTitle(learningRoad.name)
        .background(Color.ljGray)
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
        self._objectives = .init(initialValue: objectives)
    }
    
    // MARK: - UI state components
    private var notRequestedView: some View {
        Text("VAZIO")
            .onAppear(perform: loadRoadObjectives)
    }
    
    
    private func loadedView(_ objectives: LazyList<LearningObjective>) -> some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(
                    columns: [GridItem].init(repeating: .init(.flexible()), count: 1),
                    alignment: .center,
                    content: {
                    ForEach(objectives, id: \.code) { objective in
                        objectiveCell(objective, geometry.size)
                    }
                })
            }
        }
        
    }
    
    private func objectiveCell(_ objective: LearningObjective, _ size: CGSize) -> some View {
        Group {
            VStack {
                Group {
                    HStack {
                        Text(objective.code)
                            .bold()
                            .font(.system(
                                    size: 14,
                                    weight: .heavy
                            ))
                            .foregroundColor(Color.darkGray)
                        Spacer()
                        self.coreElectiveTag(objective: objective)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0))
                    .frame(maxWidth: .infinity)
                    
                    Text(objective.learningObjective)
                        .bold()
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .layoutPriority(0.5)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Current level")
                                .bold()
                                .foregroundColor(Color.darkGray)
                                .font(.system(size: 12))
                            Button("Set your level") {
                                print("SETTING")
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("Goal")
                                .bold()
                                .foregroundColor(Color.darkGray)
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
    
    private func coreElectiveTag(objective: LearningObjective) -> some View {
        switch objective.coreElective {
        case "Elective": return TextPill.elective
        case "Core": return TextPill.core
        default: break
        }
        return TextPill(
            title: objective.coreElective,
            backgroundColor: Color.init(hex: 0xA100DA),
            titleColor: .white
        )
    }
    
    // MARK: - Helpers
    private func loadRoadObjectives() {
        injected.interactors.learningRoadInteractor.load(objectives: $objectives, road: learningRoad)
    }
    
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
        LearningRoadView(learningRoad: .init(name: "Fake", learningObjectives: [
            .random,
            .random,
            .random,
            .random,
            ]),
            objectives: .loaded([
                .random,
                .random,
                .random,
                .random,
            ].lazyList
            )
        )
    }
}
#endif
