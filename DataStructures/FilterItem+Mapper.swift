import Foundation

extension TreeNode<FilterItem> {
    func select(isSelected: Bool) {
        value.isSelected = isSelected
    }

    func selectWithChildrens(for id: String, isSelected: Bool) {
        guard let node = search(id: id) else { return }
        if node.children.isEmpty {
            node.parent?.select(isSelected: false)
        } else {
            node.selectChildrens(isSelected: isSelected)
        }
        node.select(isSelected: isSelected)
    }

    func selectChildrens(isSelected: Bool) {
        for child in self.children {
            if child.children.isNotEmpty {
                child.select(isSelected: isSelected)
                child.selectChildrens(isSelected: isSelected)
            } else {
                child.select(isSelected: isSelected)
            }
        }
    }
    
    func selected(from id: String? = .none) -> [String] {
        let currentId = id ?? self.value.id
        guard let node = search(id: currentId) else { return [] }
        var values: [String] = node.children.flatMap {
            $0.selected(from: $0.value.id)
        }
        if node.value.isSelected {
            values.append(node.value.id)
        }
        return values
    }

    func add(cars: [CarFilter]) {
        cars.forEach {
            let node = TreeNode<FilterItem>(model: $0)
            if case let .tesla(values) = $0 {
                let childrens = values.map(TreeNode<FilterItem>.init)
                childrens.forEach(node.add)
            }
            add(node)
        }
    }
    
    func add(fruits: [FruitFilter]) {
        fruits.map(TreeNode<FilterItem>.init).forEach(add)
    }
    
    func add(football: [FootallFilter]) {
        football.forEach {
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
            add(node)
        }
    }
    
    func add(pets: [PetFilter]) {
        pets.forEach {
            let node = TreeNode<FilterItem>(model: $0)
            if case let .dog(values) = $0 {
                let childrens = values.map(TreeNode<FilterItem>.init)
                childrens.forEach(node.add)
            }
            add(node)
        }
    }
    
    convenience init(model: FilterCategoryType) {
        self.init(FilterItem(id: model.id, title: model.title))
    }
    
    convenience init(model: Tesla) {
        self.init(FilterItem(id: model.id, title: model.title))
    }

    convenience init(model: CarFilter) {
        self.init(FilterItem(id: model.id, title: model.title))
    }

    convenience init(model: FruitFilter) {
        self.init(FilterItem(id: model.id, title: model.title))
    }

    convenience init(model: PL) {
        self.init(FilterItem(id: model.id, title: model.title))
    }

    convenience init(model: LaLiga) {
        self.init(FilterItem(id: model.id, title: model.title))
    }

    convenience init(model: SerieA) {
        self.init(FilterItem(id: model.id, title: model.title))
    }

    convenience init(model: FootallFilter) {
        self.init(FilterItem(id: model.id, title: model.title))
    }

    convenience init(model: Dog) {
        self.init(FilterItem(id: model.id, title: model.title))
    }
    
    convenience init(model: PetFilter) {
        self.init(FilterItem(id: model.id, title: model.title))
    }
}
