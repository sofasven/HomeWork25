//
//  AlbumModel.swift
//  RestApp
//
//  Created by Sofa on 15.10.23.
//

import Foundation

struct Album: Codable {
    let userId: Int
    let id: Int
    let title: String?
}
