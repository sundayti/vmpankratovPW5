//
//  NewsRouter.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import UIKit

// MARK: - NewsRouter
final class NewsRouter: NewsRoutingLogic, NewsDataPassing {
    
    // MARK: - Properties
    weak var viewController: UIViewController?
    var dataStore: NewsDataStore?
    
    // MARK: - Routing Logic
    func routeToArticleDetail(with article: ArticleModel) {
        let detailVC = ArticleDetailViewController()
        detailVC.articleURL = article.articleUrl
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
