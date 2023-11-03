//
//  ProfileVM.swift
//  Movie-App
//
//  Created by Yaşar Duman on 3.11.2023.
//

import Foundation
import UIKit

// MARK: - Section Data Structure
struct Section {
    let title: String
    let options: [SettingsOptionType]
}

// MARK: - Settings Option Type Enumeration
enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

// MARK: - Switch Option Data Structure
struct SettingsSwitchOption {
    let title: String
    let icon: UIImage?
    let iconBackgrondColor: UIColor
    let handler: (() -> Void)
    var isOn: Bool
}

// MARK: - Settings Option Data Structure
struct SettingsOption {
    let title: String
    let icon: UIImage?
    let iconBackgrondColor: UIColor
    let handler: (() -> Void)
}
