//
//  RegisterVC.swift
//  Movie-App
//
//  Created by Yaşar Duman on 18.10.2023.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    // MARK: - Properties
    private let HeadLabel            = TitleLabel(textAlignment: .left, fontSize: 20)
    private let userNameTextField    = CustomTextField(fieldType: .username)
    private let emailTextField       = CustomTextField(fieldType: .email)
    private let passwordTextField    = CustomTextField(fieldType: .password)
    private let repasswordTextField  = CustomTextField(fieldType: .password)
    private let signUpButton         = MovieButton( bgColor:MovieColor.playButonBG ,color: MovieColor.playButonBG, title: "Sign Up", fontSize: .big)
    private let infoLabel            = SecondaryTitleLabel(fontSize: 16)
    private let signInButton         = MovieButton( bgColor:.clear ,color: .label, title: "Sign In.", fontSize: .small)
    
    private let stackView            = UIStackView()
    private let authVM : AuthVM?     = AuthVM()
    
    // MARK: - View Controller Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureHeadLabel()
        configureTextField()
        configureSignUp()
        configureStackView()
    }
    
    // MARK: - UI Configuration
    func configureViewController() {
        view.backgroundColor = .systemBackground
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.addSubviewsExt(HeadLabel, userNameTextField, emailTextField, passwordTextField, repasswordTextField, signUpButton, signInButton, stackView)
    }
    
    private func configureHeadLabel() {
        HeadLabel.text = "Create an account"
        
        HeadLabel.anchor(top: view.topAnchor,
                         leading: view.leadingAnchor,
                         padding: .init(top: 80, left: 20, bottom: 0, right: 0))
        
    }
    
    private func configureTextField() {
        userNameTextField.anchor(top: HeadLabel.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 40, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50))
        
        
        emailTextField.anchor(top: userNameTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50))
        

        
        passwordTextField.anchor(top: emailTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50))
        
        
        repasswordTextField.placeholder = "Repassword"
           
        repasswordTextField.anchor(top: passwordTextField.bottomAnchor,
                              leading: view.leadingAnchor,
                              trailing: view.trailingAnchor,
                              padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                              size: .init(width: 0, height: 50))
        

    }
    
    private func configureSignUp(){
        signUpButton.configuration?.cornerStyle = .capsule

        signUpButton.anchor(top: repasswordTextField.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 20, left: 20, bottom: 0, right: 20),
                            size: .init(width: 0, height: 50))
        
        signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)
       
    }
    
  

    private func configureStackView() {
        stackView.axis          = .horizontal
        
        stackView.addArrangedSubview(infoLabel)
        stackView.addArrangedSubview(signInButton)
        
        infoLabel.text = "Already have an account?"

        stackView.anchor(top: signUpButton.bottomAnchor,
                         padding: .init(top: 5, left: 0, bottom: 0, right: 0))
        
        stackView.centerXInSuperview()
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        
    }
    
    // MARK: - Action
    @objc private func didTapSignUp() {
       
        //Email & Password Validation
        guard let userName = userNameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text,
              let rePassword = repasswordTextField.text else{
            presentAlert(title: "Alert!", message: "Username, email, password, rePassword ?", buttonTitle: "Ok")
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
            
            guard password == rePassword else {
                presentAlert(title: "Alert!", message: "Password and password repeat are not the same", buttonTitle: "Ok")
                return
            }
    
        return
        }
        
        authVM?.register(userName: userName, email: email, password: password) { [weak self] success, error in
            guard let self = self else { return }

            if success {
                self.presentAlert(title: "Alert!", message: "Registration Successful 🥳", buttonTitle: "Ok")
                self.dismiss(animated: true) {
                    // Daha sonra NewsTabBarController'ı sun
                    let tabBar = MainTabBarViewController()
                    tabBar.modalPresentationStyle = .fullScreen
                    self.present(tabBar, animated: true, completion: nil)
                }
            } else {
                self.presentAlert(title: "Alert!", message: error, buttonTitle: "Ok")
            }
        }
    }
    
    @objc private func didTapSignIn() {

        self.navigationController?.popToRootViewController(animated: true)
    }
}
