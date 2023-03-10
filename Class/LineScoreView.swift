//
//  LineScoreView.swift
//  AgoraLyricsScore
//
//  Created by ZYP on 2023/3/10.
//

import UIKit

/// 展示每句得分
@objc public class LineScoreView: UIView {
    private var labels: [UILabel] = [.init(), .init(), .init(), .init(), .init()]
    private var labelCenterYConstraints = [NSLayoutConstraint]()
    private var currentLabelIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        for label in labels {
            label.font = .systemFont(ofSize: 11)
            label.textColor = .white
            addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
            let labelCenterYConstraint = label.centerYAnchor.constraint(equalTo: bottomAnchor)
            labelCenterYConstraint.isActive = true
            labelCenterYConstraints.append(labelCenterYConstraint)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc public func showScoreView(score: Int) {
        let viewHeight = bounds.height
        let index = findIndexOfLabel()
        let label = labels[index]
        label.text = "+\(score)"
        let constraint = labelCenterYConstraints[index]
        let startConstant: CGFloat = 0
        let endConstant: CGFloat = (viewHeight - 10) * -1
        constraint.constant = startConstant
        label.alpha = 1
        label.isHidden = false
        layoutIfNeeded()
        constraint.constant = endConstant
        UIView.animate(withDuration: 0.4, delay: 0.2, options: []) {
            label.alpha = 0
            self.layoutIfNeeded()
        } completion: { completed in
            
        }
    }
    
    private func findIndexOfLabel() -> Int {
        var index = currentLabelIndex + 1
        index = index < labels.count ? index : 0
        currentLabelIndex = index
        return index
    }
}
