//
//  CheckoutController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 19.01.2023.
//

import UIKit

final class CheckoutController: UIViewController {

    //MARK: - Properties
    
     let checkoutView = CheckoutView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    

    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        view = checkoutView
    }


}
