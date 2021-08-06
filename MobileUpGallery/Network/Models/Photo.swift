//
//  Photo.swift
//  MobileUpGallery
//
//  Created by Andrey Komarov on 8/5/21.
//

import Foundation

struct Photo: Decodable {
    let date: Double
    let info: [PhotoInfo]
    
    var biggestImage: PhotoInfo {
        var biggestWidth = 0
        var idx = 0
        for i in 0..<info.count where info[i].width > biggestWidth {
            biggestWidth = info[i].width
            idx = i
        }
        return info[idx]
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.date = try container.decode(Double.self, forKey: .date)
        self.info = try container.decode([PhotoInfo].self, forKey: .info)
    }
    
    enum CodingKeys: String, CodingKey {
        case date
        case info = "sizes"
    }
}
