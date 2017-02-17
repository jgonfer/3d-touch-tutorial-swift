//
//  UIButtonExtension.swift
//  touch 3d
//
//  Created by jgonzalez on 17/2/17.
//  Copyright © 2017 jgonfer. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func pushSoft(completion:@escaping (() -> Void)) {
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: { (finished) in
            if finished {
                DispatchQueue.main.async {
                    completion()
                }
            }
        })
    }
}
