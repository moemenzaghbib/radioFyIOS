//
//  RadioModel.swift
//  RadioFy
//
//  Created by imen ben fredj on 5/5/2023.
//

import Foundation

struct RadioModel: Codable, Identifiable {
    let id = UUID()
    public var name: String
    public var imageUrl: String
    public var streamUrl: String
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case streamUrl = "url"
        case imageUrl = "img"
    }
}
