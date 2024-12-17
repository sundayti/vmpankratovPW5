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

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
