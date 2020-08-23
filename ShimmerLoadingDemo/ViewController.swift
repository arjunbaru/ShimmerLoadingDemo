//
//  ViewController.swift
//  ShimmerLoadingDemo
//
//  Created by Arjun Baru on 22/08/20.
//  Copyright © 2020 Arjun Baru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let shimmerView: Shimmerable = ShimmerView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(shimmerView)
        shimmerView.topToSuperview(offset: 20, usingSafeArea: true)
        shimmerView.width(UIScreen.main.bounds.width)

        shimmerView.centerXToSuperview()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.shimmerView.loadShimmer()
        }
    }
}

