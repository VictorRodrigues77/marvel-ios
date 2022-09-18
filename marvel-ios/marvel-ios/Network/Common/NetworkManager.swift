//
//  NetworkManager.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation
import Moya

class NetworkManager<Target: TargetType> {
    private let provider = MoyaProvider<Target>(plugins: [NetworkLoggerPlugin()])
}

extension NetworkManager {
    func request<T: Decodable>(target: Target, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
