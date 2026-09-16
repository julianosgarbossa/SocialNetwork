//
//  UIView + Extension.swift
//  SocialNetwork
//
//  Created by Juliano Sgarbossa on 16/09/26.
//

import UIKit

extension UIView {
    func setCardShadow() {
        layer.shadowColor = UIColor.white.withAlphaComponent(0.1).cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 8
        layer.shouldRasterize = true
        layer.masksToBounds = false
        layer.rasterizationScale = traitCollection.displayScale
    }
}
