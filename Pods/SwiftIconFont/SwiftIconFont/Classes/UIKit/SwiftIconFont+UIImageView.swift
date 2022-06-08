//
//  SwiftIconFont+UIImageView.swift
//  SwiftIconFont
//
//  Created by Sedat Gökbek ÇİFTÇİ on 13.10.2017.
//  Copyright © 2017 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

import UIKit

public extension UIImageView {
    func setIcon(from font: Fonts, code: String, textColor: Color = .black, backgroundColor: Color = .clear, size: CGSize? = nil) {
        self.image = UIImage(from: font, code: code, textColor: textColor, backgroundColor: backgroundColor, size: size ?? frame.size)
    }
}
