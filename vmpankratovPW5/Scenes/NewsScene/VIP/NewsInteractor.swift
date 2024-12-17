//
//  NewsInteractor.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

// MARK: - NewsInteractor
final class NewsInteractor: NewsBusinessLogic, NewsDataStore {
    
    // MARK: - Properties
    var presenter: NewsPresentationLogic?
    var worker: NewsWorker = NewsWorker()
    var articles: [ArticleModel] = []
    var currentPageIndex: Int = 0
    
    // MARK: - Business Logic
    func loadNews(_ request: News.Load.Request) {
        currentPageIndex = request.pageIndex
        worker.fetchNews(
            rubric: request.rubricId,
            pageIndex: currentPageIndex
        ) { [weak self] result in
            switch result {
            case .success(let fetchedArticles):
                self?.articles = fetchedArticles
                let response = News.Load.Response(articles: fetchedArticles)
                self?.presenter?.presentNews(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}
