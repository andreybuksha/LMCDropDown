//
//  ListDropDownView.swift
//  
//
//  Created by Andrey Buksha on 06.11.2019.
//

import UIKit

protocol ListDropDownViewDelegate: AnyObject {
    func didSelect(item: ListDropDownCellPresenting, at index: Int)
}

public class ListDropDownView: UIView {
    
    @objc public dynamic var listBackgroundColor = ListDropDownDefaultAppearance.backgroundColor {
        didSet {
            tableView.backgroundColor = listBackgroundColor
        }
    }
    
    private var tableView: UITableView!
    var dropDownRows: [ListDropDownCellPresenting]? {
        didSet {
            tableView.reloadData()
            invalidateIntrinsicContentSize()
        }
    }
    weak var delegate: ListDropDownViewDelegate?
    var maximumHeight: CGFloat?
    
    @objc public dynamic var rowSeparatorStyle: UITableViewCell.SeparatorStyle = .none {
        didSet {
            tableView.separatorStyle = rowSeparatorStyle
        }
    }
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        invalidateIntrinsicContentSize()
    }
    
    private func setup() {
        createSubviews()
        setupConstraints()
    }
    
    private func createSubviews() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedRowHeight = 40
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = rowSeparatorStyle
        addSubview(tableView)
        tableView.register(ListDropDownCell.self, forCellReuseIdentifier: String(describing: ListDropDownCell.self))
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            bottomAnchor.constraint(equalTo: tableView.bottomAnchor)
        ])
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = tableView.contentSize
        if let maximumHeight = maximumHeight, size.height > maximumHeight {
            return CGSize(width: size.width, height: maximumHeight)
        } else {
            return size
        }
    }
    
}

extension ListDropDownView: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dropDownRows?.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListDropDownCell.self),
                                                       for: indexPath) as? ListDropDownCell else {
                                                        fatalError("Could not dequeue cell of class ListDropDownCell")
        }
        if let row = dropDownRows?[indexPath.row] {
            cell.configure(cellPresenting: row)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = dropDownRows?[indexPath.row] {
            delegate?.didSelect(item: item, at: indexPath.row)
        }
    }
    
}
