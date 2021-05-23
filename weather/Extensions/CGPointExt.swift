//
//  CGPointExt.swift
//  weather
//
//  Created by alex on 10.05.2021.
//

import UIKit

extension CGPoint {
    func adding(x: CGFloat) -> CGPoint { return CGPoint(x: self.x + x, y: self.y) }
    func adding(y: CGFloat) -> CGPoint { return CGPoint(x: self.x, y: self.y + y) }
}
