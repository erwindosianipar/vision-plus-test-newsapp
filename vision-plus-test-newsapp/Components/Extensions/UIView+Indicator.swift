//
//  UIView+Indicator.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import UIKit

extension UIView {
    
    func toggleLoadingIndicator(_ onCurrentViewController: Bool = false) {
        DispatchQueue.main.async {
            if onCurrentViewController, let indicator = self.viewWithTag(99999) {
                indicator.removeFromSuperview()
                return
            }
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            if appDelegate.window?.viewWithTag(99999) != nil {
                guard let indicator = appDelegate.window?.viewWithTag(99999) else {
                    return
                }
                indicator.removeFromSuperview()
                return
            }
            
            let indicator = UIActivityIndicatorView(style: .large).then {
                $0.startAnimating()
            }
            let layer = UIView().then {
                $0.backgroundColor = .black.withAlphaComponent(0.2)
                $0.tag = 99999
                $0.addSubview(indicator)
                indicator.snp.makeConstraints {
                    $0.centerX.centerY.equalToSuperview()
                }
            }
            if onCurrentViewController {
                self.addSubview(layer)
                layer.snp.makeConstraints {
                    $0.top.left.right.bottom.equalToSuperview()
                }
                return
            }
            appDelegate.window?.addSubview(layer)
            layer.snp.makeConstraints {
                $0.top.left.right.bottom.equalToSuperview()
            }
        }
    }
}
