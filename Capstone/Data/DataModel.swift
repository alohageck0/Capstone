//
//  Data.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/10/24.
//

import Foundation

struct JSONMenu: Codable {
    let menu: [MenuItem]
}


struct MenuItem: Codable, Identifiable {
    var id: Int
    let title: String
    let price: String
    let description: String
    let image: String
}
