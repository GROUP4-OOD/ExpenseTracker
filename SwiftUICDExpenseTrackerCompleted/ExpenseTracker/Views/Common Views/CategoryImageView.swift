import SwiftUI

struct CategoryImageView: View {
    
    let category: Category
    
    @State private var isAnimating: Bool = false
    
    var body: some View {
        Image(systemName: category.systemNameIcon)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 20, height: 20)
            .padding(.all, 8)
            .foregroundColor(category.color)
            .background(category.color.opacity(0.1))
            .cornerRadius(18)
            .scaleEffect(isAnimating ? 1.1 : 1)
            .animation(.spring(response: 0.5, dampingFraction: 0.4, blendDuration: 0.2), value: isAnimating)
            .onAppear {
                withAnimation(.easeInOut(duration: 1).repeatForever()) {
                    self.isAnimating = true
                }
            }
            .onDisappear {
                withAnimation {
                    self.isAnimating = false
                }
            }
    }
}

