//
//  User.swift
//  SwiftConcurrency
//
//  Created by Roel Castano on 1/25/23.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
