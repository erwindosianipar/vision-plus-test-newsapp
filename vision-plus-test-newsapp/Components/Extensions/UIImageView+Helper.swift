//
//  UIImageView+Helper.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

extension UIImageView {
    
    func loadImage(url: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: url) else {
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion?()
                    }
                }
            }
        }
    }
}
