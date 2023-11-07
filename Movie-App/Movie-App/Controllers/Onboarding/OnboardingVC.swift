//
//  OnboardingVC.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

class OnboardingVC: UIViewController {
    // MARK: - Data
    // MARK: - ViewModel
    private var viewModel: OnboardingVM = OnboardingVM()
    
    // Data
    private var sliderData: [OnboardingItemModel] = []
    
    // MARK: - Views
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.register(SliderCell.self, forCellWithReuseIdentifier: "cell")
        collection.isPagingEnabled = true
        return collection
    }()
    lazy var skipBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    lazy var vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 5
        stack.distribution = .fillEqually
        return stack
    }()
    // MARK: - Shape
    private let shape = CAShapeLayer()
    private var currentPageIndex: CGFloat = 0
    private var fromValue: CGFloat = 0
    
    lazy var nextBtn: UIView = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextSlide))
        
        let nextImg = UIImageView()
        nextImg.image = UIImage(systemName: "chevron.right.circle.fill")
        nextImg.tintColor = .white
        nextImg.contentMode = .scaleAspectFit
 
        nextImg.anchor(size: .init(width: 55, height: 55))
        
        let btn = UIView()
        btn.anchor(size: .init(width: 60, height: 60))
        btn.isUserInteractionEnabled = true
        btn.addGestureRecognizer(tapGesture)
        btn.addSubview(nextImg)
        
        nextImg.centerInSuperview()
        return btn
    }()
    // MARK: - Page Control
    private var pagers: [UIView] = []
    private var currentSlide = 0
    private var widthAnhor: NSLayoutConstraint?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        sliderData = viewModel.sliderData
        setupCollection()
        setControll()
        setShape()
    }
    
    // MARK: - UI Setup
    private func setShape() {
        currentPageIndex = CGFloat(1) / CGFloat(sliderData.count) //(0.33333)
        
        let nextStroke = UIBezierPath(arcCenter: CGPoint(x: 30, y: 30), radius: 31, startAngle: -(.pi/2), endAngle: 5, clockwise: true)
        
        let trackShape = CAShapeLayer()
        trackShape.path = nextStroke.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 4
        trackShape.strokeColor = UIColor.white.cgColor
        trackShape.opacity = 0.1
        nextBtn.layer.addSublayer(trackShape)
        
        shape.path = nextStroke.cgPath
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeColor = UIColor.white.cgColor
        shape.lineWidth = 4
        shape.lineCap = .round
        shape.strokeStart = 0
        shape.strokeEnd = 0
        
        nextBtn.layer.addSublayer(shape)
    }
    
    private func setControll() {
        view.addSubview(vStack)
        view.addSubview(skipBtn)
        
        let pagerStack = UIStackView()
        pagerStack.axis = .horizontal
        pagerStack.spacing = 5
        pagerStack.alignment = .center
        pagerStack.distribution = .fill
        pagerStack.translatesAutoresizingMaskIntoConstraints = false
        
        for tag in 1...sliderData.count{
            let pager = UIView()
            pager.tag = tag
            pager.translatesAutoresizingMaskIntoConstraints = false
            pager.backgroundColor = .white
            pager.layer.cornerRadius = 5
            pager.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollToSlide(sender: ))))
            self.pagers.append(pager)
            pagerStack.addArrangedSubview(pager)
            
        }
        
        vStack.addArrangedSubview(nextBtn)
        vStack.addArrangedSubview(pagerStack)
        
        skipBtn.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       trailing: view.trailingAnchor,
                       padding: .init(top: 10, left: 0, bottom: 0, right: 10)
        )
        
        vStack.anchor(leading: view.leadingAnchor,
                      bottom: view.bottomAnchor,
                      trailing: view.trailingAnchor,
                      padding: .init(top: 0, left: 0, bottom: 50, right: 0)
        )
        
    }
    
    private func setupCollection(){
        view.addSubview(collectionView)
        collectionView.anchor(top: view.topAnchor,
                              leading: view.leadingAnchor,
                              bottom: view.bottomAnchor,
                              trailing: view.trailingAnchor
        )
    }
    // MARK: - UI Setup
    @objc func scrollToSlide(sender: UIGestureRecognizer){
        if let index = sender.view?.tag{
            collectionView.scrollToItem(at: IndexPath(item: index-1, section: 0), at: .centeredHorizontally, animated: true)
            
            currentSlide = index - 1
        }
    }
    
    @objc func nextSlide(){
        let maxSlider = sliderData.count
        if currentSlide < maxSlider-1 {
            currentSlide += 1
            collectionView.scrollToItem(at: IndexPath(item: currentSlide, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    // MARK: - Action
    @objc func skipButtonTapped() {
        let loginVC = LoginVC()
        let navController = UINavigationController(rootViewController: loginVC)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
        
    }
    
}

extension OnboardingVC : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sliderData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SliderCell {
            cell.contentView.backgroundColor = sliderData[indexPath.item].color
            cell.titleLabel.text = sliderData[indexPath.item].title
            cell.textLabel.text = sliderData[indexPath.item].text
            
            cell.animationSetup(animationName: sliderData[indexPath.item].animationName)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        currentSlide = indexPath.item
        
        pagers.forEach { page in
            let tag = page.tag
            
            page.constraints.forEach { conts in
                page.removeConstraint(conts)
            }
            
            let viewTag = indexPath.row + 1
            
            if viewTag == tag{
                page.layer.opacity = 1
                widthAnhor = page.widthAnchor.constraint(equalToConstant: 20)
            } else {
                page.layer.opacity = 0.5
                widthAnhor = page.widthAnchor.constraint(equalToConstant: 10)
            }
            widthAnhor?.isActive = true
            page.heightAnchor.constraint(equalToConstant: 10).isActive = true
            
        }
        
        let curentIndex = currentPageIndex * CGFloat(indexPath.item+1)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = fromValue
        animation.toValue = curentIndex
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        animation.duration = 0.5
        shape.add(animation, forKey: "animation")
        
        fromValue = curentIndex
    }
}
