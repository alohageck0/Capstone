//
//  Images.swift
//  Capstone
//
//  Created by Evgenii Iavorovich on 5/31/24.
//

import SwiftUI

import Foundation

class BundleIdentifier { }

public let bundle = Bundle(for: BundleIdentifier.self)

public extension Image {
    static let logo = Image("Logo", bundle: bundle)
}

//public extension UIImage {
//    static func resource(named name: String) -> UIImage {
//        guard let image = UIImage(named: name) else {
//            return UIImage()
//        }
//        return image
//    }
//}
