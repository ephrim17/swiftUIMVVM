//
//  UserViewModel.swift
//  SwiftMVVM
//
//  Created by Ephrim Daniel on 13/11/24.
//

import Foundation

@MainActor
class UserViewModel: ObservableObject {
    
    @Published var users : [User]?
    
    func fetchUsers() async {
        do {
            self.users = try await WebService.getData(type: User.self)
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
