//
//  FadingLabel.swift
//  TestApp
//
//  Created by Shawn Frank on 21/01/2022.
//

import UIKit

class FadingLabel: UILabel
{
    // Add a property observer for text changes
    // as we might not need to fade anymore
    override var text: String?
    {
        didSet
        {
            // Check if the text needs to be faded
            fadeTailIfRequired()
        }
    }
    
    // Add a property observer for numberOfLines changes
    // as only 1 line labels are supported for now
    override var numberOfLines: Int
    {
        didSet
        {
            // Reset the number of lines to 1
            if numberOfLines != 1
            {
                numberOfLines = 1
            }
        }
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        
        // The label's frame might have changed so check
        // if the text needs to be faded or not
        fadeTailIfRequired()
    }
    
    
    /// The function that handles fading the tail end of the text if the text goes
    /// beyond the bounds of the label's width
    func fadeTailIfRequired()
    {
        // Reset the numberOfLines to 1
        numberOfLines = 1
        
        // Check if the label's text goes beyond it's width
        if intrinsicContentSize.width > bounds.width
        {
            // Initialize and configure a gradient to start at the end of
            // the label
            let gradient = CAGradientLayer()
            gradient.frame = bounds
            gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
            gradient.startPoint = CGPoint(x: 0.8, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.95, y: 0.5)
            
            // Apply the gradient as a mask to the UILabel
            layer.mask = gradient
        }
    }
}
