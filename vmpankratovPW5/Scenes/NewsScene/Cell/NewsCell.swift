//
//  NewCell.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import UIKit

class NewsCell: UITableViewCell {
    private let articleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let shimmerLayer: ShimmerView = ShimmerView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14)
        descriptionLabel.numberOfLines = 3
        
        let stack = UIStackView(arrangedSubviews: [articleImageView, titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = 8
        contentView.addSubview(stack)
        stack.pinTop(to: contentView.topAnchor, 8)
        stack.pinBottom(to: contentView.bottomAnchor, 8)
        stack.pinLeft(to: contentView.leadingAnchor, 8)
        stack.pinRight(to: contentView.trailingAnchor, 8)
        articleImageView.setHeight(200)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with article: DisplayArticle) {
        configureShimmerView()
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        if let url = article.imageURL {
            loadImage(from: url)
        } else {
            articleImageView.image = nil
        }
    }
    
    
    private func loadImage(from url: URL) {
        if let cachedImage = ImageCache.shared.getImage(for: url as NSURL) {
            self.shimmerLayer.isHidden = true
            self.articleImageView.image = cachedImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else {return}
            guard let image = UIImage(data: data) else {return}
            
            ImageCache.shared.saveImage(image, for: url as NSURL)
            
            DispatchQueue.main.async {
                self?.shimmerLayer.isHidden = true
                self?.articleImageView.image = image
            }
        }
    }
    
    private func configureShimmerView() {
            contentView.addSubview(shimmerLayer)
            shimmerLayer.layer.cornerRadius = 10
            shimmerLayer.startAnimating()
        }
}
