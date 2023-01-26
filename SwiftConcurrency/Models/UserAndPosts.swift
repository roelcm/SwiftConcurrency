//
//  UserAndPosts.swift
//  SwiftConcurrency
//
//  Created by Roel Castano on 1/25/23.
//

import Foundation

struct UserAndPosts: Identifiable {
    let id = UUID()
    var user: User
    var posts: [Post]
    var numberOfPosts: Int {
        posts.count
    }
}
