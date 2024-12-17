//
//  NewsRouter.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import Foundation
import UIKit

final class NewsRouter: NewsRoutingLogic, NewsDataPassing {
    weak var viewController: UIViewController?
    var dataStore: NewsDataStore?
    
    func routeToArticleDetail(with article: ArticleModel) {
        let detailVC = ArticleDetailViewController()
        detailVC.articleURL = article.articleUrl
        viewController?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
