//
//  ComicResponse.swift
//  marvel-ios
//
//  Created by Victor Rodrigues on 16/09/22.
//

import Foundation

struct ComicResponse: Codable {
    let code: Int
    let status: String
    let data: ComicData
    
    struct ComicData: Codable {
        let offset: Int
        let limit: Int
        let total: Int
        let count: Int
        let results: [Comic]
    }
}

struct Comic: Codable {
    let id: Int
    let name: String
    let thumbnail: ComicThumbnail
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "title"
        case thumbnail = "thumbnail"
    }
    
    struct ComicThumbnail: Codable {
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
