//
//  GetPhotosResponse.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation

struct GetPhotosResponse: Decodable {
    let count: Int
    let items: [Photo]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        count = try container.decode(Int.self, forKey: .count)
        items = try container.decode([Photo].self, forKey: .items)
    }

    enum CodingKeys: String, CodingKey {
        case count
        case items
    }
}
