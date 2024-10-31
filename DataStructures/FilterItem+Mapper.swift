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

    convenience init(model: FilterIdentifiable) {
        self.init(FilterItem(model))
    }
}
