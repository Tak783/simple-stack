//
//  NSObject+Extensions.swift
//  CoreFoundational
//
//  Created by Takomborerwa Mazarura on 14/04/2021.
//

import Foundation

public extension NSObject {
    var className: String {
        return "\(type(of: self))"
    }
    
    static var className: String {
        return "\(self)"
    }
}
