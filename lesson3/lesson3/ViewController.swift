//
//  ViewController.swift
//  lesson3
//
//  Created by GEDAKYAN Artur on 09.02.2024.
//

import UIKit

final class ViewController: UIViewController {
    private lazy var quardoView: UIView = {
        let blueView = UIView()
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = UIColor.systemBlue
        blueView.layer.cornerRadius = 20
        return blueView
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderReleased), for: .touchUpInside)
        return slider
    }()
    
    private var animator: UIViewPropertyAnimator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(quardoView)
        view.addSubview(slider)
        
        setupLayout()
        updateAnimate()
    }
    
    private func setupLayout() {
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            quardoView.widthAnchor.constraint(equalToConstant: 100),
            quardoView.heightAnchor.constraint(equalToConstant: 100),
            quardoView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 50),
            quardoView.leftAnchor.constraint(equalTo: margins.leftAnchor)
        ])
        
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            slider.topAnchor.constraint(equalTo: quardoView.bottomAnchor, constant: 50)
        ])
    }
    
    private func updateAnimate() {
        animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut) { [unowned self, quardoView] in
            let finalX = self.view.frame.width - quardoView.frame.width - view.layoutMargins.right * 1.5 - 20
            quardoView.frame.origin.x = finalX
            quardoView.transform = CGAffineTransform(rotationAngle: .pi / 2).scaledBy(x: 1.5, y: 1.5)
        }
        animator?.pausesOnCompletion = true
    }
    
    
    @objc
    private func sliderReleased(_ sender: UISlider) {
        animator?.startAnimation()
        slider.setValue(1, animated: true)
    }
    
    @objc
    private func sliderChanged(_ sender: UISlider) {
        animator?.fractionComplete = CGFloat(sender.value)
    }

}
