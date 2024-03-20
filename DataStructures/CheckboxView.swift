import SwiftUI

struct CheckboxView: View {
    var title: String
    @Binding var isChecked: Bool
    
    var body: some View {
        VStack {
            Toggle(isOn: $isChecked) {
                Text(title)
            }
            .toggleStyle(CheckboxToggleStyle())
        }
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}
