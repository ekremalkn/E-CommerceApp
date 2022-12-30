//
//  OnboardingController.swift
//  StoreA
//
//  Created by Ekrem Alkan on 30.12.2022.
//

import UIKit
import SnapKit

final class OnboardingController: UIViewController {
    
    //MARK: -  Creating UI Elements
    
    private var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    private var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 2
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .systemGray
        return pageControl
    }()
    
    private var contiuneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Contiune", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var logInLbl: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.isHidden = true
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.isHidden = true
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Onboarding Model Array

    private var slides: [OnboardingSlide] = []
    
    //MARK: - PageControl CurrentPage
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                skipButton.isHidden = true
                logInLbl.isHidden = false
                logInButton.isHidden = false
                contiuneButton.setTitle("Get Started", for: .normal)
            } else {
                logInLbl.isHidden = true
                logInButton.isHidden = true
                skipButton.isHidden = false
                contiuneButton.setTitle("Contiune", for: .normal)
            }
        }
    }
    
    
    //MARK: -  ViewDidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.delegate = self
        collection.dataSource = self
        collectionCellRegister()
        view.backgroundColor = .white
        addSubview()
        setupConstraints()
        setSlides()
        addTarget()
    }
    
    
    //MARK: - Register Custom Collection Cell

    private func collectionCellRegister() {
        collection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
    }
    //MARK: - SetSlides
    
    private func setSlides() {
        slides = [OnboardingSlide(title: "Explore Best Products", description: "Browse products and find your desire product.", image: UIImage(named: "onboardingSlide1")!),
                  OnboardingSlide(title: "Confirm Your Purchase", description: "Make the final purchase and get the quick delivery.", image: UIImage(named: "onboardingSlide2")!)]
    }
    
    
    //MARK: - Button Actions
    
    private func addTarget() {
        contiuneButton.addTarget(self, action: #selector(contiuneButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
    }
    
    @objc private func contiuneButtonTapped() {
        if currentPage == slides.count - 1 {
            print("last page - show sign up screen")
        } else {
            collection.isPagingEnabled = false
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collection.scrollToItem(at: indexPath, at: .right, animated: true)
            collection.isPagingEnabled = true
            
        }
    }
    
    
    @objc private func skipButtonTapped() {
        print("Skip button tapped show log in")
        
    }
    
    @objc private func logInButtonTapped() {
        print("log in button tapped show log in")
    }
    
}

//MARK: - CollectionView Methods

extension OnboardingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        cell.configure(data: slides[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collection.frame.width, height: collection.frame.height)
    }
    
    
}

//MARK: - ScrollView Method

extension OnboardingController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let witdh = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / witdh)
    }
}


//MARK: - UI Elements Constraints

extension OnboardingController {
    
    private func addSubview() {
        view.addSubview(collection)
        view.addSubview(pageControl)
        view.addSubview(contiuneButton)
        view.addSubview(skipButton)
        view.addSubview(logInLbl)
        view.addSubview(logInButton)
    }
    
    private func setupConstraints() {
        collectionConstraint()
        pageControlConstraint()
        contiuneButtonConstraint()
        skipButtonConstraint()
        logInLblConstraint()
        logInButtonConstraint()
        
    }
    
    private func collectionConstraint() {
        collection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func pageControlConstraint() {
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collection.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-180)
        }
    }
    
    private func contiuneButtonConstraint() {
        contiuneButton.snp.makeConstraints { make in
            make.width.equalTo(119)
            make.height.equalTo(56)
            make.top.equalTo(pageControl.snp.bottom).offset(30)
            make.centerX.equalTo(pageControl.snp.centerX)
        }
    }
    
    private func skipButtonConstraint() {
        skipButton.snp.makeConstraints { make in
            make.width.equalTo(119)
            make.height.equalTo(44)
            make.top.equalTo(contiuneButton.snp.bottom).offset(15)
            make.centerX.equalTo(contiuneButton.snp.centerX)
        }
    }
    
    private func logInLblConstraint() {
        logInLbl.snp.makeConstraints { make in
            make.top.equalTo(contiuneButton.snp.bottom).offset(35)
            make.centerX.equalTo(contiuneButton.snp.centerX)
        }
    }
    
    private func logInButtonConstraint() {
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(logInLbl.snp.bottom).offset(5)
            make.centerX.equalTo(logInLbl.snp.centerX)
            
            
        }
    }
}
