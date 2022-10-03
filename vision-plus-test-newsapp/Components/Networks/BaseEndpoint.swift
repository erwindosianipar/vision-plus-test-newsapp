//
//  BaseEndpoint.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

protocol Endpoint {
    var base: String { get }
    var method: String { get }
    var path: String { get }
}
