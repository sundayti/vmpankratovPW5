//
//  ImageCache.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import UIKit

final class ImageCache {
    //MARK: - Variables
    static let shared = ImageCache()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    //MARK: - Public methods
    func getImage(for url: NSURL) -> UIImage? {
        return cache.object(forKey: url)
    }
    
    func saveImage(_ image: UIImage, for url: NSURL) {
        cache.setObject(image, forKey: url)
    }
}
