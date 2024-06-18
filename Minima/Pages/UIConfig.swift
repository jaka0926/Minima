//
//  UIConfig.swift
//  Minima
//
//  Created by Jaka on 2024-06-15.
//

import UIKit

enum Font {
    static let system13 = UIFont.systemFont(ofSize: 13)
    static let bold14 = UIFont.boldSystemFont(ofSize: 14)
    static let bold16 = UIFont.boldSystemFont(ofSize: 16)
}

enum Color {
    static let orange = UIColor(red: 0.94, green: 0.54, blue: 0.28, alpha: 1.00)
    static let lightGray = UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.00)
    static let gray = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)
    static let darkGray = UIColor(red: 0.30, green: 0.30, blue: 0.30, alpha: 1.00)
}

func defaultProfileImage(_ profile: UIButton, _ camera: UIButton) {
    
    profile.contentMode = .scaleAspectFill
    profile.layer.cornerRadius = 70
    profile.layer.borderColor = Color.orange.cgColor
    profile.layer.borderWidth = 5
    profile.clipsToBounds = true
    
    camera.backgroundColor = Color.orange
    camera.layer.cornerRadius = 20
    camera.translatesAutoresizingMaskIntoConstraints = false
    camera.setImage(UIImage(systemName: "camera.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20)), for: .normal)
    camera.tintColor = .white
}
