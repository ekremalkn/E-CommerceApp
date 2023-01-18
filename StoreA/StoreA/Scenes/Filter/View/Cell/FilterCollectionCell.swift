//
//  FilterCollectionCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit

final class FilterCollectionCell: UICollectionViewCell {
    
    deinit {
        print("deinit FilterTableViewCell")
    }
    
    
    //MARK: - Cell's Identifier
    
    static let identifier = "FilterTableViewCell"
    
    //MARK: - Creating UI Elements
    
    private var labelView = CustomView(backgroundColor: .white, cornerRadius: 20)
    private var categoryLabel = CustomLabel(text: "", numberOfLines: 0, font: .boldSystemFont(ofSize: 20), textColor: .black, textAlignment: .center)
    
    override var isSelected: Bool {
        didSet {
            self.labelView.backgroundColor = isSelected ? UIColor.black : UIColor.clear
            self.categoryLabel.textColor = isSelected ? UIColor.white : UIColor.black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 20
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
    
}


extension FilterCollectionCell {
    
    //MARK: - Addsubview
    
    private func addSubview() {
        addSubview(labelView)
        addCategoryLabelToView()
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        labelViewConstraints()
        categoryLabelConstraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func labelViewConstraints() {
        labelView.snp.makeConstraints { make in
            make.width.equalTo(categoryLabel.snp.width).offset(30)
            make.height.equalTo(categoryLabel.snp.height).offset(15)
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
