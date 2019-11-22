//
//  File.swift
//  
//
//  Created by Andrey Buksha on 22.11.2019.
//

import UIKit

public struct DropDownPresentMode {
    
    public enum VerticalPosition {
        case top
        case topOverlapped
        case bottom
        case bottomOverlapped
    }
    
    public enum WidthMode {
        case equalToAnchor
        case contentBased
        case exact(value: CGFloat)
    }
    
    public var verticalPosition: VerticalPosition
    public var widthMode: WidthMode
    public var verticalSpacing: CGFloat = 0
    
    public init(verticalPosition: VerticalPosition, widthMode: WidthMode, verticalSpacing: CGFloat = 0) {
        self.verticalPosition = verticalPosition
        self.widthMode = widthMode
        self.verticalSpacing = verticalSpacing
    }
    
}



