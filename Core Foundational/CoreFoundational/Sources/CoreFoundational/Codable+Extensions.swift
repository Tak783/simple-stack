//
//  Codable+Extensions.swift
//  CoreFoundational
//
//  Created by Takomborerwa Mazarura on 10/04/2021.
//

import Foundation

public extension JSONDecoder {
    convenience init(with dateDecodingFormatter: DateFormatter) {
        self.init()
        dateDecodingStrategy = .formatted(dateDecodingFormatter)
    }
}

public extension JSONEncoder {
    convenience init(with dateEncodingFormatter: DateFormatter) {
        self.init()
        dateEncodingStrategy = .formatted(dateEncodingFormatter)
    }
}
