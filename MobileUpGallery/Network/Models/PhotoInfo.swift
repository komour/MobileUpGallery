//
//  Sizes.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation

struct PhotoInfo: Decodable {
    let height: Int
    let width: Int
    let url: String
    let type: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        height = try container.decode(Int.self, forKey: .height)
        width = try container.decode(Int.self, forKey: .width)
        url = try container.decode(String.self, forKey: .url)
        type = try container.decode(String.self, forKey: .type)
    }

    enum CodingKeys: String, CodingKey {
        case height
        case width
        case url
        case type
    }
}
