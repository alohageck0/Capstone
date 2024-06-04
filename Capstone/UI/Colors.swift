//
//  Colors.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 5/31/24.
//

import SwiftUI

public extension ShapeStyle where Self == Color {
    static var primary_green: Color { Color.primary_green }
    static var primary_yellow: Color { Color.primary_yellow }
    static var secondary_orange: Color { Color.secondary_orange }
    static var secondary_beige: Color { Color.secondary_beige }
    static var secondary_white: Color { Color.secondary_white }
    static var secondary_black: Color { Color.secondary_black }
}

public extension Color {
    static let primary_green = Color("Primary", bundle: bundle)
    static let primary_yellow = Color("Primary2", bundle: bundle)
    static let secondary_orange = Color("Secondary1", bundle: bundle)
    static let secondary_beige = Color("Secondary2", bundle: bundle)
    static let secondary_white = Color("Secondary3", bundle: bundle)
    static let secondary_black = Color("Secondary4", bundle: bundle)
}
