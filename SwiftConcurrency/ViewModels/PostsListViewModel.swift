//
//  PostsListViewModel.swift
//  SwiftConcurrency
//
//  Created by Roel Castano on 1/25/23.
//

import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var errorMessage: String?

    var userId: Int?
    
    @MainActor
    func fetchUserPosts() async {
        guard let userId = userId else {
            return
        }
        let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            posts = try await apiService.getJSON()
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription + "\nPlease contant the developer and provide this error and the steps to reproduce"
        }
    }
    
    func fetchUserPostsWithCompletion() {
        if let userId = userId {
            isLoading.toggle()
            let apiService = APIService(urlString: "https://jsonplaceholder.typicode.com/users/\(userId)/posts")
            apiService.getJSON { (result: Result<[Post], APIError>) in
                defer {
                    DispatchQueue.main.async {
                        self.isLoading.toggle()
                    }
                }
                switch result {
                case .success(let posts):
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}


extension PostsListViewModel {
    convenience init(forPreview: Bool = false) {
        self.init()
        if forPreview {
            self.posts = Post.mockSingleUsersPostsArray
        }
    }
}
