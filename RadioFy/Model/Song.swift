//
//  Song.swift
//  RadioFy
//
//  Created by imen ben fredj on 6/5/2023.
//

import Foundation

struct Song: Codable, Identifiable {
    public var id: Int
    public var name: String
    public var artist: String
}
