//
//  CategoryCollectionCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 3.01.2023.
//

import UIKit


class CategoryCollectionCell: UICollectionViewCell {
    deinit {
        print("deinit categorycell")
    }
    
    //MARK: - Cell's Identifier
    
    static let identifier = "CategoryCollectionCell"
    
    //MARK: - Creating UI Elements
    
    private var labelView = CustomView(backgroundColor: .systemGray6, cornerRadius: 14)
    private var categoryLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 14), textColor: .black, textAlignment: .center)
    
    override var isSelected: Bool {
        didSet {
            self.labelView.backgroundColor = isSelected ? UIColor.black : UIColor.clear
            self.categoryLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        layer.cornerRadius = 14
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureCell
    
    func configure(data: Categories, indexPath: IndexPath) {
        categoryLabel.text = data[indexPath.row].capitalized
    }
    
    //MARK: - Add label to View
    
    private func addCategoryLabelToView() {
        labelView.addSubview(categoryLabel)
    }
    
    
    
    
    //MARK: - UI Elements Constraints
    
    private func addSubview() {
        addSubview(labelView)
        addCategoryLabelToView()
    }
    
    private func setupConstraints() {
        labelViewConstraints()
        categoryLabelConstraints()
    }
    
    private func labelViewConstraints() {
        labelView.snp.makeConstraints { make in
            make.width.equalTo(categoryLabel.snp.width).offset(20)
            make.height.equalTo(categoryLabel.snp.height).offset(10)
            make.top.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func categoryLabelConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.centerX.equalTo(labelView.snp.centerX)
            make.centerY.equalTo(labelView.snp.centerY)
        }
    }
    
}
