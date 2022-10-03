//
//  NewsCardCollectionViewCell.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

internal final class NewsCardCollectionViewCell: UICollectionViewCell, SkeletonView {
    
    private let thumbnailImageView = UIImageView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
    }
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 19, weight: .bold)
    }
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .regular)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.image = nil
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
    }
    
    private func commonInit() {
        self.contentView.addSubviews(
            thumbnailImageView,
            titleLabel,
            descriptionLabel
        )
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.width.equalTo(DeviceInformation.screenWidth)
            $0.height.equalTo(DeviceInformation.screenWidth / 2 - 40)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        showSkeleton()
    }
    
    func configure(data: NewsResponseModel, completion: (() -> Void)?) {
        thumbnailImageView.loadImage(url: data.contentThumbnail, completion: completion)
        titleLabel.text = data.title.capitalized
        descriptionLabel.text = "\(data.contributorName) at \(data.createdAt.dateFormat(from: .miliSeconds, to: .humanTime))"
        hideSkeleton()
    }
}
