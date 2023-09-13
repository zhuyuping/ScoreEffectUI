//
//  IncentiveView.swift
//  ScoreEffectUI
//
//  Created by ZYP on 2023/1/29.
//

import UIKit

/// 激励视图
public class IncentiveView: UIView {
    private var itemViews: [IncentiveItemView]!
    private var combo = 1
    var lastType = IncentiveType.none
    private let logTag = "IncentiveView"
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        itemViews = [.init(), .init(), .init(), .init(), .init()]
        for view in itemViews {
            view.isHidden = true
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFit
            view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit")
    }
    
    /// show
    /// - Parameter score: [0, 100]
    @objc public func show(score: Int) {
        if score > 100 || score < 0 {
            return
        }
        
        let item = calculatedItem(score: score)
        if item.type == .none { return }
        
        guard let view = getView(), let image =  Bundle.currentBundle.image(name: item.type.imageName) else {
            return
        }
        bringSubviewToFront(view)
        view.showAnimation(image: image, combo: item.num)
    }
    
    @objc public func reset() {
        lastType = .none
        combo = 1
    }
    
    private func getView() -> IncentiveItemView? {
        return itemViews.first(where: { $0.canUse })
    }
    
    /// 通过输入的score，计算得出的Item
    func calculatedItem(score: Int) -> Item {
        var type = IncentiveType.none
        
        if score >= 60, score < 75 {
            type = .fair
        }
        else if score >= 75, score < 90 {
            type = .good
        }
        else if score >= 90, score <= 100 {
            type = .excellent
        }
        else {}
        if score == 16 {
            print("")
        }
        if type != .none {
            if lastType == type { /** add **/
                combo += 1
            }
            else { /** reset **/
                combo = 1
            }
        }
        else { /** reset **/
            combo = 1
        }
        
        lastType = type
        
        return Item(type: type, num: combo)
    }
}

class IncentiveItemView: UIView, CAAnimationDelegate {
    private let imageView = UIImageView()
    private let comboLabel = IncentiveLabel()
    fileprivate var canUse = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comboLabel.font = UIFont(name: "PingFangSC-Bold", size: 13)
        
        comboLabel.textAlignment = .center
        comboLabel.textColor = .white
        
        addSubview(imageView)
        addSubview(comboLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        comboLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        comboLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        comboLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func showAnimation(image: UIImage, combo: Int) {
        canUse = false
        comboLabel.text = "×\(combo)"
        comboLabel.isHidden = combo < 2
        imageView.image = image
        isHidden = false
        
        let transformAnimation = CABasicAnimation(keyPath: "transform.scale")
        transformAnimation.fromValue = 1.6
        transformAnimation.toValue = 1
        transformAnimation.duration = 0.3
        
        let opacityAnimation1 = CABasicAnimation(keyPath: "opacity")
        opacityAnimation1.fromValue = 0
        opacityAnimation1.toValue = 1
        opacityAnimation1.duration = 0.3
        
        let opacityAnimation2 = CABasicAnimation(keyPath: "opacity")
        opacityAnimation2.beginTime = 0.3 + 1.4
        opacityAnimation2.fromValue = 1
        opacityAnimation2.toValue = 0
        opacityAnimation2.duration = 0.3
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [transformAnimation, opacityAnimation1, opacityAnimation2]
        animationGroup.duration = 2
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = .forwards
        animationGroup.delegate = self
        
        layer.add(animationGroup, forKey: "animationGroup")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            isHidden = true
            layer.removeAnimation(forKey: "animationGroup")
            canUse = true
        }
    }
}

class IncentiveLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let color = textColor
        let offset = shadowOffset
        
        let context = UIGraphicsGetCurrentContext()
        context?.setLineWidth(4.0)
        context?.setLineJoin(.round)
        context?.setTextDrawingMode(.strokeClip)
        textColor = UIColor.colorWithHex(hexStr: "#368CFF")
        super.drawText(in: rect)
        
        context?.setTextDrawingMode(.fill)
        textColor = color
        shadowOffset = .zero
        super.drawText(in: rect)
        
        shadowOffset = offset
    }
}


extension IncentiveView { /** Info **/
    enum IncentiveType {
        /// [60, 75)
        case fair
        /// [75, 90)
        case good
        /// [90, 100]
        case excellent
        /// [0, 60)
        case none
        
        var imageName: String {
            switch self {
            case .fair:
                return "fair"
            case .good:
                return "good"
            case .excellent:
                return "excellent"
            default:
                return ""
            }
        }
    }
    
    struct Item {
        let type: IncentiveType
        let num: Int
    }
}
