import SwiftUI

struct FilterCategoriesView: View {
    
    @Binding var selectedCategories: Set<Category>
    private let categories = Category.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(categories) { category in
                    FilterButtonView(
                        category: category,
                        isSelected: self.selectedCategories.contains(category),
                        onTap: self.onTap
                    )
                    .padding(.leading, category == self.categories.first ? 16 : 0)
                    .padding(.trailing, category == self.categories.last ? 16 : 0)
                    .animation(.easeInOut, value: selectedCategories)
                }
            }
            .padding(.vertical)
        }
    }
    
    func onTap(category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}

struct FilterButtonView: View {
    
    var category: Category
    var isSelected: Bool
    var onTap: (Category) -> ()
    
    var body: some View {
        Button(action: {
            self.onTap(self.category)
        }) {
            VStack(spacing: 8) {
                Image(systemName: category.systemNameIcon)
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(isSelected ? .white : .gray)
                
                Text(category.rawValue.capitalized)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .white : .gray)
                    .fixedSize(horizontal: true, vertical: true)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? category.color : Color(UIColor.white))
                    .shadow(color: isSelected ? category.color.opacity(0.6) : Color(UIColor.lightGray).opacity(0.6), radius: 3, x: 0, y: 3)
            )
            .frame(height: 80)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(isSelected ? category.color : Color(UIColor.lightGray), lineWidth: 1)
            )
        }
        .foregroundColor(isSelected ? category.color : Color(UIColor.gray))
    }
}
