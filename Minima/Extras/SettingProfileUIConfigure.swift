//
//  SettingProfileUIConfigure.swift
//  Minima
//
//  Created by Jaka on 2024-06-18.
//

import UIKit

extension UIButton.Configuration {
    
    static func profileStyle(_ title: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
        configuration.attributedTitle = AttributedString(title, attributes: .init([.font: Font.bold16]))
        configuration.subtitle = "2024-06-20"
        configuration.titleAlignment = .leading
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 110, bottom: 0, trailing: 0)
        configuration.baseForegroundColor = .black
        configuration.cornerStyle = .fixed
        configuration.image = UIImage(systemName: "chevron.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 140
        return configuration
    }
    
}
