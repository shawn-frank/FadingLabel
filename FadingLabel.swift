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
    
    // Used to hold the original un-truncated text
    private var originalText: String? = ""
    
    // Checks if the text is being processed to prevent
    // the fade animation
    private var isTruncatingEllipsis = false
    
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
    private func fadeTailIfRequired()
    {
        // Reset the numberOfLines to 1
        numberOfLines = 1
        
        // Prevent processing fading when the library is in the middle of
        // processing the string to truncate the ellipsis
        if !isTruncatingEllipsis
        {
            // Check if the label's has it's width set and if the text goes
            // beyond it's width plus a margin of safety
            if bounds.width > CGFloat.zero && intrinsicContentSize.width > bounds.width + 5
            {
                // Fade label works better with this setting
                allowsDefaultTighteningForTruncation = true
                
                // Initialize and configure a gradient to start at the end of
                // the label
                let gradient = CAGradientLayer()
                gradient.frame = bounds
                gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
                gradient.startPoint = CGPoint(x: 0.8, y: 0.5)
                gradient.endPoint = CGPoint(x: 0.99, y: 0.5)
                
                // Apply the gradient as a mask to the UILabel
                layer.mask = gradient
                
                // Remove ellipsis added as the default UILabel truncation character
                removeEllipsis()
                
                // We do not need to go beyond this point
                return
            }
            
            // If the text has not been truncated, remove the gradient mask
            if originalText == text
            {
                // Remove the layer mask
                layer.mask = nil
            }
        }
    }
    
    /// Keep removing 1 character from the label till it no longer needs to truncate
    private func removeEllipsis()
    {
        isTruncatingEllipsis = true
        
        // Keep looping till we do not have the perfect string length
        // to fit into the label
        while intrinsicContentSize.width > bounds.width
        {
            // Drop the last character
            text = String(text!.dropLast())
        }
        
        isTruncatingEllipsis = false
    }
}
