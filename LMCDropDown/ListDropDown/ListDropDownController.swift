//
//  ListDropDownController.swift
//  
//
//  Created by Andrey Buksha on 06.11.2019.
//

import UIKit

public protocol ListDropDownControllerDelegate: AnyObject {
    func didSelect(item: ListDropDownCellPresenting, at index: Int)
}

public class ListDropDownController: DropDownContentViewController {
    
    public var dropDownRows: [ListDropDownCellPresenting]? {
        didSet {
            (contentView as? ListDropDownView)?.dropDownRows = dropDownRows
        }
    }
    public weak var delegate: ListDropDownControllerDelegate?
    
    public init(with viewController: UIViewController, anchorView: UIView) {
        let view = ListDropDownView()
        super.init(with: viewController, contentView: view, anchorView: anchorView)
        view.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension ListDropDownController: ListDropDownViewDelegate {
    
    func didSelect(item: ListDropDownCellPresenting, at index: Int) {
        delegate?.didSelect(item: item, at: index)
        hide(animated: true)
    }
    
}
