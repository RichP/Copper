//
//  Font.swift
//  Copper
//
//  Created by Richard Pickup on 01/12/2021.
//

import Foundation
import SwiftUI

extension Font {
    static func copper(size: CGFloat) -> Font {
        return .custom("IBMPlexSans-Regular", size: size)
    }
    
    static func copperBold(size: CGFloat) -> Font {
        return .custom("IBMPlexSans-SemiBold", size: size)
    }
}
