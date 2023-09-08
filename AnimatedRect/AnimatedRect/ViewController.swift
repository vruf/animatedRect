//
//  ViewController.swift
//  AnimatedRect
//
//  Created by Vadim Rufov on 7.9.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var container = UIView()
    private lazy var slider = {
        let view = UISlider()
        view.minimumValue = 0
        view.maximumValue = 100
        view.value = 0
        view.addTarget(self, action: #selector(sliderValueChanged(slider:)), for: .valueChanged)
        view.addTarget(self, action: #selector(setLastValue(slider:)), for: .touchUpInside)
        view.addTarget(self, action: #selector(setLastValue(slider:)), for: .touchUpOutside)
        return view
    }()
    private lazy var rect = {
        let view: UIView = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.layer.cornerRadius = 8
        view.backgroundColor = .systemBlue
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(container)
        container.addSubview(rect)
        container.addSubview(slider)
        
        arrangeViews()
    }
    
    func arrangeViews() {
        container.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            slider.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            slider.topAnchor.constraint(equalTo: container.topAnchor, constant: 150),
        ])
        
        self.rect.center.y = 80
    }
    
    @objc func sliderValueChanged(slider: UISlider){
        let sizeMultiplier = slider.value / 2
        let increase = Int(80 / 100 * sizeMultiplier)
        
        UIView.animate(withDuration: 0.6) {
            self.rect.transform = .identity
            self.rect.frame.size = CGSize(width: increase+80, height: increase+80)
            self.rect.center.y = 80
            
            let maxCenterX = self.container.bounds.maxX - 120
            self.rect.center.x = (self.rect.bounds.width / 2) + (maxCenterX * CGFloat((slider.value) / 100))
            self.rect.transform = CGAffineTransform(rotationAngle: CGFloat((slider.value * 0.9) * .pi/180))        }
    }
    
    @objc func setLastValue(slider: UISlider) {
        slider.setValue(slider.maximumValue, animated: true)
        sliderValueChanged(slider: slider)
    }
}
