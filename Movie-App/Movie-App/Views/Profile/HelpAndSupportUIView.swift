//
//  HelpAndSupportUIView.swift
//  Movie-App
//
//  Created by Yaşar Duman on 4.11.2023.
//

import UIKit


class HelpAndSupportUIView: UIView {
    // MARK: - UI Elements
    lazy var containerView : UIView = {
        let container = UIView()
        container.backgroundColor = .secondarySystemBackground
        container.layer.cornerRadius = 10
        return container
    }()
    
    lazy var userImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "heroImage")
        image.clipsToBounds = true
        image.layer.cornerRadius = 35
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Yaşar Duman"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var userMessage: UILabel = {
        let label = UILabel()
        label.text = "Send you a message"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    lazy var sendImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "message.badge.filled.fill")
        image.tintColor = MovieColor.playButonBG
        return image
    }()
    
    // MARK: - Properties
    var userEmail: String?
    
    // MARK: - Initializers
    init(userName:String, userImageName: String ,userEmail: String) {
       super.init(frame: .zero)
       self.userName.text = userName
       self.userImage.image = UIImage(named: userImageName)
        self.userEmail = userEmail
        
       configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    private func configureUI(){
        configureContainer()
        configureuserImage()
        configureUserName()
        configureUserMessage()
        configureSendIamge()
    }
    
    private func configureContainer(){
        addSubview(containerView)
        containerView.backgroundColor = .tertiarySystemGroupedBackground
        containerView.fillSuperview()
    }
    
    private func configureuserImage(){
        containerView.addSubview(userImage)
        userImage.anchor(leading: containerView.leadingAnchor,
                         padding: .init(top: 0, left: 15, bottom: 0, right: 0),
                         size: .init(width: 70, height: 70))
        
        userImage.centerYInSuperview()
    }
    
    private func configureUserName(){
        containerView.addSubview(userName)
        userName.anchor(top: containerView.topAnchor,
                        padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        userName.centerXInSuperview()
    }
    
    private func configureUserMessage(){
        containerView.addSubview(userMessage)
        userMessage.anchor(top: userName.bottomAnchor,
                           padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        userMessage.centerXInSuperview()
    }
    
    private func configureSendIamge(){
        containerView.addSubview(sendImage)
        sendImage.anchor(trailing: containerView.trailingAnchor,
                         padding: .init(top: 0, left: 0, bottom: 0, right: 10),
                         size: .init(width: 35, height: 35))
        
        sendImage.centerYInSuperview()
        
    }
}
