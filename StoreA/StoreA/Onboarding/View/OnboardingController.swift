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
    
    private func configureViewController() {
        view = onboardingView
        onboardingView.interface = self
    }
    
 
}

extension OnboardingController: OnboardingViewInterface {
    func onboardingView(_ view: OnboardingView, didTapContiuneButton button: UIButton) {
        let signUpVC = SignUpController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func onboardingView(_ view: OnboardingView, didTapSkipButton button: UIButton) {
        let signUpVC = SignUpController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func onboardingView(_ view: OnboardingView, didTapSignInButton button: UIButton) {
        let signInVC = SignInController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    
}






