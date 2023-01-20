//
//  OnboardingView.swift
//  StoreA
//
//  Created by Ekrem Alkan on 1.01.2023.
//

import UIKit
import SnapKit

//MARK: - OnboardingViewInterface Protocol

protocol OnboardingViewInterface: AnyObject {
    func onboardingView(_ view: OnboardingView, contiuneButtonTapped button: UIButton)
    func onboardingView(_ view: OnboardingView, skipButtonTapped button: UIButton)
    func onboardingView(_ view: OnboardingView, signInButtonTapped button: UIButton)
}

final class OnboardingView: UIView {
    
    
    //MARK: -  Creating UI Elements
    
    var collection = CustomCollection(showsScrollIndicator: false, paging: true, layout: UICollectionViewFlowLayout(), scrollDirection: .horizontal)
    private var pageControl = CustomPageControl()
    private var contiuneButton = CustomButton(title: "Contiune", titleColor: .white, font: .boldSystemFont(ofSize: 19), backgroundColor: .black, cornerRadius: 16)
    lazy var skipButton = CustomButton(title: "Skip", titleColor: .systemGray, font: .systemFont(ofSize: 15), backgroundColor: .white, cornerRadius: 16)
    private var pageControlButtonsStackView  = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 44, isHidden: false)
    lazy var signInLbl = CustomLabel(text: "Already have an account?", numberOfLines: 1, font: .systemFont(ofSize: 18), textColor: .systemGray, textAlignment: .center)
    lazy var signInButton = CustomButton(title: "Sign In", titleColor: .systemOrange, font: .systemFont(ofSize: 15), backgroundColor: .white, cornerRadius: 16)
    lazy var signInStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 10, isHidden: true)
    
    //MARK: - Properties
    
    weak var interface: OnboardingViewInterface?
    
    
    //MARK: - Onboarding Model Array
    
    var slides: [OnboardingSlide] = []
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview()
        setupConstraints()
        addSignInElementsToStackView()
        addPageControlButtonsToStackView()
        setSlides()
        pageControl.numberOfPages = slides.count
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - PageControl CurrentPage
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                skipButton.isHidden = true
                signInStackView.isHidden = false
                contiuneButton.setTitle("Sign Up", for: .normal)
            } else {
                signInStackView.isHidden = true
                skipButton.isHidden = false
                contiuneButton.setTitle("Contiune", for: .normal)
            }
        }
    }
    
    //MARK: - SetSlides
    
    func setSlides() {
        slides = [OnboardingSlide(title: "Explore Best Products", description: "Browse products and find your desire product.", image: UIImage(named: "onboardingSlide1")!),
                  OnboardingSlide(title: "Confirm Your Purchase", description: "Make the final purchase and get the quick delivery.", image: UIImage(named: "onboardingSlide2")!)]
    }
    
    
    //MARK: - Button Actions
    
    private func addTarget() {
        contiuneButton.addTarget(self, action: #selector(contiuneButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    @objc private func contiuneButtonTapped(_ button: UIButton) {
        if currentPage == slides.count - 1 {
            interface?.onboardingView(self, contiuneButtonTapped: button)
        } else {
            collection.isPagingEnabled = false
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collection.scrollToItem(at: indexPath, at: .right, animated: true)
            collection.isPagingEnabled = true
        }
    }
    
    @objc private func skipButtonTapped(_ button: UIButton) {
        interface?.onboardingView(self, skipButtonTapped: button)
    }
    
    @objc private func signInButtonTapped(_ button: UIButton) {
        interface?.onboardingView(self, signInButtonTapped: button)
    }
    
    
}


//MARK: - UI Elements AddSubiew / Constraints

extension OnboardingView {
    
    //MARK: - Addsubview
    
    private func addSubview() {
        addSubviews(collection, pageControl, contiuneButton, skipButton, pageControlButtonsStackView, signInLbl, signInButton, signInStackView)
    }
    
    private func addSignInElementsToStackView() {
        signInStackView.addArrangedSubviews(signInLbl, signInButton)
    }
    
    private func addPageControlButtonsToStackView() {
        pageControlButtonsStackView.addArrangedSubviews(pageControl, contiuneButton, skipButton)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstraints() {
        collectionConstraints()
        contiuneButtonConstraints()
        skipButtonConstraints()
        pageControlButtonStackViewConstraints()
        signInStackViewConstraints()
        
    }
    
    private func collectionConstraints() {
        collection.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height).multipliedBy(0.5)
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(safeAreaLayoutGuide)
            make.trailing.equalTo(safeAreaLayoutGuide)
            
        }
    }
    
    private func contiuneButtonConstraints() {
        contiuneButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(116)
        }
    }
    
    private func skipButtonConstraints() {
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(contiuneButton.snp.bottom).offset(35)
        }
    }
    
    private func signInStackViewConstraints() {
        signInStackView.snp.makeConstraints { make in
            make.top.equalTo(contiuneButton.snp.bottom).offset(35)
            make.centerX.equalTo(contiuneButton.snp.centerX)
        }
    }
    
    private func pageControlButtonStackViewConstraints() {
        pageControlButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(collection.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide).offset(50)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-50)
        }
    }
    
}




