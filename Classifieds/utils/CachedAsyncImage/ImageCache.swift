//
//  ImageCache.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import SwiftUI

// MARK: - Image Cache

/// interface to implement/test custom caching
protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()
    
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set {
            if newValue == nil {
                cache.removeObject(forKey: key as NSURL)
            } else {
                cache.setObject(newValue!, forKey: key as NSURL)
            }
        }
    }
}

// MARK: - SwiftUI Environment

struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
