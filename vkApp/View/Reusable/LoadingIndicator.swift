//
//  LoadingIndicator.swift
//  Contacts
//
//  Created by Anna Delova on 4/26/21.
//

import Foundation
import UIKit

class LoadingIndicatorView: UIView {
    
    let circle1 = UIView()
    let circle2 = UIView()
    let circle3 = UIView()
    
    var circleArr: [UIView] = []
    
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        circleArr = [circle1, circle2, circle3]
        
        for i in circleArr {
            i.frame = CGRect(x: -20, y: 5, width: 30, height: 30)
            i.layer.cornerRadius = i.frame.width / 2
            i.backgroundColor = .white
            i.alpha = 0
            
            addSubview(i)
        }
        
        
    }
    
    func animate()
    {
        var delay: Double = 0
        
        for circle in circleArr {
            animateCircle(circle, delay: delay)
            delay += 0.95
        }
    }
    func animateCircle(_ circle: UIView, delay: Double) {
        UIView.animate(withDuration: 0.8, delay: delay, options: .curveLinear, animations: {
            circle.alpha = 1
            circle.frame = CGRect(x: 35, y: 5, width: 30, height: 30)
        })
        { (completed) in
            UIView.animate(withDuration: 1.3, delay: 0, options: .curveLinear, animations: {
                circle.frame = CGRect(x: 85, y: 5, width: 30, height: 30)
            }){ (completed) in
                UIView.animate(withDuration: 0.8, delay: 0, options: .curveLinear, animations: {
                    circle.alpha = 0
                    circle.frame = CGRect(x: 140, y: 5, width: 30, height: 30)
                }){ (completed) in
                        circle.frame = CGRect(x: -20, y: 5, width: 30, height: 30)
                    self.animateCircle(circle, delay: 0)
                }
            }
        }
    }
        
}
