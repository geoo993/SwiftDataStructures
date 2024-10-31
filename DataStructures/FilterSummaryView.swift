import SwiftUI

struct FilterSummaryView: View {
    @EnvironmentObject var viewModel: FiltersRootViewModel
    @Environment(\.dismiss) var dismiss
    @State private var currentEvent: Event?
    private var categories: [TreeNode<FilterItem>]

    init(items: [TreeNode<FilterItem>]) {
        self.categories = items
    }

    var body: some View {
        NavigationStack {
            VStack {
                List(categories, id: \.value) { category in
                    FilterCategoryType(rawValue: category.value.id).map { value in
                        NavigationLink(value: value) {
                            Row(title: value.title, subtitle: viewModel.selectedFilters(for: value))
                        }
                    }
                }
                bottomButton
            }
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: FilterCategoryType.self) { type in
                FilterView(category: type)
            }
        }
        .task(id: currentEvent) {
            guard let currentEvent else { return }
            await viewModel.handle(event: currentEvent)
            self.currentEvent = nil
        }
    }

    @ViewBuilder
    var bottomButton: some View {
        HStack {
            Button(action: {
                currentEvent = .resetAll
            }, label: {
                Text("Reset all")
            })
            .frame(maxWidth: .infinity, alignment: .center)
            Button(action: {
                viewModel.seeResults()
                dismiss()
            }, label: {
                Text("Apply")
            })
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .frame(height: 50)
    }
    
    struct Row: View {
        let title: String
        let subtitle: String
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(title)
                Text(subtitle)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundStyle(.gray)
            }
        }
    }
}
