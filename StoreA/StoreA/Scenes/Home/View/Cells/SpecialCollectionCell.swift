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
    
    private let specialImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 30
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let specialTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.textColor = .blue
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialDetailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialLabelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    //MARK: - Init Methods

    override init(frame: CGRect) {
        super.init(frame: frame)
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


//MARK: - UI

extension SpecialCollectionCell {
    
    //MARK: - AddLabelToStackView
    
    private func addSpecialLabelsToStackView() {
        specialLabelStackView.addArrangedSubview(specialTitleLabel)
        specialLabelStackView.addArrangedSubview(specialDetailLabel)
    }
    
    //MARK: - UI Elements Constraints
    
    private func addSubview() {
        addSubview(specialImage)
        addSubview(specialLabelStackView)
    }

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
