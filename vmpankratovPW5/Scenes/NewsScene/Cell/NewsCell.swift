//
//  NewCell.swift
//  vmpankratovPW5
//
//  Created by Tom Tim on 17.12.2024.
//

import UIKit

// MARK: - NewsCell
class NewsCell: UITableViewCell {
    
    // MARK: - Constants
    private enum Constants {
        static let titleFontSize: CGFloat = 16
        static let descriptionFontSize: CGFloat = 14
        static let descriptionNumberOfLines = 3
        static let imageHeight: CGFloat = 200
        static let stackSpacing: CGFloat = 8
        static let stackPadding: CGFloat = 8
        static let shimmerCornerRadius: CGFloat = 10
    }
    
    // MARK: - UI Components
    private let articleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let shimmerLayer: ShimmerView = ShimmerView(frame: CGRect(x: 0, y: 0, width: 400, height: 200))
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
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
    
    // MARK: - Private Methods
    private func setupUI() {
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: Constants.titleFontSize)
        descriptionLabel.font = UIFont.systemFont(ofSize: Constants.descriptionFontSize)
        descriptionLabel.numberOfLines = Constants.descriptionNumberOfLines
        
        let stack = UIStackView(arrangedSubviews: [articleImageView, titleLabel, descriptionLabel])
        stack.axis = .vertical
        stack.spacing = Constants.stackSpacing
        contentView.addSubview(stack)
        
        stack.pinTop(to: contentView.topAnchor, Constants.stackPadding)
        stack.pinBottom(to: contentView.bottomAnchor, Constants.stackPadding)
        stack.pinLeft(to: contentView.leadingAnchor, Constants.stackPadding)
        stack.pinRight(to: contentView.trailingAnchor, Constants.stackPadding)
        
        articleImageView.setHeight(Constants.imageHeight)
    }
    
    private func loadImage(from url: URL) {
        if let cachedImage = ImageCache.shared.getImage(for: url as NSURL) {
            self.shimmerLayer.isHidden = true
            self.articleImageView.image = cachedImage
            return
        }
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url) else { return }
            guard let image = UIImage(data: data) else { return }
            
            ImageCache.shared.saveImage(image, for: url as NSURL)
            
            DispatchQueue.main.async {
                self?.shimmerLayer.isHidden = true
                self?.articleImageView.image = image
            }
        }
    }
    
    private func configureShimmerView() {
        contentView.addSubview(shimmerLayer)
        shimmerLayer.layer.cornerRadius = Constants.shimmerCornerRadius
        shimmerLayer.startAnimating()
    }
}
