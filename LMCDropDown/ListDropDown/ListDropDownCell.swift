//
//  ListDropDownCell.swift
//  
//
//  Created by Andrey Buksha on 06.11.2019.
//

import UIKit

public protocol ListDropDownCellPresenting {
    var title: String { get set }
    var subtitle: String? { get set }
}

public class ListDropDownCell: UITableViewCell {
    
    private var stackView: UIStackView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    
    @objc public dynamic var cellBackgroundColor = ListDropDownDefaultAppearance.backgroundColor {
        didSet {
            if !isHighlighted && !isSelected {
                contentView.backgroundColor = cellBackgroundColor
            }
        }
    }
    @objc public dynamic var titleLabelColor = ListDropDownDefaultAppearance.primaryTextColor {
        didSet {
            titleLabel.textColor = titleLabelColor
        }
    }
    @objc public dynamic var subtitleLabelColor = ListDropDownDefaultAppearance.secondaryTextColor {
        didSet {
            subtitleLabel.textColor = subtitleLabelColor
        }
    }
    @objc public dynamic var titleLabelFont = ListDropDownDefaultAppearance.primaryTextFont {
        didSet {
            titleLabel.font = titleLabelFont
        }
    }
    @objc public dynamic var subtitleLabelFont = ListDropDownDefaultAppearance.secondaryTextFont {
        didSet {
            subtitleLabel.font = subtitleLabelFont
        }
    }
    @objc public dynamic var highlightedLabelColor = ListDropDownDefaultAppearance.highlightedLabelColor
    @objc public dynamic var selectedLabelColor = ListDropDownDefaultAppearance.selectedLabelColor
    @objc public dynamic var hightlightBackgroundColor = ListDropDownDefaultAppearance.highlightColor
    @objc public dynamic var selectionBackgroundColor = ListDropDownDefaultAppearance.selectionColor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    public override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        if highlighted {
            contentView.backgroundColor = hightlightBackgroundColor
            titleLabel.textColor = highlightedLabelColor
            subtitleLabel.textColor = highlightedLabelColor
        } else {
            contentView.backgroundColor = cellBackgroundColor
            titleLabel.textColor = titleLabelColor
            subtitleLabel.textColor = subtitleLabelColor
        }
    }
    
    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = selectionBackgroundColor
            titleLabel.textColor = selectedLabelColor
            subtitleLabel.textColor = selectedLabelColor
        } else {
            contentView.backgroundColor = cellBackgroundColor
            titleLabel.textColor = titleLabelColor
            subtitleLabel.textColor = subtitleLabelColor
        }
    }
    
    private func setup() {
        createSubviews()
        setupConstraints()
    }
    
    private func createSubviews() {
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = titleLabelColor
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = titleLabelFont
        titleLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        stackView.addArrangedSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.textColor = subtitleLabelColor
        subtitleLabel.numberOfLines = 0
        subtitleLabel.lineBreakMode = .byWordWrapping
        subtitleLabel.font = subtitleLabelFont
        stackView.addArrangedSubview(subtitleLabel)
        
        addSubview(stackView)
        sendSubviewToBack(contentView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 17),
            bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10)
        ])
    }
    
    func configure(cellPresenting: ListDropDownCellPresenting) {
        titleLabel.text = cellPresenting.title
        if let subtitle = cellPresenting.subtitle {
            subtitleLabel.isHidden = false
            subtitleLabel.text = subtitle
        } else {
            subtitleLabel.isHidden = true
        }
    }
    
}
