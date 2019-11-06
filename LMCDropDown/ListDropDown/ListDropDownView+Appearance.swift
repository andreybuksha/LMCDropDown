//
//  ListDropDownView+Appearance.swift
//  
//
//  Created by Andrey Buksha on 06.11.2019.
//

import UIKit

struct ListDropDownDefaultAppearance {
    static var primaryTextColor: UIColor {
        if #available(iOS 13, *) {
            return .label
        } else {
            return .black
        }
    }
    static var secondaryTextColor: UIColor {
        if #available(iOS 13, *) {
            return .secondaryLabel
        } else {
            return .lightGray
        }
    }
    static let highlightColor: UIColor = .blue
    static let highlightedLabelColor: UIColor = .white
    static var backgroundColor: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    static let selectionColor: UIColor = .blue
    static let selectedLabelColor: UIColor = .white
    static let primaryTextFont: UIFont = .systemFont(ofSize: 14)
    static let secondaryTextFont: UIFont = .italicSystemFont(ofSize: 13)
}


