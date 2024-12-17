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

protocol NewsPresentationLogic {
    func presentNews(_ response: News.Load.Response)
}

protocol NewsDisplayLogic: AnyObject {
    func displayNews(_ viewModel: News.Load.ViewModel)
}

protocol NewsRoutingLogic {
    func routeToArticleDetail(with article: ArticleModel)
}

protocol NewsDataPassing {
    var dataStore: NewsDataStore? { get }
}
