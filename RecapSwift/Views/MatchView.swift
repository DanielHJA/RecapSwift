//
//  MatchView.swift
//  RecapSwift
//
//  Created by Daniel Hjärtström on 2018-06-02.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class MatchView: UIView {
    
    var percentage: Double = 0.0 {
        didSet {
            update()
        }
    }
    
    private var shapeLayer: CAShapeLayer?
    private let π: CGFloat = CGFloat(Double.pi)
    private var timer: Timer?
    private let animationTime: Double = 3.0
    private var count: Int = 0
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.white
        temp.font = UIFont(name: "Halvetica", size: 18.0)
        temp.numberOfLines = 1
        temp.textAlignment = .center
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.widthAnchor.constraint(equalToConstant: frame.width * 0.5).isActive = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black.withAlphaComponent(0.7)
        layer.cornerRadius = frame.height / 2
        
        shapeLayer = CAShapeLayer()
        shapeLayer?.frame = bounds
        shapeLayer?.lineWidth = 10.0
        shapeLayer?.fillColor = UIColor.clear.cgColor
        shapeLayer?.strokeColor = UIColor.green.cgColor
        shapeLayer?.lineCap = kCALineCapRound
        shapeLayer?.strokeStart = 0.0
        shapeLayer?.strokeEnd = 0.0
        
        let radius = frame.width / 2
        let startAngle = 3.0 * π / 2.0
        let endAngle = startAngle + (4.0 * π / 2.0)
        
        let circlePath = UIBezierPath(arcCenter:CGPoint(x: frame.width / 2, y: frame.height / 2), radius:radius, startAngle: startAngle, endAngle:endAngle, clockwise: true)
        
        shapeLayer?.path = circlePath.cgPath
        layer.addSublayer(shapeLayer!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = animationTime
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = 0.0
        animation.toValue = percentage
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        shapeLayer?.add(animation, forKey: "strokeEnd")
     
        timer = Timer.scheduledTimer(timeInterval: animationTime / Double(percentage * 100) , target: self, selector: #selector(increaseLabel), userInfo: nil, repeats: true)
    }
    
    @objc private func increaseLabel() {
        if count < Int(percentage * 100) {
            label.text = "\(count + 1)%"
            count += 1
        } else {
            timer?.invalidate()
            timer = nil
            count = 0
        }
    }
    
}
