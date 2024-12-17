//
//  ArticleDetailViewController.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import UIKit
import WebKit

final class ArticleDetailViewController: UIViewController {
    var articleURL: URL?
    private let webView = WKWebView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupWebView()
        
        if let url = articleURL {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    private func setupWebView() {
        view.addSubview(webView)
        
        webView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
        webView.pinLeft(to: view.leadingAnchor)
        webView.pinRight(to: view.trailingAnchor)
        webView.pinBottom(to: view.bottomAnchor)
    }
}
