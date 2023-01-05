//
//  CategoryCollectionCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 3.01.2023.
//

import UIKit


class CategoryCollectionCell: UICollectionViewCell {
    
    //MARK: - Creating UI Elements
    
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    //MARK: - Cell's Identifier
    
    static let identifier = "CategoryCollectionCell"
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
        
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureCell
    
    func configure(data: Categories, indexPath: IndexPath) {
        categoryLabel.text = data[indexPath.row]
    }

  

    //MARK: - UI Elements Constraints
    
    private func addSubview() {
        addSubview(categoryLabel)

    }
    
    private func setupConstraints() {
        categoryLabelConstraints()
    }

    private func categoryLabelConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.height.equalTo(safeAreaLayoutGuide.snp.height)
            make.width.equalTo(safeAreaLayoutGuide.snp.width)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(safeAreaLayoutGuide.snp.centerY)
        }
    }
    
}
