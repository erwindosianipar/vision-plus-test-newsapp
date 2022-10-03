//
//  UICollectionViewFlowLayout+Helper.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

enum UICollectionViewFlowLayoutRowType {
    case news
    case slideshow
}

extension CGSize {
    
    static var newsCardItemSize: CGSize {
        let item = DeviceInformation.screenWidth
        return CGSize(width: item - 40, height: (item / 2 - 40) + 80)
    }
    
    static var slideshowItemSize: CGSize {
        let item = DeviceInformation.screenWidth / 3 - 50
        return CGSize(width: item, height: item)
    }
}

extension UIEdgeInsets {
    
    static var defaultEdgeInset: UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
    }
}

extension UICollectionViewFlowLayout {
    
    static func getLayout(type: UICollectionViewFlowLayoutRowType) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        switch type {
        case .news:
            layout.itemSize = .newsCardItemSize
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 10
            layout.sectionInset = .defaultEdgeInset
        case .slideshow:
            layout.itemSize = .slideshowItemSize
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 5
            layout.sectionInset = .zero
        }
        return layout
    }
}
