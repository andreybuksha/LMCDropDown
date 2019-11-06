//
//  DropDownContentViewController.swift
//  LMCDropDown
//
//  Created by Andrey Buksha on 24.10.2019.
//  Copyright © 2019 Andrey Buksha. All rights reserved.
//

import UIKit

public class DropDownContentViewController<T: UIView>: UIViewController {
    
    public var contentView: T
    private var anchorView: UIView
    
    public init(with parentController: UIViewController, contentView: T, anchorView: UIView) {
        self.contentView = contentView
        self.anchorView = anchorView
        super.init(nibName: nil, bundle: nil)
        setupUI()
        view.translatesAutoresizingMaskIntoConstraints = false
        parentController.addChild(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        let dropDownView = DropDownView()
        dropDownView.delegate = self
        view = dropDownView
    }
    
    public func show(on view: UIView? = nil, animated: Bool) {
        if let view = view {
            view.addSubview(self.view)
            
            let bottomConstraint = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.view.bottomAnchor,
                                                                constant: 20)
            bottomConstraint.priority = .required
            
            let topRelativeConstraint = self.view.topAnchor.constraint(equalTo: anchorView.topAnchor)
            topRelativeConstraint.priority = .defaultHigh
            
            NSLayoutConstraint.activate([
                bottomConstraint,
                topRelativeConstraint,
                self.view.leadingAnchor.constraint(equalTo: anchorView.leadingAnchor),
                anchorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        } else if let view = anchorView.superview {
            view.addSubview(self.view)
            NSLayoutConstraint.activate([
                self.view.topAnchor.constraint(equalTo: anchorView.topAnchor),
                self.view.leadingAnchor.constraint(equalTo: anchorView.leadingAnchor),
                anchorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        }
        if animated {
            self.view.alpha = 0
        }
        addContentView()
        didMove(toParent: parent)
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.view.alpha = 1
            }
        }
    }
    
    public func hide(animated: Bool) {
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.view.alpha = 0
            }, completion: { _ in
                self.removeFromParentController()
            })
        } else {
            removeFromParentController()
        }
    }
    
    private func removeFromParentController() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    private func setupUI() {
        view.layer.shadowOpacity = 0.2
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 12
        view.layer.shadowOffset = .zero
    }
    
    private func setupContentView() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 4
    }
    
    private func addContentView() {
        setupContentView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            self.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}

extension DropDownContentViewController: DropDownViewDelegate {
    
    func didTapOutside(point: CGPoint, view: UIView) {
        hide(animated: true)
    }
    
}
