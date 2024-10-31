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

@MainActor
class FiltersRootViewModel: ObservableObject {
    @Published private var allFilters: TreeNode<FilterItem> = .init(FilterItem(RootItem()))
    @Published private var currentCategory: FilterCategoryType?
    @Published private var currentFilter: TreeNode<FilterItem>?
    @Published private(set) var selectedFilters: String?
    private let factory = FilterFactory()
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
        let item = filter.copy()
        defer {
            currentCategory = category
            currentFilter = item
        }
        guard item.children.isEmpty else { return }
        factory.createItem(for: category, in: item)
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
    
    func seeResults() {
        let result = factory.results(from: allFilters)
        print(result)
    }
}
