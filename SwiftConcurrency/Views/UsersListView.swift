//
//  UsersListView.swift
//  SwiftConcurrency
//
//  Created by Roel Castano on 1/25/23.
//

import SwiftUI

struct UsersListView: View {
//    #warning("remove the forPreview argument or set to false before uploading to App Store")
    @StateObject var vm = UsersListViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(vm.usersAndPosts) { userAndPosts in
                    NavigationLink {
                        PostsListView(posts: userAndPosts.posts)
                    } label: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(userAndPosts.user.name)
                                    .font(.title)
                                Spacer()
                                Text("(\(userAndPosts.numberOfPosts))")
                            }
                            Text(userAndPosts.user.email)
                        }
                    }
                }
            }
            .overlay(content: {
                if vm.isLoading {
                    ProgressView()
                }
            })
            .alert("Application Error", isPresented: $vm.showAlert, actions: {
                Button("OK") {}
            }, message: {
                if let errorMessage = vm.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("Users")
            .listStyle(.plain)
            .task {
                await vm.fetchUsers()
            }
        }
    }
}

struct UsersListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
