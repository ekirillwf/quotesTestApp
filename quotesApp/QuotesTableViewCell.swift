//
//  QuotesTableViewCell.swift
//  quotesApp
//
//  Created by Кирилл Елсуфьев on 21.12.2022.
//

import UIKit
import SnapKit

class QuotesTableViewCell: UITableViewCell {
    
    //MARK: - Subviews
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignSystem.Fonts.regular15
        label.textColor = DesignSystem.Colors.blackColor
        label.textAlignment = .left
        
        return label
    }()

    private let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        
        return separator
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        selectionStyle = .none
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    
    func update(model: QuotesModel) {
        self.nameLabel.text = model.name
    }
    
    func setupLayout() {
        
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(-16)
        }

    }
    
}


