import SwiftUI
struct FilterView: View {
    @EnvironmentObject var viewModel: FiltersRootViewModel
    @Environment(\.presentationMode) var presentationMode
    @State private var currentEvent: Event?
    private var category: FilterCategoryType

    init(category: FilterCategoryType) {
        self.category = category
    }
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                ForEach(viewModel.childrens(for: category), id: \.value) { item in
                    Row(item: item) {
                        currentEvent = $0
                    }
                }
            }
            .padding()
            bottomButton
        }
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
        .task(id: currentEvent) {
            guard let currentEvent else { return }
            await viewModel.handle(event: currentEvent)
            self.currentEvent = nil
        }
        .onAppear {
            currentEvent = .setChildren(for: category)
        }
    }
    
    @ViewBuilder
    var bottomButton: some View {
        HStack {
            Button(action: {
                currentEvent = .resetCurrentFilters
            }, label: {
                Text("Reset")
            })
            .frame(maxWidth: .infinity, alignment: .center)
            Button(action: {
                currentEvent = .applyCurrentFilters
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Apply")
            })
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 50)
    }
    
    struct Row: View {
        var item: TreeNode<FilterItem>
        var onSelect: (Event) -> Void
        
        var body: some View {
            VStack(spacing: 0) {
                CheckboxView(title: item.value.title, isChecked: .init(
                    get: {
                        item.value.isSelected
                    }, set: {
                        onSelect(.selected(id: item.value.id, $0))
                    })
                )
                .padding(.vertical, 16)
                Divider()
                if item.children.isNotEmpty {
                    ForEach(item.children, id: \.value) { child in
                        CheckboxView(title: child.value.title, isChecked: .init(
                            get: {
                                child.value.isSelected
                            }, set: {
                                onSelect(.selected(id: child.value.id, $0))
                            })
                        )
                        .padding(.vertical, 16)
                        .padding(.leading, 12)
                        Divider()
                    }
                }
            }
        }
    }
}
