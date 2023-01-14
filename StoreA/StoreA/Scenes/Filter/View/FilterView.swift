//
//  FilterView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 14.01.2023.
//

import UIKit

final class FilterView: UIView {
    
    deinit {
        print("deinit FilterView")
    }
    
    //MARK: - Creating UI Elements
    
    let filterTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        addSubview()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FilterView {
    
    //MARK: - AddSubview
    
    private func addSubview() {
        addSubview(filterTableView)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        filterTableViewConstraints()
    }
    
    //MARK: - UI Elements Constraints
    
    private func filterTableViewConstraints() {
        filterTableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-10)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}
