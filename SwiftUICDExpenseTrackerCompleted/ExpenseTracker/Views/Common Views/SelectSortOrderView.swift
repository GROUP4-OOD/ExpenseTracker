import SwiftUI

struct SelectSortOrderView: View {
    
    @Binding var sortType: SortType
    @Binding var sortOrder: SortOrder
    
    private let sortTypes = SortType.allCases
    private let sortOrders = SortOrder.allCases
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Image(systemName: "arrow.up.arrow.down.circle")
                    .font(.system(size: 24))
                Text("Sort Order")
                    .font(.title3)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .padding(.all)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.blue)
            )
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation {
                            self.sortType = .date
                            self.sortOrder = .descending
                        }
                    }) {
                        Text("Reset")
                            .fontWeight(.semibold)
                    }
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Sort by")
                    .font(.title3)
                    .fontWeight(.semibold)
                Picker(selection: $sortType, label: Text("Sort by")) {
                    ForEach(SortType.allCases) { type in
                        Text(type.rawValue.capitalized)
                            .font(.system(size: 14, weight: .semibold))
                            .tag(type)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Order by")
                    .font(.title3)
                    .fontWeight(.semibold)
                Picker(selection: $sortOrder, label: Text("Order")) {
                    ForEach(sortOrders) { order in
                        Text(order.rawValue.capitalized)
                            .font(.system(size: 14, weight: .semibold))
                            .tag(order)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .padding(.all)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(radius: 4, y: 2)
        )
        .foregroundColor(.gray)
    }
}

struct SelectSortOrderView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSortOrderView(sortType: .constant(.amount), sortOrder: .constant(.descending))
    }
}
