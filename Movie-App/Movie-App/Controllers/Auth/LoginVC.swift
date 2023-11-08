//
//  LoginVC.swift
//  Movie-App
//
//  Created by Yaşar Duman on 15.10.2023.
//



import UIKit
import Firebase

class LoginVC: UIViewController {
    // MARK: - Properties
    private let HeadLabel            = TitleLabel(textAlignment: .left, fontSize: 20)
    private lazy var emailTextField       = CustomTextField(fieldType: .email)
    private lazy var passwordTextField    = CustomTextField(fieldType: .password)
    private lazy var signInButton         = MovieButton( bgColor:MovieColor.playButonBG ,color: MovieColor.playButonBG , title: "Sign In", fontSize: .big)
    private let infoLabel            = SecondaryTitleLabel(fontSize: 16)
    private lazy var newUserButton        = MovieButton( bgColor:.clear ,color: .label, title: "Sign Up.", fontSize: .small)
    private lazy var forgotPasswordButton = MovieButton( bgColor:.clear ,color: MovieColor.playButonBG , title: "Forgot password?", fontSize: .small)
    
    private lazy var stackView            = UIStackView()
    private let authVM : AuthVM?     = AuthVM()
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviewsExt(HeadLabel, emailTextField, passwordTextField, forgotPasswordButton, signInButton,stackView)
        
        configureHeadLabel()
        configureTextField()
        configureForgotPassword()
        configureSignIn()
        configureStackView()
    }
    // MARK: - UI Configuration
    
    private func configureHeadLabel() {
        HeadLabel.text = "Let's sign you in"
        
        HeadLabel.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         //trailing: view.trailingAnchor,
                         padding: .init(top: 80, left: 20, bottom: 0, right: 0))
    }
    
    private func configureTextField() {
        emailTextField.anchor(top: HeadLabel.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 40, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50))
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50))
    }
    
    private func configureForgotPassword(){
        forgotPasswordButton.tintColor = .systemPurple
    
        forgotPasswordButton.anchor(top: passwordTextField.bottomAnchor,
                                    trailing: passwordTextField.trailingAnchor,
                                    padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    private func configureSignIn(){
        signInButton.configuration?.cornerStyle = .capsule
        
        signInButton.anchor(top: forgotPasswordButton.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                            size: .init(width: 0, height: 50))
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    
    
    private func configureStackView() {
        stackView.axis          = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(newUserButton)
        
        infoLabel.text = "Don't have an account?"
 
        
        stackView.anchor(top: signInButton.bottomAnchor,
                         padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        stackView.centerXInSuperview()
        
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
    }
    
    @objc private func didTapSignIn() {
        //Email & Password Validation
        
        guard let email = emailTextField.text,
              let password = passwordTextField.text else{
            presentAlert(title: "Alert!", message: "Email and Password ?", buttonTitle: "Ok")
            return
        }
        guard email.isValidEmail(email: email) else {
            presentAlert(title: "Alert!", message: "Email Invalid", buttonTitle: "Ok")
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
         
            return
        }
        
        authVM?.login(email: email, password: password) { [weak self]  success, error in
            guard let self = self else { return }

            if success {
                self.presentAlert(title: "Alert!", message: "Entry Successful 🥳", buttonTitle: "Ok")
                self.dismiss(animated: true) {
                    
                    let tabBar = MainTabBarViewController()
                    tabBar.modalPresentationStyle = .fullScreen
                    self.present(tabBar, animated: true, completion: nil)
                }   
            } else {
                self.presentAlert(title: "Alert!", message: error, buttonTitle: "Ok")
            }
        }
    }
    
 // MARK: - ACTİON
    @objc private func didTapNewUser() {
        let vc = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func didTapForgotPassword() {
        let vc = ForgotPasswordVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
