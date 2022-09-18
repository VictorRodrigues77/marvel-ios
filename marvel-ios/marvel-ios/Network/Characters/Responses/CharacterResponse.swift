//
//  CharacterResponse.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation

struct CharacterResponse: Codable {
    let code: Int
    let status: String
    let data: CharacterData
    
    struct CharacterData: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Character]
    }
}

struct Character: Codable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: CharacterThumbnail
    
    struct CharacterThumbnail: Codable {
        let path: String
        let pathExt: String
        
        private enum CodingKeys: String, CodingKey {
            case path = "path"
            case pathExt = "extension"
        }
    }
    
    func getImage() -> URL {
        return URL(string: "\(thumbnail.path).\(thumbnail.pathExt)")!
    }
}
