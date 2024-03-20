import Foundation
import SwiftUI
import PlaygroundSupport
// https://www.hackingwithswift.com/plus/data-structures/trees
// https://medium.com/swlh/implementing-tree-data-structure-in-swift-39dc5a28da72
// https://www.kodeco.com/1053-swift-algorithm-club-swift-tree-data-structure/page/2

class TreeNode<T> {
    
    weak var parent: TreeNode?
    var value: T
    var children: [TreeNode] = []

    init(_ value: T) {
        self.value = value
    }
    
    func add(_ child: TreeNode) {
        children.append(child)
        child.parent = self
    }
}

extension TreeNode: CustomStringConvertible {
    var description: String {
        var text = "\(value)"
        
        if !children.isEmpty {
            text += " {" + children.map { $0.description }.joined(separator: ", ") + "} "
        }
        return text
    }
}

extension TreeNode {
    func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
}

extension TreeNode where T: Equatable {
    func search(value: T) -> TreeNode? {
        if value == self.value {
            return self
        }
        for child in children {
            if let found = child.search(value: value) {
                return found
            }
        }
        return nil
    }
}


func makeFootballUniverse() -> TreeNode<String> {
    let tree = TreeNode("Euro Clubs")
    
    let premierL = TreeNode("Premier League")
    let laLiga = TreeNode("La liga")
    let serieA = TreeNode("Serie A")
    
    let manCity = TreeNode("Man City")
    let arsenal = TreeNode("Arsenal")
    let manUtd = TreeNode("Man Utd")
    let liverpool = TreeNode("Liverpool")
    let realMadrid = TreeNode("Real Madrid")
    let barcelona = TreeNode("Barcelona")
    let inter = TreeNode("Inter")
    let milan = TreeNode("Milan")
    let napoli = TreeNode("Napoli")
    let athleticoMadrid = TreeNode("Athletico Madrid")
    let juventus = TreeNode("Juventus")
    let roma = TreeNode("Roma")
    
    let amad = TreeNode("Amad")
    let hojlund = TreeNode("Højlund")
    let harland = TreeNode("Harland")
    let bernardo = TreeNode("Bernardo Silva")
    let sala = TreeNode("Sala")
    let nunez = TreeNode("Nunez")
    let osimen = TreeNode("Osimen")
    let bellingam = TreeNode("Jude Bellingam")
    let martinez = TreeNode("L Martinez")
    let pulisic = TreeNode("Pulisic")
    let vini = TreeNode("Vini jr")
    let raphinha = TreeNode("Raphinha")
    
    tree.add(premierL)
    tree.add(laLiga)
    tree.add(serieA)
    
    premierL.add(manCity)
    premierL.add(arsenal)
    premierL.add(manUtd)
    premierL.add(liverpool)
    
    laLiga.add(athleticoMadrid)
    laLiga.add(barcelona)
    laLiga.add(realMadrid)
    
    serieA.add(inter)
    serieA.add(napoli)
    serieA.add(juventus)
    serieA.add(roma)
    
    manUtd.add(amad)
    manUtd.add(hojlund)
    manCity.add(harland)
    manCity.add(bernardo)
    liverpool.add(sala)
    liverpool.add(nunez)
    napoli.add(osimen)
    realMadrid.add(bellingam)
    inter.add(martinez)
    milan.add(pulisic)
    realMadrid.add(vini)
    barcelona.add(raphinha)
    
    return tree
}

public enum CardMachinesItem: String, Identifiable {
    case dojoGoOneWired
    case dojoPocket
    case tapToPayOnIPhone
    
    public var id: String {
        rawValue
    }

    public var title: String {
        switch self {
        case .dojoGoOneWired:
            return "Dojo Go/One/Wired"
        case .dojoPocket:
            return "Dojo pocket"
        case .tapToPayOnIPhone:
            return "Tap to pay on iPhone"
        }
    }
}

enum FilterCategoryType: Int {
    case dateRange
    case timeRange
    case location
    case paymentMethod
    case paymentStatus
    case cardMachine
    case cardType
    case paymentSource

