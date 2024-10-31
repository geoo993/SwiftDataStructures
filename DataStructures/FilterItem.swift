import Foundation

protocol FilterIdentifiable: Sendable {
    var id : String { get }
    var title: String { get }
}

struct FilterItem: Identifiable, Hashable {
    let wrappedItem: FilterIdentifiable
    var isSelected: Bool = false
    
    var id: String {
        wrappedItem.id
    }
    
    var title: String {
        wrappedItem.title
    }

    init<I: FilterIdentifiable>(_ wrappedItem: I) {
        self.wrappedItem = wrappedItem
    }

    static func == (lhs: FilterItem, rhs: FilterItem) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct RootItem: FilterIdentifiable {
    var id: String { "root" }
    var title: String { "Filters" }
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

enum FilterCategoryType: String, FilterIdentifiable, CaseIterable {
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

enum Tesla: String, FilterIdentifiable {
    case modelY
    case modelS
    case modelX
    
    var id: String {
        rawValue
    }

    var title: String {
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

enum CarFilter: FilterIdentifiable, CaseIterable {
    static var allCases: [CarFilter] = [
        .tesla([.modelS, .modelX, .modelY]),
        .bmw, .audi, .ferrari, .cadillac, .porche
    ]
    
    case tesla([Tesla])
    case bmw
    case audi
    case ferrari
    case cadillac
    case porche
    
    var id: String {
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
    
    var title: String {
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

enum FruitFilter: String, FilterIdentifiable, CaseIterable {
    case banana
    case apple
    case pear
    case watermelon
    case papaya
    case kiwi
    case pineaple
    case grape
    case orange
    
    var id: String {
        rawValue
    }
    
    var title: String {
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

enum PL: String, FilterIdentifiable {
    case arsenal
    case manUtd
    case manCity
    case liverpool
    
    var id: String {
        rawValue
    }

    var title: String {
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

enum LaLiga: String, FilterIdentifiable {
    case realMadrid
    case athletico
    case barcelona
    
    var id: String {
        rawValue
    }

    var title: String {
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

enum SerieA: String, FilterIdentifiable {
    case roma
    case milan
    case napoli
    case juventus
    case inter
    
    var id: String {
        rawValue
    }

    var title: String {
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


enum FootallFilter: FilterIdentifiable, CaseIterable {
    static var allCases: [FootallFilter] = [
        .pl([.arsenal, .liverpool, .manCity, .manUtd]),
        .laLiga([.athletico, .barcelona, .realMadrid]),
        .serieA([.inter, .juventus, .milan, .napoli, .roma])
    ]
    
    case pl([PL])
    case laLiga([LaLiga])
    case serieA([SerieA])
    
    var id: String {
        switch self {
        case .pl: return "footballPremierLeague"
        case .laLiga: return "footballLaLiga"
        case .serieA: return "footballSerieA"
        }
    }
    
    var title: String {
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

enum Dog: String, FilterIdentifiable {
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

enum PetFilter: FilterIdentifiable, CaseIterable {
    static var allCases: [PetFilter] = [
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
    
    var id: String {
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
    
    var title: String {
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

struct FilterResults {
    let cars: [CarFilter]
    let fruits: [FruitFilter]
    let footballTeams: [FootallFilter]
    let pets: [PetFilter]

}

extension FilterResults: CustomStringConvertible {
    var description: String {
        let text = """
        [\(cars.map(\.title).joined(separator: ","))]
        [\(fruits.map(\.title).joined(separator: ","))]
        [\(footballTeams.map(\.title).joined(separator: ","))]
        [\(pets.map(\.title).joined(separator: ","))]
        """
        return text
    }
}
