import Foundation
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
        
        if children.isNotEmpty {
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
    
    func copy() -> TreeNode<T> {
        let item = TreeNode(self.value)
        for child in children {
            let copy = child.copy()
            item.add(copy)
        }
        return item
    }
    
    func replace(with node: TreeNode<T>) {
        value = node.value
        children = node.children
    }
}

extension TreeNode: Equatable where T: Equatable {
    static func ==(lhs: TreeNode, rhs: TreeNode) -> Bool {
        lhs.value == rhs.value && lhs.children == rhs.children
    }
}

extension TreeNode: Hashable where T: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(value)
        hasher.combine(children)
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
