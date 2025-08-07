//
//  MockServer.swift
//  MockNetworking
//
//  Created by Takomborerwa Mazarura on 14/04/2021.
//

import Foundation

public final class MockServer {
    public static func loadLocalJSON(_ fileName: String, fromBundle bundle: Bundle) -> Data {
        if let filePath = bundle.path(forResource: fileName, ofType: "json") {
            do {
                let fileURL = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                return data
            } catch {
                fatalError("Mock data was not present in bundle")
            }
        }
        fatalError("Mock data was not present in bundle")
    }
}
