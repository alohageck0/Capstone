//
//  Text+Extensions.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 6/5/24.
//

import SwiftUI

public extension Text {
    private func customStyle(name: String, size: CGFloat, weight: Font.Weight = .regular, kern: CGFloat = 0.5) -> some View {
        let font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        return self
            .font(Font(font).weight(weight))
            .kerning(size / 100 * kern)
    }
    
    func display() -> some View {
        return customStyle(name: Font.Merkazi.regular, size: 64, weight: .medium)
    }
    
    func regular() -> some View {
        return customStyle(name: Font.Merkazi.regular, size: 40, weight: .regular)
    }
    
    func sectionTitle() -> some View {
        return customStyle(name: Font.Karla.regular, size: 20, weight: .bold)
    }
}

public extension Font {
    struct Merkazi {
        public static let regular = "MarkaziText-Regular"
    }
    
    struct Karla {
        public static let regular = "Karla-Regular"
    }
}
