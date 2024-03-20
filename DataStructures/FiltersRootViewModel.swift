import Foundation

// filters -> filter -> subfilter -> filter group

enum Event: Hashable {
    case setFilters
    case setChildren(for: FilterCategoryType)
    case selected(id: String, Bool)
    case applyCurrentFilters
    case resetCurrentFilters
    case resetAll
}

extension FilterItem {
    fileprivate static var root: Self {
        FilterItem(title: "Filters")
    }
}

@MainActor
class FiltersRootViewModel: ObservableObject {
    @Published private var allFilters: TreeNode<FilterItem> = .init(.root)
    @Published private var currentCategory: FilterCategoryType?
    @Published private var currentFilter: TreeNode<FilterItem>?
    @Published private(set) var selectedFilters: String?
    private let categories: [FilterCategoryType]
    
    init(categories: [FilterCategoryType]) {
        self.categories = categories
    }
    
    func handle(event: Event) async {
        switch event {
        case .setFilters:
            setFilters()
        case let .setChildren(category):
            setChildrens(for: category)
        case let .selected(id, isSelected):
            select(id: id, isSelected: isSelected)
        case .applyCurrentFilters:
            applyCurrent()
        case .resetCurrentFilters:
            resetToCurrent()
        case .resetAll:
            resetAll()
        }
    }
    
    func topFilters() -> [TreeNode<FilterItem>] {
        allFilters.children
    }

    func childrens(for category: FilterCategoryType) -> [TreeNode<FilterItem>] {
        guard let filter = currentFilter?.search(id: category.id) else { return [] }
        return filter.children
    }
    
    func selectedFilters(for category: FilterCategoryType) -> String {
        let selected = allFilters.selected(from: category.id)
        return selected.isEmpty ? category.defaultSelection.title : selected.joined(separator: ", ")
    }

    private func setFilters() {
        categories.map(TreeNode<FilterItem>.init).forEach(allFilters.add)
    }

    private func setChildrens(for category: FilterCategoryType) {
        guard let filter = allFilters.search(id: category.id) else { return }
        let newValues = filter.copy()
        defer {
            currentCategory = category
            currentFilter = newValues
        }
        guard newValues.children.isEmpty else { return }
        switch category {
        case .cars:
            newValues.add(cars: CarFilter.allCases)
        case .footballTeams:
            newValues.add(football: FootallFilter.allCases)
        case .fruits:
            newValues.add(fruits: FruitFilter.allCases)
        case .pets:
            newValues.add(pets: PetFilter.allCases)
        }
    }
    
    private func applyCurrent() {
        guard
            let currentCategory,
            let currentFilter,
            let filter = allFilters.search(id: currentCategory.id)
        else { return }
        filter.replace(with: currentFilter)
        selectedFilters = allFilters.selected().joined(separator: ", ")
    }
    
    private func resetToCurrent() {
        guard let currentCategory else { return }
        currentFilter?.selectWithChildrens(for: currentCategory.id, isSelected: false)
    }
    
    private func resetAll() {
        currentCategory = nil
        currentFilter = nil
        selectedFilters = nil
        allFilters.children.forEach {
            $0.forEachDepthFirst {
                $0.value.isSelected = false
            }
        }
    }
    
    private func select(id: String, isSelected: Bool) {
        currentFilter?.selectWithChildrens(for: id, isSelected: isSelected)
    }
}
