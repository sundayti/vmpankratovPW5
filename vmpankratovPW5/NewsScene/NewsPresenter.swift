//
//  NewsPresenter.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import Foundation
final class NewsPresenter: NewsPresentationLogic {
    weak var viewController: NewsDisplayLogic?
    
    func presentNews(_ response: News.Load.Response) {
        let displayArticles = response.articles.map {
            DisplayArticle(title: $0.title ?? "",
                           description: $0.announce ?? "",
                           imageURL: $0.img?.url)
        }
        let viewModel = News.Load.ViewModel(displayArticles: displayArticles)
        viewController?.displayNews(viewModel)
    }
}
