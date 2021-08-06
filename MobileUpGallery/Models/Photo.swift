//
//  Photo.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation

struct Photo: Decodable {
    let date: Double
    let sizes: [Size]
    
    var biggestSize: Size {
        var biggestWidth = 0
        var idx = 0
        for i in 0..<sizes.count {
            if sizes[i].width > biggestWidth {
                biggestWidth = sizes[i].width
                idx = i
            }
        }
        return sizes[idx]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.date = try container.decode(Double.self, forKey: .date)
        self.sizes = try container.decode([Size].self, forKey: .sizes)
    }
    
    enum CodingKeys: String, CodingKey {
        case date = "date"
        case sizes = "sizes"
    }
}
