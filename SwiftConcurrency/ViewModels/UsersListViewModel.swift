//
//  UsersListViewModel.swift
//  SwiftConcurrency
//
//  Created by Roel Castano on 1/25/23.
//

import Foundation

class UsersListViewModel: ObservableObject {
    @Published var usersAndPosts: [UserAndPosts] = []
    @Published var users: [User] = [] // ONLY USED BY fetchUsersWithCompletion()
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func fetchUsers() async {
        let usersApiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        let postsApiService = APIService(urlString: "https://jsonplaceholder.typicode.com/posts")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            async let users: [User] = try await usersApiService.getJSON()
            async let posts: [Post] = try await postsApiService.getJSON()
            let (fetchedUsers, fetchedPosts) = await (try users, try posts)
            
            for user in fetchedUsers {
                let userPosts = fetchedPosts.filter { $0.userId == user.id }
                usersAndPosts.append(UserAndPosts(user: user, posts: userPosts))
            }
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contant the developer and provide this error and the steps to reproduce"
        }
    }
    
    func fetchUsersWithCompletion() async {
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users")
        isLoading.toggle()
        apiService.getJSON { (result: Result<[User], APIError>) in
            defer {
                DispatchQueue.main.async {
                    self.isLoading.toggle()
                }
            }
            switch result {
            case .success(let users):
                DispatchQueue.main.async {
                    self.users = users
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.errorMessage = error.localizedDescription + "\nPlease contant the developer and provide this error and the steps to reproduce"
                }
            }
        }
    }
}

extension UsersListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.users = User.mockUsers
            self.usersAndPosts = UserAndPosts.mockUserAndPosts
        }
    }
}
