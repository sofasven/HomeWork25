//
//  Cache Manager.swift
//  RestApp
//
//  Created by Sofa on 23.10.23.
//

import Foundation
import Alamofire
import AlamofireImage

final class CacheManager {
    
    private init() {}
    
    static let shared = CacheManager()
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
    
}
