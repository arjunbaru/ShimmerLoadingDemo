//
//  ShimmerView.swift
//  ShimmerLoadingDemo
//
//  Created by Arjun Baru on 22/08/20.
//  Copyright © 2020 Arjun Baru. All rights reserved.
//

import UIKit
import TinyConstraints

protocol Shimmerable: UIView {
    var shimmerViews: [UIView] { get }
}

extension Shimmerable {
    func loadShimmer() {
        shimmerViews.forEach { $0.applyShimmerEffect() }
    }
}

extension UIView {
func applyShimmerEffect() {
    let light = UIColor.green.withAlphaComponent(0.5).cgColor
        let dark = UIColor.green.cgColor

        let shimmerGradientLayer = CAGradientLayer()
        shimmerGradientLayer.colors = [light, dark]
        shimmerGradientLayer.frame = CGRect(
            x: 2 * -bounds.width,
            y: 0,
            width: 50 * bounds.size.width,
            height: bounds.size.height
        )
        shimmerGradientLayer.startPoint = CGPoint(x: 0.0, y: 0)
        shimmerGradientLayer.endPoint = CGPoint(x: 1.0, y: 0)
        shimmerGradientLayer.locations = [0.0, 0.1]
        layer.mask = shimmerGradientLayer

        let animation = CABasicAnimation(keyPath: "locations")
        let toLocationArray: [NSNumber] = [0.1, 0.2]
        animation.fromValue = [0.0, 0.1]
        animation.toValue = toLocationArray
        animation.duration = 0.6
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        shimmerGradientLayer.add(animation, forKey: "shimmer")
    }
}

final class ShimmerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.width(160)
        view.height(25)
        view.backgroundColor = .lightGray

        return view
    }()

    private let descriptionView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.width(UIScreen.main.bounds.width * 0.80)
        view.height(150)
        view.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        return view
    }()
}

extension ShimmerView {
    func commonInit() {
        setupUI()
        setConstraints()
    }

    func setupUI() {
        addSubview(titleView)
        addSubview(descriptionView)
    }

    func setConstraints() {
        titleView.leadingToSuperview(offset: 15)
        titleView.topToSuperview(offset: 15)

        descriptionView.leadingToSuperview(offset: 15)

        titleView.bottomToTop(of: descriptionView, offset: -12)
    }
}

extension ShimmerView: Shimmerable {
    public var shimmerViews: [UIView] {
        return [titleView, descriptionView]
    }
}
