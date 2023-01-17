//
//  RoundedShape.swift
//  Agenda
//
//  Created by Apps2T on 17/1/23.
//

import Foundation
import SwiftUI

struct RoundedShape: Shape {
    var corner: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corner, cornerRadii: CGSize(width: 80, height: 80))
        
        return Path(path.cgPath)
    }
}

