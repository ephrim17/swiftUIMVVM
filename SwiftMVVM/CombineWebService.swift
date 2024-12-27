//
//  CombineWebService.swift
//  SwiftMVVM
//
//  Created by Ephrim Daniel on 27/12/24.
//

import Foundation
import Combine

class NetworkManager {
    
    static let shared = NetworkManager()
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    func getaData <G: Codable>(type: G.Type) -> Future<[G], Error> {
        return Future<[G], Error> { [weak self] promise in
            let baseUrl = URL(string: "https://api.github.com/users")
            URLSession.shared.dataTaskPublisher(for: baseUrl!)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: [G].self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { (completion) in
                    print("<<< check")
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            print("<<< c1k")
                            promise(.failure(decodingError))
                        default:
                            print("<<< c2k")
                            promise(.failure(NetworkError.something))
                        }
                    }
                } receiveValue: { decoded in
                    promise(.success(decoded))
                }
                .store(in: &self!.cancellables)
        }
    }
}

enum NetworkError: Error {
    case responseError
    case something
}


