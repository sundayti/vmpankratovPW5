//
//  vmpankratovPW5Tests.swift
//  vmpankratovPW5Tests
//
//  Created by Tom Tim on 18.12.2024.
//

import XCTest
@testable import vmpankratovPW5

class NewsWorkerMock: NewsWorker {
    var shouldFail = false
    override func fetchNews(rubric: Int, pageIndex: Int, completion: @escaping (Result<[ArticleModel], Error>) -> Void) {
        if shouldFail {
            completion(.failure(NSError(domain: "TestError", code: -1, userInfo: nil)))
        } else {
            let testArticle = ArticleModel(newsId: 1, title: "Test Title", announce: "Test Announce", img: nil, requestId: nil)
            completion(.success([testArticle]))
        }
    }
}

class NewsPresenterSpy: NewsPresentationLogic {
    var presentNewsCalled = false
    var lastResponse: News.Load.Response?
    
    func presentNews(_ response: News.Load.Response) {
        presentNewsCalled = true
        lastResponse = response
    }
}

final class NewsInteractorTests: XCTestCase {
    var interactor: NewsInteractor!
    var presenter: NewsPresenterSpy!
    var worker: NewsWorkerMock!
    
    override func setUp() {
        super.setUp()
        presenter = NewsPresenterSpy()
        worker = NewsWorkerMock()
        interactor = NewsInteractor()
        interactor.presenter = presenter
        interactor.worker = worker
    }
    
    override func tearDown() {
        interactor = nil
        presenter = nil
        worker = nil
        super.tearDown()
    }
    
    func testLoadNewsSuccess() {
        interactor.loadNews(News.Load.Request(rubricId: 4, pageIndex: 1))
        XCTAssertTrue(presenter.presentNewsCalled, "Presenter was not invoked on a successful download")
        XCTAssertEqual(presenter.lastResponse?.articles.count, 1)
        XCTAssertEqual(presenter.lastResponse?.articles.first?.title, "Test Title")
    }
    
    func testLoadNewsFailure() {
        worker.shouldFail = true
        interactor.loadNews(News.Load.Request(rubricId: 4, pageIndex: 1))
        
        XCTAssertFalse(presenter.presentNewsCalled, "PresentNews should not be called when an error occurs")
    }
}
