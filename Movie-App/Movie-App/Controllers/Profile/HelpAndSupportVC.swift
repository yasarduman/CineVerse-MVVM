//
//  HelpAndSupportVC.swift
//  Movie-App
//
//  Created by Yaşar Duman on 4.11.2023.
//

import UIKit
import MessageUI

final class HelpAndSupportVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    private let mailComposer = MFMailComposeViewController()
    private let headLabel = TitleLabel(textAlignment: .center, fontSize: 25)
    private let secoLabel = SecondaryTitleLabel(fontSize: 20)
    lazy var getInTouchImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "getInTouch")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Header View
    private var user1 = HelpAndSupportUIView(
        userName: "Yaşar Duman",
        userImageName: "userAvatar",
        userEmail: "01.yasarduman@gmail.com")
    private var user2 = HelpAndSupportUIView(
        userName: "Erislam Nurluyol",
        userImageName: "userAvatar",
        userEmail: "01.yasarduman@gmail.com")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        
        configureGetInTouchImage()
        configureHeadText()
        configureUser1()
        configureUser2()
    }
    
    // MARK: - Cofigure UI
    private func configureGetInTouchImage(){
        view.addSubview(getInTouchImage)
        getInTouchImage.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               leading: view.leadingAnchor,
                               trailing: view.trailingAnchor,
                               
                               size: .init(width: 0, height: 300))
    }
    
    private func configureHeadText(){
        view.addSubview(headLabel)
        view.addSubview(secoLabel)
        
        headLabel.text = "Get In Touch"
        secoLabel.text = "If you have any inquiries get in touch with us. We'll be happy to help you"
        
        headLabel.anchor(top: getInTouchImage.bottomAnchor)
        headLabel.centerXInSuperview()
        
        secoLabel.numberOfLines = 2
        secoLabel.textAlignment = .center
        secoLabel.anchor(top: headLabel.bottomAnchor,
                         leading: view.leadingAnchor,
                         trailing: view.trailingAnchor,
                         padding: .init(top: 20, left: 20, bottom: 0, right: 20)
        )
    }
    
    // MARK: - Configure Users
    private func configureUser1() {
      view.addSubview(user1)
        user1.anchor(top: secoLabel.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 20, left: 10, bottom: 0, right: 10),
                            size: .init(width: 0, height: 100))
        
        // MARK: - SendEmail
        mailComposer.setToRecipients([user1.userEmail!]) // E-posta alıcısı
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
        user1.sendImage.isUserInteractionEnabled = true // UIImageView'ı etkileşimli hale getirin
        user1.sendImage.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureUser2() {
        view.addSubview(user2)
        user2.anchor(top: user1.bottomAnchor,
                            leading: view.leadingAnchor,
                            trailing: view.trailingAnchor,
                            padding: .init(top: 20, left: 10, bottom: 0, right: 10),
                            size: .init(width: 0, height: 100)
        )
        // MARK: - SendEmail
        mailComposer.setToRecipients([user2.userEmail!]) // E-posta alıcısı
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(sendEmail))
        user2.sendImage.isUserInteractionEnabled = true // UIImageView'ı etkileşimli hale getirin
        user2.sendImage.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    // MARK: - Action
    @objc func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
                mailComposer.mailComposeDelegate = self
                present(mailComposer, animated: true, completion: nil)
            } else {
               presentAlert(title: "Hata", message: "E-posta gönderme işlevi kullanılamıyor.", buttonTitle: "Ok")
            }
    }
}
