//
//  MockData.swift
//  SwiftConcurrency
//
//  Created by Roel Castano on 1/25/23.
//

import Foundation

extension User {
    static var mockUsers: [User] {
        Bundle.main.decode([User].self, from: "users.json")
    }
    static var mockSingleUser: User {
        self.mockUsers[0]
    }
}

extension Post {
    static var mockPosts: [Post] {
        Bundle.main.decode([Post].self, from: "posts.json")
    }
    static var mockSinglePost: Post {
        self.mockPosts[0]
    }
    static var mockSingleUsersPostsArray: [Post] {
        self.mockPosts.filter { $0.userId == 1 }
    }
}

extension UserAndPosts {
    
    static var mockUserAndPosts: [UserAndPosts] {
        var userAndPosts: [UserAndPosts] = []
        for user in User.mockUsers {
            let userPosts = Post.mockPosts.filter { $0.userId == user.id }
            let newUserAndPosts = UserAndPosts(user: user, posts: userPosts)
            userAndPosts.append(newUserAndPosts)
        }
        return userAndPosts
    }
}
