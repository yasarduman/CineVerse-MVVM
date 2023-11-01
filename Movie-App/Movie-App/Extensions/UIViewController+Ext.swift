//
//  UIViewController+Ext.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit
import SafariServices

    extension UIViewController {
        // MARK: - Custom Alerts
        func presentAlert(title: String, message: String, buttonTitle: String) {
                let alertVC = AlertVC(title: title, message: message, buttonTitle: buttonTitle)
                alertVC.modalPresentationStyle  = .overFullScreen
                alertVC.modalTransitionStyle    = .crossDissolve
                self.present(alertVC, animated: true)
        }
        
    // Presents a default error alert with a standard message.
        func presentDefualtError() {
            let alertVC = AlertVC(title: "Something Wnt Wrong !",
                                    message: "We were unable to complete your task at this time . Please try again.",
                                    buttonTitle: "Ok")
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
            
        }
        
    }