    var title: String {
        switch self {
        case .cardType:
            return "Card"
        case .location:
            return "Location"
        case .dateRange:
            return "Date"
        case .timeRange:
            return "Time"
        case .paymentMethod:
            return "LocalizedText.Filters.PaymentMethod.title"
        case .cardMachine:
            return "Card machine"
        case .paymentStatus:
            return "Status"
        case .paymentSource:
            return "Payment source"
        }
    }
}


public enum PaymentMethod: Identifiable, CaseIterable {
    public static var allCases: [PaymentMethod] = [
        .cardMachine([.dojoGoOneWired, .dojoPocket, .tapToPayOnIPhone]),
        .online, .paymentLinks, .virtualTerminal, .bookings, .payByQr
    ]
    
    case cardMachine([CardMachinesItem])
    case online
    case paymentLinks
    case virtualTerminal
    case bookings
    case payByQr
    
    public var id: String {
        switch self {
        case .cardMachine:
            return "cardMachine"
        case .online:
            return "online"
        case .paymentLinks:
            return "paymentLinks"
        case .virtualTerminal:
            return "virtualTerminal"
        case .bookings:
            return "bookings"
        case .payByQr:
            return "payByQr"
        }
    }
    
    public var title: String {
        switch self {
        case .cardMachine:
            return "Card Machines"
        case .online:
            return "Online"
        case .paymentLinks:
            return "Payment links"
        case .virtualTerminal:
            return "Virtual Terminal"
        case .bookings:
            return "Bookings"
        case .payByQr:
            return "Pay by QR"
        }
    }
}

// filters -> filter -> subfilter -> filter group

struct FilterItem: Identifiable {
    var id: String
    let title: String
    var isSelected: Bool = false
    
    init(id: String = UUID().uuidString, title: String) {
        self.id = id
        self.title = title
    }
}

extension TreeNode where T: Identifiable, T.ID == String {
    func search(id: String) -> TreeNode? {
        if self.value.id == id {
            return self
        }
        for child in children {
            if let found = child.search(id: id) {
                return found
            }
        }
        return nil
    }
}

extension TreeNode<FilterItem> {
    func select(isSelected: Bool) {
        value.isSelected = isSelected
    }
    
    func select(at id: String, isSelected: Bool) {
        guard let node = search(id: id) else { return }
        node.select(isSelected: isSelected)
    }
    
    func selectChildrens(of id: String, isSelected: Bool) {
        guard let node = search(id: id) else { return }
        node.selectChildrens(isSelected: isSelected)
        node.select(isSelected: isSelected)
    }
    
    func selectChildrens(isSelected: Bool) {
        for child in self.children {
            if !child.children.isEmpty {
                child.selectChildrens(isSelected: isSelected)
            } else {
                child.value.isSelected = isSelected
            }
        }
    }
}

func makeFilters() -> TreeNode<FilterItem> {
    let root = FilterItem(title: "Filters")
    var tree = TreeNode<FilterItem>(root)
    
    for method in PaymentMethod.allCases {
        switch method {
        case let .cardMachine(list):
            let item = FilterItem(id: method.id, title: method.title)
            let node = TreeNode(item)
            for type in list {
                let subItem = FilterItem(id: type.id, title: type.title)
                node.add(TreeNode(subItem))
            }
            tree.add(node)
        default:
            let item = FilterItem(id: method.id, title: method.title)
            let node = TreeNode(item)
            tree.add(node)
        }
    }
    return tree
}

let tree = makeFilters()
tree.forEachDepthFirst { print($0.value) }

//print("Search")
//print(tree.search(value: "Inter")) // returns the "cocoa" node
//print(tree.search(value: "Man City")) // returns the "chai" node
//print(tree.search(value: "Vini jr")) // returns nil

//print(tree.search(id: ""))
//print(tree.search(value: Item(id: "payByQr", title: "Pay by QR")))
print(tree.search(id: "payByQr"))
//tree.select(at: "payByQr", isSelected: true)
tree.selectChildrens(of: "cardMachine", isSelected: true)
tree.forEachDepthFirst { print($0.value) }



var items: [FilterItem] = [
    FilterItem(title: "Yum"),
    FilterItem(title: "Sum")
]

items[0].isSelected = true

items.forEach { print($0) }
