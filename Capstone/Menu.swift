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
            Text("LittleLemon")
                .display()
            Text("Chicago")
                .sectionTitle()
            Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
            
            TextField("Search text", text: $searchText)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 50)
            
            FetchedObjects(
                predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.id) { dish in
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
        var result = URLSession.shared.dataTask(with: request) { data,_,_ in
            if let data = data {
                let decoder = JSONDecoder()
                let dataObj = try? decoder.decode(JSONMenu.self, from: data)
                if let menuList = dataObj {
                    for item in menuList.menu {
                        let dish = Dish(context: viewContext)
                        dish.image = item.image
                        dish.price = item.price
                        dish.title = item.title
                        
                    }
                    try? viewContext.save()
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
