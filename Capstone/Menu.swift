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
            VStack(alignment: .leading, spacing: 0) {
                Text("Little Lemon")
                    .display()
                    .foregroundColor(.primary_yellow)
                    .padding(.horizontal, 25)
                HStack(spacing: 0) {
                    VStack(alignment: .leading) {
                        Text("Chicago")
                            .regular()
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .paragraph()
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 25)
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
            
            FetchedObjects(
                predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes) { dish in
                        HStack {
                            Text(dish.title ?? "")
                            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                        }
                    }
                }
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

#Preview {
    Menu()
}
