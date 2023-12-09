//
//  AlertVC.swift
// //  Movie-App
//
//  Created by Yaşar Duman on 4.10.2023.
//

import UIKit

final class AlertVC: UIViewController {
    
    // MARK: - Properties
    private lazy var containerView  = AlertContainerView()
    private lazy var titleLabel     = TitleLabel(textAlignment: .center, fontSize: 20)
    private lazy var messageLabel   = BodyLabel(textAlignment: .center)
    private lazy var actionButton   = MovieButton(bgColor: .systemPink, color: .systemPink, title: "Ok", systemImageName: "checkmark.circle")
    
    var alertTitle: String?
    var message: String?
    var buttonTitle: String?
    
    private let padding: CGFloat = 20
    
    // MARK: - Initialization
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle   = title
        self.message      = message
        self.buttonTitle  = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviewsExt(containerView, titleLabel, actionButton, messageLabel)
        configureContainerView()
        configureTitleLabel()  
        configureActionButton()
        configureMessageLabel()
    }
    
    // MARK: - UI Configuration
    func configureContainerView() {
        containerView.centerInSuperview()
        containerView.anchor(size: .init(width: 280, height: 220))
    }
    
    func configureTitleLabel() {
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        titleLabel.anchor(top: containerView.topAnchor,
                          leading: containerView.leadingAnchor,
                          trailing: containerView.trailingAnchor,
                          padding: .init(top: 20, leading: 20, trailing: 20),
                          size: .init(heightSize: 28))
    }
    
    func configureMessageLabel(){
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        
        messageLabel.anchor(top: titleLabel.bottomAnchor,
                            leading: containerView.leadingAnchor,
                            bottom: actionButton.topAnchor,
                            trailing: containerView.trailingAnchor,
                            padding: .init(top: 8, left: 20, bottom: 12, right: 20))
      
    }
    
    func configureActionButton() {
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        actionButton.anchor(leading: containerView.leadingAnchor,
                            bottom: containerView.bottomAnchor,
                            trailing: containerView.trailingAnchor,
                            padding: .init(leading: 20, bottom: 20, trailing: 20),
                            size: .init(heightSize: 44))
      
    }
    
    // MARK: - Actions
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
