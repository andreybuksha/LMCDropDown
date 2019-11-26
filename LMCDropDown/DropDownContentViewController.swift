//
//  DropDownContentViewController.swift
//  LMCDropDown
//
//  Created by Andrey Buksha on 24.10.2019.
//  Copyright © 2019 Andrey Buksha. All rights reserved.
//

import UIKit

public class DropDownContentViewController: UIViewController {
    
    public weak var contentView: UIView?
    public var presentMode: DropDownPresentMode = .init(verticalPosition: .bottomOverlapped, widthMode: .equalToAnchor)
    private var anchorView: UIView
    
    public init(with parentController: UIViewController, contentView: UIView, anchorView: UIView) {
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
        if let containerView = view ?? anchorView.superview {
            containerView.addSubview(self.view)
            let verticalConstraints = getVerticalConstraints(containerView: containerView)
            let horizontalConstraint = getHorizontalConstraints(containerView: containerView)
            NSLayoutConstraint.activate(verticalConstraints + horizontalConstraint)
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
        contentView?.clipsToBounds = true
        contentView?.layer.cornerRadius = 4
    }
    
    private func addContentView() {
        guard let contentView = contentView else { return }
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
    
    private func getVerticalConstraints(containerView: UIView) -> [NSLayoutConstraint] {
        switch presentMode.verticalPosition {
        case .top, .topOverlapped:
            let topConstraint = view.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor,
                                                          constant: 20)
            topConstraint.priority = .defaultHigh
            
            let bottomAnchor = presentMode.verticalPosition == .top ?
                anchorView.topAnchor :
                anchorView.bottomAnchor
            let bottomConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                           constant: presentMode.verticalSpacing)
            bottomConstraint.priority = .defaultLow
            
            return [
                topConstraint,
                bottomConstraint
            ]
        case .bottom, .bottomOverlapped:
            let topAnchor = presentMode.verticalPosition == .bottom ?
                anchorView.bottomAnchor :
                anchorView.topAnchor
            let topConstraint = view.topAnchor.constraint(equalTo: topAnchor, constant: presentMode.verticalSpacing)
            topConstraint.priority = .defaultLow
            
            let bottomConstraint = containerView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor,
                                                                         constant: 20)
            bottomConstraint.priority = .defaultHigh
            
            return [
                topConstraint,
                bottomConstraint
            ]
        }
    }
    
    private func getHorizontalConstraints(containerView: UIView) -> [NSLayoutConstraint] {
        switch presentMode.widthMode {
        case .equalToAnchor:
            return [
                view.leadingAnchor.constraint(equalTo: anchorView.leadingAnchor),
                anchorView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ]
        default:
            let centerXConstraint = view.centerXAnchor.constraint(equalTo: anchorView.centerXAnchor)
            centerXConstraint.priority = .defaultLow
            
            let leadingConstraint = view.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor,
                                                                  constant: 20)
            leadingConstraint.priority = .defaultHigh
            
            let trailingConstraint = view.trailingAnchor.constraint(greaterThanOrEqualTo: containerView.leadingAnchor,
                                                                    constant: 20)
            trailingConstraint.priority = .defaultHigh
            
            var constraints = [
                leadingConstraint,
                centerXConstraint,
                trailingConstraint
            ]
            
            if case .exact(let value) = presentMode.widthMode {
                constraints.append(view.widthAnchor.constraint(equalToConstant: value))
            }
            
            return constraints
        }
    }

}

extension DropDownContentViewController: DropDownViewDelegate {
    
    func didTapOutside(point: CGPoint, view: UIView) {
        hide(animated: true)
    }
    
}
