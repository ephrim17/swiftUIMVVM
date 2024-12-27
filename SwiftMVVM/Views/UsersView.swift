//
//  UsersView.swift
//  SwiftMVVM
//
//  Created by Ephrim Daniel on 13/11/24.
//

import SwiftUI

struct UsersView: View {
    
    @StateObject var usersViewModel = UserViewModel()
    
    var body: some View {
        List(usersViewModel.users ?? [], id: \.id) { user in
            VStack(alignment: .leading) {
                Text(user.login?.capitalized ?? "")
                    .font(.headline)
                Text(user.url ?? "")
                    .font(.subheadline)
            }
        }
        .task {
            await usersViewModel.fetchUsers()
            usersViewModel.fireApiCall()
        }
    }
    
}

#Preview {
    UsersView()
}
