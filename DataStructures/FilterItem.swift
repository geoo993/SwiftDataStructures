import Foundation

struct FilterItem: Identifiable, Hashable {
    var id: String
    var title: String
    var isSelected: Bool = false
    
    init(id: String = UUID().uuidString, title: String) {
        self.id = id
        self.title = title
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

enum FilterDefaultSelection {
    case all, none
    
    var title: String {
        switch self {
        case .all:
            return "All"
        case .none:
            return "None"
        }
    }
}

enum FilterCategoryType: String, Identifiable, CaseIterable {
    case cars
    case fruits
    case footballTeams
    case pets
    
    var id: String {
        rawValue
    }

    var title: String {
        switch self {
        case .cars:
            return "Cars"
        case .fruits:
            return "Fruits"
        case .footballTeams:
            return "Football teams"
        case .pets:
            return "Pets"
        }
    }
    
    var defaultSelection: FilterDefaultSelection {
        switch self {
        case .cars:
            return .none
        case .fruits:
            return .all
        case .footballTeams:
            return .none
        case .pets:
            return .all
        }
    }
}

public enum Tesla: String, Identifiable {
    case modelY
    case modelS
    case modelX
    
    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .modelY:
            return "Model Y"
        case .modelS:
            return "Model S"
        case .modelX:
            return "Model X"
        }
    }
}

public enum CarFilter: Identifiable, CaseIterable {
    public static var allCases: [CarFilter] = [
        .tesla([.modelS, .modelX, .modelY]),
        .bmw, .audi, .ferrari, .cadillac, .porche
    ]
    
    case tesla([Tesla])
    case bmw
    case audi
    case ferrari
    case cadillac
    case porche
    
    public var id: String {
        switch self {
        case .tesla:
            return "tesla"
        case .bmw:
            return "bmw"
        case .audi:
            return "audi"
        case .ferrari:
            return "ferrari"
        case .cadillac:
            return "cadillac"
        case .porche:
            return "porche"
        }
    }
    
    public var title: String {
        switch self {
        case .tesla:
            return "Tesla"
        case .bmw:
            return "BMW"
        case .audi:
            return "Audi"
        case .ferrari:
            return "Ferrari"
        case .cadillac:
            return "Cadillac"
        case .porche:
            return "Porche"
        }
    }
}

public enum FruitFilter: String, Identifiable, CaseIterable {
    case banana
    case apple
    case pear
    case watermelon
    case papaya
    case kiwi
    case pineaple
    case grape
    case orange
    
    public var id: String {
        rawValue
    }
    
    public var title: String {
        switch self {
        case .banana:
            return "Banana"
        case .apple:
            return "Apple"
        case .pear:
            return "Pear"
        case .watermelon:
            return "Watermelon"
        case .papaya:
            return "Papaya"
        case .kiwi:
            return "Kiwi"
        case .pineaple:
            return "Pineaple"
        case .grape:
            return "Grape"
        case .orange:
            return "Orange"
        }
    }
}

public enum PL: String, Identifiable {
    case arsenal
    case manUtd
    case manCity
    case liverpool
    
    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .arsenal:
            return "Arsenal"
        case .manUtd:
            return "Man utd"
        case .manCity:
            return "Man city"
        case .liverpool:
            return "Liverpool"
        }
    }
}

public enum LaLiga: String, Identifiable {
    case realMadrid
    case athletico
    case barcelona
    
    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .realMadrid:
            return "Real Madrid"
        case .athletico:
            return "Athletico Madrid"
        case .barcelona:
            return "Barcelona"
        }
    }
}

public enum SerieA: String, Identifiable {
    case roma
    case milan
    case napoli
    case juventus
    case inter
    
    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .roma:
            return "Roma"
        case .inter:
            return "Inter"
        case .milan:
            return "Milan"
        case .napoli:
            return "Napoli"
        case .juventus:
            return "Juventus"
        }
    }
}


public enum FootallFilter: Identifiable, CaseIterable {
    public static var allCases: [FootallFilter] = [
        .pl([.arsenal, .liverpool, .manCity, .manUtd]),
        .laLiga([.athletico, .barcelona, .realMadrid]),
        .serieA([.inter, .juventus, .milan, .napoli, .roma])
    ]
    
    case pl([PL])
    case laLiga([LaLiga])
    case serieA([SerieA])
    
    public var id: String {
        switch self {
        case .pl: return "footballPremierLeague"
        case .laLiga: return "footballLaLiga"
        case .serieA: return "footballSerieA"
        }
    }
    
    public var title: String {
        switch self {
        case .pl:
            return "Premier League"
        case .laLiga:
            return "La Liga"
        case .serieA:
            return "Serie A"
        }
    }
}

public enum Dog: String, Identifiable {
    case poodle
    case bulldog
    case chihuahua
    case goldendoodle
    case germanShepherd
    
    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .poodle:
            return "Poodle"
        case .bulldog:
            return "Bulldog"
        case .chihuahua:
            return "Chihuahua"
        case .goldendoodle:
            return "Goldendoodle"
        case .germanShepherd:
            return "German Shepherd"
        }
    }
}

public enum PetFilter: Identifiable, CaseIterable {
    public static var allCases: [PetFilter] = [
        .cat, .parrot, .horse,
        .dog([.poodle, .bulldog, .chihuahua, .goldendoodle, .germanShepherd]),
        .hamster,
        .fish
    ]
    
    case cat
    case parrot
    case horse
    case dog([Dog])
    case hamster
    case fish
    
    public var id: String {
        switch self {
        case .cat:
            return "cat"
        case .parrot:
            return "parrot"
        case .dog:
            return "dog"
        case .horse:
            return "horse"
        case .hamster:
            return "hamster"
        case .fish:
            return "fish"
        }
    }
    
    public var title: String {
        switch self {
        case .cat:
            return "Cat"
        case .parrot:
            return "Parrot"
        case .dog:
            return "Dog"
        case .horse:
            return "Horse"
        case .hamster:
            return "Hamster"
        case .fish:
            return "Fish"
        }
    }
}
