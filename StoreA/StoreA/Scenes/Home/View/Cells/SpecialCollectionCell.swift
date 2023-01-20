//
//  SpecialCollectionCell.swift
//  StoreA
//
//  Created by Ekrem Alkan on 2.01.2023.
//

import UIKit

protocol SpecialCollectionCellProtocol {
    var specialImage: String { get }
    var specialTitle: String { get }
    var specialDetail: String { get }
}

class SpecialCollectionCell: UICollectionViewCell {
  
    //MARK: - Cell's Identifier
    static let identifier = "SpecialCollectionCell"
    
    //MARK: - Creating UI Elements
    
    private var specialImage = CustomImageView(image: UIImage(systemName: "exclamationmark.circle")!, tintColor: .black, backgroundColor: .white, contentMode: .scaleAspectFit, cornerRadius: 30, isUserInteractionEnabled: false)
    private var specialTitleLabel = CustomLabel(text: "", numberOfLines: 3, font: .boldSystemFont(ofSize: 15), textColor: .black, textAlignment: .center)
    private var specialDetailLabel = CustomLabel(text: "", numberOfLines: 2, font: .systemFont(ofSize: 12), textColor: .systemGray, textAlignment: .center)
    private var specialLabelStackView = CustomStackView(axis: .vertical, distiribution: .fillEqually, spacing: 8, isHidden: false)
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 30
        addSubview()
        addSpecialLabelsToStackView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - CongifureCell
    
    func configure(data: SpecialCollectionCellProtocol) {
        specialImage.downloadSetImage(url: data.specialImage)
        specialTitleLabel.text = data.specialTitle
        specialDetailLabel.text = data.specialDetail
    }
    
}


//MARK: - UI Elements AddSubiew / Constraints

extension SpecialCollectionCell {
    
    //MARK: - Addsubview
    
    private func addSubview() {
        addSubviews(specialImage, specialLabelStackView)
    }
    
    private func addSpecialLabelsToStackView() {
        specialLabelStackView.addArrangedSubview(specialTitleLabel)
        specialLabelStackView.addArrangedSubview(specialDetailLabel)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        specialImageConstraints()
        specialLabelStackViewConstraints()
    }
    
    private func specialImageConstraints() {
        specialImage.snp.makeConstraints { make in
            make.width.equalTo(safeAreaLayoutGuide.snp.height).offset(-10)
            make.top.equalTo(safeAreaLayoutGuide).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-10)
            make.trailing.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func specialLabelStackViewConstraints() {
        specialLabelStackView.snp.makeConstraints { make in
            make.centerY.equalTo(specialImage.snp.centerY)
            make.leading.equalTo(safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(specialImage.snp.leading).offset(-20)
        }
    }
    
}
