//
//  MovieDataLoadingVCswift
//  Movie-App
//
//  Created by Yaşar Duman on 30.10.2023.
//

import UIKit

class MovieDataLoadingVC: UIViewController {
    // MARK: - Properties
    var containerView: UIView!
    
    // MARK: - Loading View Methods
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.05) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.centerInSuperview()
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
}
