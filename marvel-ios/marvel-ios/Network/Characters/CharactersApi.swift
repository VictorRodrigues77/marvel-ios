//
//  CharactersApi.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation
import Moya

public enum CharactersApi {
    case characters(offset: Int)
}

extension CharactersApi: TargetType {
    public var baseURL: URL {
        guard let url = URL(string: NetworkCommon.baseUrl) else { fatalError() }
        return url
    }
    
    public var path: String {
        return "/v1/public/characters"
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        switch self {
        case .characters(let offset):
            return .requestParameters(
                parameters: [
                    "apikey": "70143c128615d2fc6f9ec748e22b2aba",
                    "hash": "3eb878f9d65c26f243e5c23352812d86",
                    "offset": offset,
                    "ts": 1
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
}
