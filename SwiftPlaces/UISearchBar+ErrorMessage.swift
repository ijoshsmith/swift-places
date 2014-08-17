//
//  UISearchBar+ErrorMessage.swift
//  SwiftPlaces
//
//  Created by Joshua Smith on 7/28/14.
//  Copyright (c) 2014 iJoshSmith. All rights reserved.
//

import UIKit

extension UISearchBar
{
    /**
    Shows an image and error message, which is erased by character-wise animation.
    */
    func showErrorMessage(errorMessage: String, backgroundImage: UIImage?)
    {
        let startImage = self.backgroundImageForBarPosition(.Any, barMetrics: .Default)
        let errorImage = backgroundImage ?? startImage
        setEnabled(false, image: errorImage, text: errorMessage)
        delay(lingerDuration)
        {
            let perCharacter = self.eraseDuration / Double(self.text.utf16Count)
            self.eraseErrorMessageWithStepwiseDuration(perCharacter)
            {
                self.setEnabled(true, image: startImage, text: "")
            }
        }
    }
    
    private func setEnabled(enabled: Bool, image: UIImage?, text: String)
    {
        self.userInteractionEnabled = enabled
        self.setBackgroundImage(image, forBarPosition: .Any, barMetrics: .Default)
        self.text = text
    }
    
    private func eraseErrorMessageWithStepwiseDuration(duration: Double, _ completion: () -> ())
    {
        let start = text.startIndex, end = text.endIndex
        if start != end
        {
            delay(duration)
            {
                self.text = self.text.substringToIndex(end.predecessor())
                self.eraseErrorMessageWithStepwiseDuration(duration, completion)
            }
        }
        else
        {
            completion()
        }
    }
    
    private var lingerDuration: Double { return 0.8 }
    private var eraseDuration:  Double { return 0.4 }
}
