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
        label.font = DesignSystem.Fonts.bold24
        label.textColor = DesignSystem.Colors.blackColor
        label.textAlignment = .left
        
        return label
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignSystem.Fonts.regular15
        label.textColor = DesignSystem.Colors.blackColor
        label.textAlignment = .left
        
        return label
    }()
    
    private let changingPercantageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignSystem.Fonts.regular24
        label.textColor = DesignSystem.Colors.blackColor
        label.textAlignment = .left
        
        return label
    }()
    
    private let changingLastDealLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignSystem.Fonts.regular15
        label.textColor = DesignSystem.Colors.blackColor
        label.textAlignment = .left
        
        return label
    }()

    private let separatorView: UIView = {
        let separator = UIView()
        separator.backgroundColor = DesignSystem.Colors.separatorColor
        
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
        if let name = model.name {
            self.nameLabel.text = name
        }
        
        if let descLastFirst = model.descLastActive.0, let descLastSecond = model.descLastActive.1 {
            self.descLabel.text = descLastFirst + " | " + descLastSecond
        }
        
        if let changingPercantage = model.changingPercantage {
            self.changingPercantageLabel.text = "\(changingPercantage)%"
            
            self.changingPercantageLabel.textColor = changingPercantage >= 0
            ? DesignSystem.Colors.greenColor
            : DesignSystem.Colors.redColor
        }
        
        if let changingLastDeal = model.changingLastDeal {
            self.changingLastDealLabel.text = "\(changingLastDeal)"
        }
    }
    
    func setupLayout() {
        
        [nameLabel, descLabel, changingPercantageLabel, separatorView, changingLastDealLabel].forEach(contentView.addSubview)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(changingPercantageLabel).offset(-16)
        }
        
        changingPercantageLabel.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        changingLastDealLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(changingPercantageLabel).inset(40)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        descLabel.snp.makeConstraints{ (make) in
            make.top.equalTo(nameLabel).offset(40)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(changingLastDealLabel).offset(-16)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp_bottomMargin).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }

    }
    
}


