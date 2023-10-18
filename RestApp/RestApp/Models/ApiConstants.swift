//
//  ApiConstants.swift
//  RestApp
//
//  Created by Sofa on 11.10.23.
//

import Foundation

struct ApiConstants {
    
    /// Local server path
    static let serverPath = "http://localhost:3000/"
    /// Users
    static let usersPath = serverPath + "users"
    static let usersURL = URL(string: usersPath)
    /// Posts
    static let postsPath = serverPath + "posts"
    static let postsURL = URL(string: postsPath)
    /// Comments
    static let commentsPath = serverPath + "comments"
    static let commentsURL = URL(string: commentsPath)
    /// ToDo-s
    static let toDosPath = serverPath + "todos"
    static let toDosURL = URL(string: toDosPath)
    /// Albums
    static let albumPath = serverPath + "albums"
    static let albumURL = URL(string: albumPath)
    /// Photos
    static let photosPath = serverPath + "photos"
    static let photosURL = URL(string: photosPath)
}
