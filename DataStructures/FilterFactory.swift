import Foundation

struct FilterFactory {
    func createItem(for type: FilterCategoryType, in item: TreeNode<FilterItem>) {
        switch type {
        case .cars:
            CarFilter.allCases.forEach {
                let node = TreeNode<FilterItem>(model: $0)
                if case let .tesla(values) = $0 {
                    let childrens = values.map(TreeNode<FilterItem>.init)
                    childrens.forEach(node.add)
                }
                item.add(node)
            }
        case .fruits:
            FruitFilter.allCases
                .map(TreeNode<FilterItem>.init)
                .forEach(item.add)
        case .footballTeams:
            FootallFilter.allCases.forEach {
                let node = TreeNode<FilterItem>(model: $0)
                var childrens: [TreeNode<FilterItem>]
                switch $0 {
                case let .pl(values):
                    childrens = values.map(TreeNode<FilterItem>.init)
                case let .laLiga(values):
                    childrens = values.map(TreeNode<FilterItem>.init)
                case let .serieA(values):
                    childrens = values.map(TreeNode<FilterItem>.init)
                }
                childrens.forEach(node.add)
                item.add(node)
            }
        case .pets:
            PetFilter.allCases.forEach {
                let node = TreeNode<FilterItem>(model: $0)
                if case let .dog(values) = $0 {
                    let childrens = values.map(TreeNode<FilterItem>.init)
                    childrens.forEach(node.add)
                }
                item.add(node)
            }
        }
    }

    func results(from root: TreeNode<FilterItem>) -> FilterResults {
        var cars = [CarFilter]()
        var fruits = [FruitFilter]()
        var footballTeams = [FootallFilter]()
        var pets = [PetFilter]()
        root.forEachDepthFirst { node in
            guard node.value.isSelected else { return }
            if let item = node.value.wrappedItem as? CarFilter {
                cars.append(item)
            }
            
            if let item = node.value.wrappedItem as? FruitFilter {
                fruits.append(item)
            }
            
            if let item = node.value.wrappedItem as? FootallFilter {
                footballTeams.append(item)
            }
            
            if let item = node.value.wrappedItem as? PetFilter {
                pets.append(item)
            }
        }
        return .init(cars: cars, fruits: fruits, footballTeams: footballTeams, pets: pets)
    }
}
