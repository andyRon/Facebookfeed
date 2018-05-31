//
//  Extensions.swift
//  facebookfeed
//
//  Created by andyron<http://andyron.com> on 2018/5/31.
//  Copyright © 2018年 andyron. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictiongry = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictiongry[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictiongry))
    }
}

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
