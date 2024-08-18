//
//  CustomBackButton.swift
//  Characters
//
//  Created by kayeli dennis on 18/08/2024.
//

import UIKit

class CustomBackButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    private func setupButton() {
        // Set the image for the button (arrow.left)
        let image = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
        self.tintColor = .black
        
        // Set button properties
        self.backgroundColor = .white
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        
        // Add shadow to the button
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 5
    }
}
