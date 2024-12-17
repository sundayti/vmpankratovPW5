//
//  NewsViewController.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import UIKit

final class NewsViewController: UIViewController, NewsDisplayLogic {
    var interactor: (NewsBusinessLogic & NewsDataStore)?
    var router: (NewsRoutingLogic & NewsDataPassing)?

    private let tableView = UITableView()
    private var displayArticles: [DisplayArticle] = []
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.pinTop(to: view.topAnchor)
        tableView.pinLeft(to: view.leadingAnchor)
        tableView.pinRight(to: view.trailingAnchor)
        tableView.pinBottom(to: view.bottomAnchor)
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let displayArticle = displayArticles[indexPath.row]
        cell.configure(with: displayArticle)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let article = interactor?.articles[indexPath.row] else { return }
        router?.routeToArticleDetail(with: article)
    }
}
