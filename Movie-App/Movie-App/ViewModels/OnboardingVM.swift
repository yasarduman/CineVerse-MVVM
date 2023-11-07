//
//  OnboardingVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 31.10.2023.
//

import Foundation
import UIKit

class OnboardingVM {
    let sliderData: [OnboardingItemModel] = [
        OnboardingItemModel(color: MovieColor.TabarbgDark, title: "Step into the Magic of Cinema", text: "Cineverse welcomes you to the enchanting world of cinema. Begin your journey by discovering the latest film news and captivating stories.", animationName: "a2"),
        
        OnboardingItemModel(color: MovieColor.TabarbgDark, title: "Experience Film Delight with Cineverse", text: "For movie enthusiasts, Cineverse is here! Explore the newest films and immerse yourself in the enchanting world of cinema.", animationName: "a1"),
        
        OnboardingItemModel(color: MovieColor.TabarbgDark, title: "Ready for a Cinematic Adventure with Cineverse?", text: "Embark on a magical film journey with Cineverse. Discover the latest trailers, star updates, and more in the world of cinema!", animationName: "a2"),
    ]
}
