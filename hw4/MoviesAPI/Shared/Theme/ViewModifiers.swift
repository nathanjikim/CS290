import SwiftUI

struct InfoSectionHeader: ViewModifier {
  func body(content: Content) -> some View {
    content
      .font(.headline)
      .padding(6)
      .background(RoundedRectangle(cornerRadius: 30).foregroundColor(Color.yellow))
  }
}
