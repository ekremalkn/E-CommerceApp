//
//  FilterTableViewCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit

final class FilterTableViewCell: UITableViewCell {
    
    deinit {
        print("deinit FilterTableViewCell")
    }
    
    
    //MARK: - Cell's Identifier
    
    static let identifier = "FilterTableViewCell"
    
    //MARK: - Creating UI Elements
    
    let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension FilterTableViewCell {
    
    //MARK: - Addsubview
    
    private func addSubview() {
        addSubview(categoryTitleLabel)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        categoryTitleLabelConstraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func categoryTitleLabelConstraints() {
        categoryTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
        }
    }
    
    
}
