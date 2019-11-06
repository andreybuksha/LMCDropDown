//
//  DropDownView.swift
//  LMCDropDown
//
//  Created by Andrey Buksha on 24.10.2019.
//  Copyright © 2019 Andrey Buksha. All rights reserved.
//

import UIKit

protocol DropDownViewDelegate: AnyObject {
    func didTapOutside(point: CGPoint, view: UIView)
}

class DropDownView: UIView {
    
    weak var delegate: DropDownViewDelegate?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let isInside = super.point(inside: point, with: event)
        if !isInside {
            delegate?.didTapOutside(point: point, view: self)
        }
        return isInside
    }
    
}
