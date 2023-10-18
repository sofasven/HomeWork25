//
//  ToDoModel.swift
//  RestApp
//
//  Created by Sofa on 15.10.23.
//

import Foundation

struct ToDos: Codable {
    let userId: Int
    let id: Int
    let title: String?
    let completed: Bool?
}

