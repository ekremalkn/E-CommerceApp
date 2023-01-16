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
    
    lazy var collection = OnboardingCollectionView(scrollIndicator: false, paging: true, layout: UICollectionViewFlowLayout())
    lazy var pageControl = CustomPageControl()
    lazy var contiuneButton = OnboardingButton(title: "Contiune", titleColor: .white, font: .boldSystemFont(ofSize: 19), backgroundColor: .blue, cornerRadius: 16)
    lazy var skipButton = OnboardingButton(title: "Skip", titleColor: .systemGray, font: .systemFont(ofSize: 15), backgroundColor: .white, cornerRadius: 16)
    lazy var pageControlButtonsStackView  = CustomStackView(axis: .vertical, distiribution: .fill, spacing: 44, isHidden: false)
    lazy var signInLbl = CustomLabel(text: "Already have an account?", numberOfLines: 1, font: .systemFont(ofSize: 18), textColor: .systemGray, textAlignment: .center)
    lazy var signInButton = OnboardingButton(title: "Sign In", titleColor: .systemOrange, font: .systemFont(ofSize: 15), backgroundColor: .white, cornerRadius: 16)
    lazy var signInStackView = CustomStackView(axis: .horizontal, distiribution: .fill, spacing: 0, isHidden: true)
    
    //MARK: - Properties
    
    weak var interface: OnboardingViewInterface?
    
    
    //MARK: - Onboarding Model Array
    
    var slides: [OnboardingSlide] = []
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        collectionCellRegister()
        setupDelegates()
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
    
    private var currentPage = 0 {
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
    
    //MARK: - Register Custom Collection Cell
    
    private func collectionCellRegister() {
        collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
    }
    
    //MARK: - Setup Delegates
    
    private func setupDelegates() {
        collection.delegate = self
        collection.dataSource = self
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
    
    //MARK: - StackView AddSubview
    
    private func addSignInElementsToStackView() {
        signInStackView.addArrangedSubview(signInLbl)
        signInStackView.addArrangedSubview(signInButton)
    }
    
    private func addPageControlButtonsToStackView() {
        pageControlButtonsStackView.addArrangedSubview(pageControl)
        pageControlButtonsStackView.addArrangedSubview(contiuneButton)
        pageControlButtonsStackView.addArrangedSubview(skipButton)
        pageControlButtonsStackView.addArrangedSubview(signInStackView)
    }
}

//MARK: - ScrollView Method

extension OnboardingView {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / witdh)
    }
}

//MARK: - CollectionView Methods

extension OnboardingView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collection.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else { return UICollectionViewCell()}
        cell.configure(data: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width, height: collection.frame.height)
    }
    
    
}

//MARK: - OnboardingViewInterface Methods

extension OnboardingController: OnboardingViewInterface {
    func onboardingView(_ view: OnboardingView, contiuneButtonTapped button: UIButton) {
        let signUpVC = SignUpController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func onboardingView(_ view: OnboardingView, skipButtonTapped button: UIButton) {
        let signUpVC = SignUpController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func onboardingView(_ view: OnboardingView, signInButtonTapped button: UIButton) {
        let signInVC = SignInController()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    
    
}
//MARK: - UI Elements Constraints

extension OnboardingView {
    
    private func addSubview() {
        addSubview(collection)
        addSubview(pageControl)
        addSubview(contiuneButton)
        addSubview(skipButton)
        addSubview(pageControlButtonsStackView)
        addSubview(signInLbl)
        addSubview(signInButton)
        addSubview(signInStackView)
    }
    
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
            make.height.equalTo(56)
            make.width.equalTo(116)
        }
    }
    
    private func signInStackViewConstraints() {
        signInStackView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(116)
            make.centerX.equalTo(contiuneButton.snp.centerX)
        }
    }
    
    private func pageControlButtonStackViewConstraints() {
        pageControlButtonsStackView.snp.makeConstraints { make in
            make.top.equalTo(collection.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide).offset(50)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-50)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
}




