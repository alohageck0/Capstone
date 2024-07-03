//
//  Menu.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/4/24.
//

import SwiftUI

public enum DishCategory: String, Codable  {
    case starters
    case mains
    case desserts
    case drinks
    case none
}


struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    @State private var selectedCategory: DishCategory = .none
    
    var body: some View {
        VStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Little Lemon")
                        .display()
                        .foregroundColor(.primary_yellow)
                        .padding(.horizontal, 25)
                    HStack(spacing: 0) {
                        VStack(alignment: .leading) {
                            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                                .paragraph()
                                .padding(.top, 40)
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 25)
                        .frame(height: 170)
                        Image.restaurant
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150, alignment: .center) //  <<: Here
                            .cornerRadius(20)
                            .clipped()
                            .padding(.trailing, 25)
                    }
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("search dish", text: $searchText)
                        .foregroundColor(.primary_green)
                        
                        Button(action: {
                            self.searchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                    .foregroundColor(.primary_green)
                    .background(.secondary_white)
                    .cornerRadius(10.0)
                    .padding(25)
                }
                .background(Color.primary_green)
                
                VStack {
                    HStack(spacing: 0) {
                        Text("Chicago")
                            .regular()
                            .foregroundColor(.white)
                            .padding(.horizontal, 25)
                        Spacer()
                    }
                    .padding(.top, 55)
                    Spacer()
                }
            }
            
            MenuBreakdownView(selectedCategory: $selectedCategory)
                .padding(.horizontal, 25)
            
            FetchedObjects(
                predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        MenuItemView(dish: dish)
                            .padding(.bottom, 10)
                            .listRowInsets(EdgeInsets())
                    }
                }
                .listStyle(PlainListStyle())
                .padding(.horizontal, 25)
                .scrollContentBackground(.hidden)
                .scrollIndicators(.hidden)
            }
        }
        .onAppear {
            debugPrint("evv; getMenuData")
            getMenuData()
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data,_,_ in
            if let data = data {
                let decoder = JSONDecoder()
                let dataObj = try? decoder.decode(JSONMenu.self, from: data)
                if let menuList = dataObj {
                    Dish.createDishesFrom(menuItems: menuList.menu, viewContext)
                }
            }
        }.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return [NSSortDescriptor(key: "title",
                                 ascending: true,
                                  selector:
                                     #selector(NSString.localizedStandardCompare))]
    }
    
    func buildPredicate() -> NSPredicate {
        var searchPredicate: NSPredicate
        var filterPrecicate: NSPredicate
        if searchText.isEmpty {
            searchPredicate = NSPredicate(value: true)
        } else {
            searchPredicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        if selectedCategory == .none {
            filterPrecicate = NSPredicate(value: true)
        } else {
            filterPrecicate = NSPredicate(format: "dishCategory CONTAINS[cd] %@", selectedCategory.rawValue)
        }
        return NSCompoundPredicate(andPredicateWithSubpredicates: [searchPredicate, filterPrecicate])
    }
}

struct MenuBreakdownView: View {
    @Binding var selectedCategory: DishCategory
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("ORDER FOR DELIVERY!")
                    .sectionTitle()
                    .padding(.top, 25)
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    CategoryView(category: .starters, selectedCategory: $selectedCategory)
                        .onTapGesture {
                            withAnimation {
                                selectedCategory = selectedCategory == .starters ? .none : .starters
                            }
                        }
                  CategoryView(category: .mains, selectedCategory: $selectedCategory)
                        .onTapGesture {
                            withAnimation {
                                selectedCategory = selectedCategory == .mains ? .none : .mains
                            }
                        }
                  CategoryView(category: .desserts, selectedCategory: $selectedCategory)
                        .onTapGesture {
                            withAnimation {
                                selectedCategory = selectedCategory == .desserts ? .none : .desserts
                            }
                        }
                  CategoryView(category: .drinks, selectedCategory: $selectedCategory)
                        .onTapGesture {
                            withAnimation {
                                selectedCategory = selectedCategory == .drinks ? .none : .drinks
                            }
                        }
                }
            }
            Divider()
                .padding(.top, 15)
        }
    }
}

struct CategoryView: View {
    let category: DishCategory
    @Binding var selectedCategory: DishCategory
    
    var isSelected: Bool {
        category == selectedCategory
    }
    
    var body: some View {
        Text(category.rawValue.capitalized)
            .sectionCategory()
            .foregroundColor(isSelected ? .primary_yellow : .primary_green)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(isSelected ? .primary_green : .secondary_white)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
    }
}

struct MenuItemView: View {
    let dish: Dish
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(dish.title ?? "")
                .sectionTitle()
            HStack(spacing: 0) {
                VStack(alignment: .leading) {
                    Text(dish.itemDescription ?? "Empty description")
                        .paragraph()
                        
                    Text("$\(dish.price ?? "0").00" )
                        .highlight()
                        .padding(.top, 5)
                }
                .foregroundColor(.primary_green)
                Spacer()
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    Menu()
}
