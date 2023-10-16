//
//  PostModel.swift
//  RestApp
//
//  Created by Sofa on 15.10.23.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let body: String?
}

struct Comments: Codable {
    let postId: Int
    let id: Int
    let name: String?
    let email: String?
    let body: String?
}
