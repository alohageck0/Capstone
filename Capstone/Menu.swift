//
//  Menu.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/4/24.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    
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
                    TextField("Search dish", text: $searchText)
                        .textFieldStyle(.roundedBorder)
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
            MenuBreakdownView()
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
        if searchText.isEmpty {
            return NSPredicate(value: true)
        } else {
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        
    }
}

struct MenuBreakdownView: View {
    private var menuCategories = ["Starters", "Mains", "Desserts", "Drinks"]
    
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
                  CategoryView(title: "Starters")
                  CategoryView(title: "Mains")
                  CategoryView(title: "Desserts")
                  CategoryView(title: "Drinks")
                }
            }
            Divider()
                .padding(.top, 15)
        }
    }
}

struct CategoryView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .sectionCategory()
            .foregroundColor(.primary_green)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .background(.secondary_white)
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
