//
//  PostsListView.swift
//  SwiftConcurrency
//
//  Created by Roel Castano on 1/25/23.
//

import SwiftUI

struct PostsListView: View {
    // Commented code uses VM specific to Posts
    //    @ObservedObject var vm = PostsListViewModel(forPreview: true)
    var posts: [Post]

    var body: some View {
        List {
            ForEach(posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
            }
        }
//        .overlay(content: {
//            if vm.isLoading {
//                ProgressView()
//            }
//        })
//        .alert("Application Error", isPresented: $vm.showAlert, actions: {
//            Button("OK") { }
//        }, message: {
//            if let errorMessage = vm.errorMessage {
//                Text(errorMessage)
//            }
//        })
        .navigationTitle("Posts")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
//        .task {
//            vm.userId = userId
//            await vm.fetchUserPosts()
//        }
    }
}

struct PostsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostsListView(posts: Post.mockSingleUsersPostsArray)
        }
    }
}
