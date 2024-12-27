//
//  UserViewModel.swift
//  SwiftMVVM
//
//  Created by Ephrim Daniel on 13/11/24.
//

import Foundation
import Combine

@MainActor
class UserViewModel: ObservableObject {
    
    @Published var users : [User]?
    private var cancellables = Set<AnyCancellable>()
    
    func fetchUsers() async {
//        do {
//            ///self.users = try await WebService.getData(type: User.self)
//        }
//        catch{
//            print(error.localizedDescription)
//        }
    }
    
    func fireApiCall() {
        NetworkManager.shared.getaData(type: User.self)
            .sink { completion in
                switch completion {
                case .failure(let err):
                    print(err)
                case .finished:
                    print("Finished")
                }
            } receiveValue: { [weak self] users in
                self?.users = users
                print("<<< users combineWebservice")
                print(self!.users)
            }
            .store(in: &cancellables)
    }
}
