import SwiftUI

struct FiltersRootView: View {
    @State var seeFilters = false
    @StateObject var viewModel: FiltersRootViewModel
    @State private var currentEvent: Event?
    
    init(categories: [FilterCategoryType] = FilterCategoryType.allCases) {
        self._viewModel = StateObject(wrappedValue: .init(categories: categories))
    }
    
    var body: some View {
        VStack{
            Button("See Filters") {
                seeFilters = true
            }
            viewModel.selectedFilters.map {
                Text($0)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .sheet(isPresented: $seeFilters) {
            FilterSummaryView(items: viewModel.topFilters())
                .environmentObject(viewModel)
        }
        .task(id: currentEvent) {
            guard let currentEvent else { return }
            await viewModel.handle(event: currentEvent)
            self.currentEvent = nil
        }
        .onAppear {
            currentEvent = .setFilters
        }
    }
}

#Preview {
    FiltersRootView()
}
