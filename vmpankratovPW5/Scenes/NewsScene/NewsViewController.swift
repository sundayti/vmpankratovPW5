//
//  NewsViewController.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import UIKit

// MARK: - NewsViewController
final class NewsViewController: UIViewController, NewsDisplayLogic {
    
    // MARK: - Nested Types
    private enum Constants {
        static let initialRubricId: Int = 4
        static let initialPageIndex: Int = 1
        static let newsCellIdentifier: String = "NewsCell"
        static let shareActionTitle: String = "Share"
        static let navigationBarBackgroundColor: UIColor = .white
        static let refreshControlTintColor: UIColor = .black
        static let tableViewBackgroundColor: UIColor = .white
        static let viewBackgroundColor: UIColor = .white
        static let shareActionBackgroundColor:UIColor = .systemBlue
        static let viewNextTitle: String = "Next"
        static let viewPreviousTitle: String = "Prev"
    }
    
    // MARK: - Properties
    var interactor: (NewsBusinessLogic & NewsDataStore)?
    var router: (NewsRoutingLogic & NewsDataPassing)?
    
    private let tableView = UITableView()
    private var displayArticles: [DisplayArticle] = []
    private let refreshControl = UIRefreshControl()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureRefreshControl()
        configureTableView()
        configureNavigationBar()
        view.backgroundColor = Constants.viewBackgroundColor
        interactor?.loadNews(News.Load.Request(
            rubricId: Constants.initialRubricId,
            pageIndex: Constants.initialPageIndex
        ))
    }
    
    func displayNews(_ viewModel: News.Load.ViewModel) {
        displayArticles = viewModel.displayArticles
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Private Methods
    private func configureNavigationBar() {
        let nextPageButton = UIBarButtonItem(title: Constants.viewNextTitle, style: .plain, target: self, action: #selector(loadNextPage))
        let prevPageButton = UIBarButtonItem(title: Constants.viewPreviousTitle, style: .plain, target: self, action: #selector(loadPrevPage))
        navigationItem.rightBarButtonItems = [nextPageButton, prevPageButton]
        navigationController?.navigationBar.backgroundColor = Constants.navigationBarBackgroundColor
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = Constants.refreshControlTintColor
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
    }
    
    @objc private func handleRefresh() {
        guard let interactor = interactor else { return }
        let currentPage = interactor.currentPageIndex
        interactor.loadNews(News.Load.Request(
            rubricId: Constants.initialRubricId,
            pageIndex: currentPage
        ))
    }
    
    @objc private func loadNextPage() {
        guard let interactor = interactor else { return }
        let nextPage = interactor.currentPageIndex + 1
        interactor
            .loadNews(
                News.Load.Request(
                    rubricId: Constants.initialRubricId,
                    pageIndex: nextPage
                )
            )
    }
    
    @objc private func loadPrevPage() {
        guard let interactor = interactor else { return }
        let prevPage = max(1, interactor.currentPageIndex - 1)
        interactor
            .loadNews(
                News.Load.Request(
                    rubricId: Constants.initialRubricId,
                    pageIndex: prevPage
                )
            )
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.pinTop(to: view.topAnchor)
        tableView.pinLeft(to: view.leadingAnchor)
        tableView.pinRight(to: view.trailingAnchor)
        tableView.pinBottom(to: view.bottomAnchor)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: Constants.newsCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = Constants.tableViewBackgroundColor
        tableView.refreshControl = refreshControl
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.newsCellIdentifier, for: indexPath) as! NewsCell
        let displayArticle = displayArticles[indexPath.row]
        cell.configure(with: displayArticle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let article = interactor?.articles[indexPath.row] else { return }
        router?.routeToArticleDetail(with: article)
    }
    
    // MARK: Share Action
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let shareAction = UIContextualAction(
            style: .normal,
            title: Constants.shareActionTitle
        ) { [weak self] _, _, completion in
            guard let self = self,
                  let article = self.interactor?.articles[indexPath.row],
                  let url = article.articleUrl else {
                completion(true)
                return
            }
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            self.present(activityVC, animated: true)
            completion(true)
        }
        shareAction.backgroundColor = Constants.shareActionBackgroundColor
        return UISwipeActionsConfiguration(actions: [shareAction])
    }
}
