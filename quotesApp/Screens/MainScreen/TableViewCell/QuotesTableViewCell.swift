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
    
    private let changingPercantageLabel: CustomLabel = {
        let label = CustomLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = DesignSystem.Fonts.regular24
        label.textColor = DesignSystem.Colors.blackColor
        label.textAlignment = .left
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        
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
        setupName(model: model)
        setupDesc(model: model)
        setupPercantage(model: model)
        setupChangingLastDeal(model: model)
    }
    
    func setupName(model: QuotesModel) {
        if let name = model.name {
            self.nameLabel.text = name
        }
    }
    
    func setupDesc(model: QuotesModel) {
        if let descLastFirst = model.descLastActive.0 {
            if let descLastSecond = model.descLastActive.1 {
                self.descLabel.text = descLastFirst + " | " + descLastSecond
            } else {
                self.descLabel.text = descLastFirst
            }
        }
    }
    
    func setupPercantage(model: QuotesModel) {
        if let changingPercantage = model.changingPercantage {
            self.changingPercantageLabel.textColor = changingPercantage >= 0
            ? DesignSystem.Colors.greenColor
            : DesignSystem.Colors.redColor
            
            self.changingPercantageLabel.text = changingPercantage > 0 ? " +\(changingPercantage)% " : " \(changingPercantage)% "
            
            self.changingPercantageLabel.textWillChange = { (oldPercentage) in
                
                self.changingPercantageLabel.textColor = DesignSystem.Colors.whiteColor

                self.changingPercantageLabel.textDidChange = { (newPercentage) in

                    if newPercentage ?? "" > oldPercentage ?? "" {
                        self.changingPercantageLabel.backgroundColor = DesignSystem.Colors.greenColor

                    } else {
                        self.changingPercantageLabel.backgroundColor = DesignSystem.Colors.redColor
                    }
                }
            }
        }
    }
    
    func setupChangingLastDeal(model: QuotesModel) {
        if let changingLastDealFirst = model.changingLastDeal.0 {
            if let changingLastDealSecond = model.changingLastDeal.1 {
                
                let editedChangingLastDealSecond = changingLastDealSecond > 0
                ? "+\(changingLastDealSecond)"
                : "\(changingLastDealSecond)"
                
                self.changingLastDealLabel.text = "\(changingLastDealFirst) (\(editedChangingLastDealSecond))"

                
            } else {
                self.changingLastDealLabel.text = "\(changingLastDealFirst)"
            }
        }
    }
    
    func setupLayout() {
        
        [nameLabel, changingPercantageLabel, separatorView].forEach(contentView.addSubview)
        
        let bottomStackView = UIStackView(arrangedSubviews: [descLabel, changingLastDealLabel])
        bottomStackView.axis = .horizontal
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.spacing = 8
        bottomStackView.distribution = .equalSpacing
        
        contentView.addSubview(bottomStackView)
        
        nameLabel.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().inset(16)
            make.trailing.equalTo(changingPercantageLabel).offset(-16)
        }
        
        changingPercantageLabel.snp.makeConstraints{ (make) in
            make.top.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        bottomStackView.snp.makeConstraints{ (make) in
            make.top.equalTo(nameLabel).inset(40)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        separatorView.snp.makeConstraints { (make) in
            make.top.equalTo(descLabel.snp_bottomMargin).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}



