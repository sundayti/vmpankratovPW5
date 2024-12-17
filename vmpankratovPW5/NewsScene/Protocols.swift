//
//  Protocols.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import Foundation

protocol NewsBusinessLogic {
    func loadNews(_ request: News.Load.Request)
}

protocol NewsDataStore {
    var articles: [ArticleModel] { get set }
}
