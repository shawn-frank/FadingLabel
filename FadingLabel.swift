//
//  FadingLabel.swift
//  TestApp
//
//  Created by Shawn Frank on 21/01/2022.
//

import UIKit

class FadingLabel: UILabel
{
    override var text: String?
    {
        didSet
        {
            fadeTailIfRequired()
        }
    }
    
    override var numberOfLines: Int
    {
        didSet
        {
            if numberOfLines != 1
            {
                numberOfLines = 1
            }
            
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        fadeTailIfRequired()
    }
    
    func fadeTailIfRequired()
    {
        numberOfLines = 1
        
        if intrinsicContentSize.width > bounds.width
        {
            let gradient = CAGradientLayer()
            gradient.frame = bounds
            gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.startPoint = CGPoint(x: 0.8, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.95, y: 0.5)
            
            layer.mask = gradient
        }
    }
}
