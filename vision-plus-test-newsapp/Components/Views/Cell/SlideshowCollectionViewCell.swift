//
//  SlideshowCollectionViewCell.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 04/10/22.
//

import UIKit

internal final class SlideshowCollectionViewCell: UICollectionViewCell, SkeletonView {
    
    private let imageView = UIImageView().then {
        $0.backgroundColor = .black.withAlphaComponent(0.1)
        $0.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func commonInit() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
        showSkeleton()
    }
    
    func configure(url: String, completion: (() -> Void)?) {
        imageView.loadImage(url: url, completion: completion)
        hideSkeleton()
    }
}
