//
//  ChangePasswordVC.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

final class ChangePasswordVC: UIViewController {
    
    // MARK: - Properties
    private let HeadLabel                 = TitleLabel(textAlignment: .left, fontSize: 20)
    private lazy var passwordTextField    = CustomTextField(fieldType: .password)
    private lazy var repasswordTextField  = CustomTextField(fieldType: .password)
    private lazy var resetButton          = MovieButton( bgColor: MovieColor.playButonBG ,color: MovieColor.playButonBG, title: "Reset", fontSize: .big)
    private let authVM : AuthVM?     = AuthVM()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureHeadLabel()
        configureTextField()
        configureResetButton()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        view.addSubviewsExt(HeadLabel, passwordTextField, repasswordTextField, resetButton)
    }
    
    // MARK: - Configuration
    private func configureHeadLabel() {
        HeadLabel.text = "Reset Password"
        
        HeadLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                         leading: view.leadingAnchor,
                         padding: .init(top: 0, left: 20, bottom: 0, right: 0))
        
    }
    
    private func configureTextField() {
        passwordTextField.placeholder = "New Password"
        passwordTextField.anchor(top: HeadLabel.bottomAnchor,
                                 leading: view.leadingAnchor,
                                 trailing: view.trailingAnchor,
                                 padding: .init(top: 40, left: 20, bottom: 0, right: 20),
                                 size: .init(width: 0, height: 50))
        
        repasswordTextField.placeholder = "Confirm Password"
        
        repasswordTextField.anchor(top: passwordTextField.bottomAnchor,
                                   leading: view.leadingAnchor,
                                   trailing: view.trailingAnchor,
                                   padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                                   size: .init(width: 0, height: 50))
    }
    
    private func configureResetButton(){
        resetButton.configuration?.cornerStyle = .capsule
        
        resetButton.anchor(top: repasswordTextField.bottomAnchor,
                           leading: view.leadingAnchor,
                           trailing: view.trailingAnchor,
                           padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                           size: .init(width: 0, height: 50))
        
        resetButton.addTarget(self, action: #selector(didTapResetButton), for: .touchUpInside)
    }
    
    // MARK: - Action
    @objc private func didTapResetButton() {
        //Email & Password Validation
        guard let password = passwordTextField.text,
              let rePassword = repasswordTextField.text else{
            presentAlert(title: "Alert!", message: "Email and Password ?", buttonTitle: "Ok")
            return
        }
        
        guard password.isValidPassword(password: password) else {
            
            guard password.count >= 6 else {
                presentAlert(title: "Alert!", message: "Password must be at least 6 characters", buttonTitle: "Ok")
                return
            }
            
            guard password.containsDigits(password) else {
                presentAlert(title: "Alert!", message: "Password must contain at least 1 digit", buttonTitle: "Ok")
                return
            }
            
            guard password.containsLowerCase(password) else {
                presentAlert(title: "Alert!", message: "Password must contain at least 1 lowercase character", buttonTitle: "Ok")
                return
            }
            
            guard password.containsUpperCase(password) else {
                presentAlert(title: "Alert!", message: "Password must contain at least 1 uppercase character", buttonTitle: "Ok")
                return
            }
            
            guard  password == rePassword  else {
                presentAlert(title: "Alert!", message: "Password and password repeat are not the same", buttonTitle: "Ok")
                return
            }
            return
        }
        
        authVM?.changePassword(password: rePassword) { [weak self] success, error in
            guard let self = self else { return }
            
            if success {
                passwordTextField.text = ""
                repasswordTextField.text = ""
                self.presentAlert(title: "Alert!", message: "Password change Successful 🥳", buttonTitle: "Ok")
                
            } else {
                self.presentAlert(title: "Alert!", message: error, buttonTitle: "Ok")
            }
        }
    }  
}
