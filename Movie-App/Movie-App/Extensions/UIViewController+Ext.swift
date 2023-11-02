//
//  UIViewController+Ext.swift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//


import UIKit

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
    
    // MARK: - Loading Indicator
    // Shows a loading indicator view on top of the current view controller.
    func showLoading() {
        let loadingViewController = MovieDataLoadingVC()
        loadingViewController.showLoadingView()
        loadingViewController.modalPresentationStyle  = .overFullScreen
        loadingViewController.modalTransitionStyle    = .crossDissolve
        self.present(loadingViewController, animated: true)
    }
    // Dismisses the currently presented loading indicator view.
    func dismissLoading() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
