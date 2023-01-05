//
//  OnboardingController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 30.12.2022.
//

import UIKit
import SnapKit

final class OnboardingController: UIViewController {
    
    //MARK: - Properties
    
    private let onboardingView = OnboardingView()
    
    //MARK: -  ViewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    //MARK: - ConfigureViewController
    
    private func configureViewController() {
        view = onboardingView
        onboardingView.interface = self
    }
}









