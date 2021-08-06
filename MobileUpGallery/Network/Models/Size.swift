//
//  Sizes.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation

struct Size: Decodable {
    let height: Int
    let width: Int
    let url: String
    let type: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.height = try container.decode(Int.self, forKey: .height)
        self.width = try container.decode(Int.self, forKey: .width)
        self.url = try container.decode(String.self, forKey: .url)
        self.type = try container.decode(String.self, forKey: .type)
    }
    
    enum CodingKeys: String, CodingKey {
        case height = "height"
        case width = "width"
        case url = "url"
        case type = "type"
    }
}
