import CoreData

protocol CoreDataFacade {
    func fetchLearningObjectives(for road: LearningRoad) -> [LearningObjective]?
    func fetchLearningRoads(for journey: LearningJourney) -> [LearningRoad]?
    func fetchLearningJourneys() -> [LearningJourney]?
    
    func addLearningJourney(journey: String)
    func addLearningRoad(
        name: String,
        journey: LearningJourney
    )
    func addObjective(
        cluster: String,
        code: String,
        enterpriseDelta: String,
        expertDescription: String,
        intermediateDescription: String,
        isBasic: Bool,
        isCore: Bool,
        learningObjective: String,
        noviceDescription: String,
        proficientDescription: String,
        shared: String,
        topic: String,
        current: String?,
        goal: String?,
        learningRoad: LearningRoad
    )
}

struct DefaultCoreDataFacade: CoreDataFacade {
    private let coreDataStack: CoreDataStack
    private var context: NSManagedObjectContext { coreDataStack.persistentContainer.viewContext }
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func addLearningJourney(journey name: String) {
        let journey = NSEntityDescription.insertNewObject(
            forEntityName: "LearningJourney",
            into: context
        )
        journey.setValue(name, forKey: "name")
        try! context.save()
    }
    
    func addLearningRoad(
        name: String,
        journey: LearningJourney
    ) {
        let road = NSEntityDescription.insertNewObject(
            forEntityName: "LearningRoad",
            into: context
        )
        road.setValue(name, forKey: "name")
        road.setValue(journey, forKey: "learningJourney")
        try! context.save()
    }
    
    func addObjective(
        cluster: String,
        code: String,
        enterpriseDelta: String,
        expertDescription: String,
        intermediateDescription: String,
        isBasic: Bool,
        isCore: Bool,
        learningObjective: String,
        noviceDescription: String,
        proficientDescription: String,
        shared: String,
        topic: String,
        current: String?,
        goal: String?,
        learningRoad: LearningRoad
    ) {
    
        let objective = NSEntityDescription.insertNewObject(
            forEntityName: "LearningObjective",
            into: context
        )
        
        objective.setValue(cluster, forKey: "cluster")
        objective.setValue(code, forKey: "code")
        objective.setValue(enterpriseDelta, forKey: "enterpriseDelta")
        objective.setValue(expertDescription, forKey: "expertDescription")
        objective.setValue(intermediateDescription, forKey: "intermediateDescription")
        objective.setValue(isBasic, forKey: "isBasic")
        objective.setValue(isCore, forKey: "isCore")
        objective.setValue(learningObjective, forKey: "learningObjective")
        objective.setValue(noviceDescription, forKey: "noviceDescription")
        objective.setValue(proficientDescription, forKey: "proficientDescription")
        objective.setValue(shared, forKey: "shared")
        objective.setValue(topic, forKey: "topic")
        objective.setValue(current, forKey: "current")
        objective.setValue(goal, forKey: "goal")
        objective.setValue(learningRoad, forKey: "learningRoad")
        
        try! context.save()
    }
    
    func fetchLearningObjectives(for road: LearningRoad) -> [LearningObjective]? {
        // TODO query with filter
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LearningObjective")
        let allObjectives = try? context.fetch(fetchRequest) as? [LearningObjective]
        return allObjectives?.filter { $0.learningRoad == road }
    }
    
    func fetchLearningRoads(for journey: LearningJourney) -> [LearningRoad]? {
        // TODO query with filter
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LearningRoad")
        let allRoads = try? context.fetch(fetchRequest) as? [LearningRoad]
        return allRoads?.filter { $0.learningJourney == journey }
    }
    
    func fetchLearningJourneys() -> [LearningJourney]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LearningJourney")
        return try? context.fetch(fetchRequest) as? [LearningJourney]
    }
}
