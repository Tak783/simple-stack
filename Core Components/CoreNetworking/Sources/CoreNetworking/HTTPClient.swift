//
//  HTTPClient.swift
//  CoreNetworking
//
//  Created by Takomborerwa Mazarura on 10/04/2021.
//
//  Client contains a .shared URLSession. We use `URLSessionDataTask`s to get, post, put etc data from a server
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func performRequest(_ request: URLRequest, completion: @escaping (Result) -> Void)
}
