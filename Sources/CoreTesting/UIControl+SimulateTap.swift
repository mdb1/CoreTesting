//
//  UIControl+SimulateTap.swift
//  
//
//  Created by Manu Herrera on 26/02/2022.
//

import UIKit

extension UIControl {
    func simulateTouchUpInside() {
        sendActions(for: .touchUpInside)
    }
}
