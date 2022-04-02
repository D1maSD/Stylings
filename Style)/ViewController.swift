//
//  ViewController.swift
//  Avrora
//
//  Created by Misha Fedorov on 26.03.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private var clickCountLabel = UILabel()
    private var clickButton = UIButton()
    private var count: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }


    private func setupUI() {
        view.addSubview(clickButton)
        view.addSubview(clickCountLabel)
        view.backgroundColor = .white
        setupButton()
        setupLabel()
    }

    private func setupButton() {
        clickButton.style {
            baseLayoutStyle
            pinkRoundedButtonStyle("Click") ~> {
                $0.layer.borderWidth = 2
                $0.layer.borderColor = UIColor.black.cgColor
            }
            buttonAction(self, #selector(clickButtonDidTap))
        }
    }

    
    private func setupLabel() {
        clickCountLabel.style {
            baseLayoutStyle
            textCenterLabelStyle
            textLabelStyle(String(count))
        }
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            clickCountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clickCountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            clickCountLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            clickCountLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18)
        ])

        NSLayoutConstraint.activate([
            clickButton.topAnchor.constraint(equalTo: clickCountLabel.bottomAnchor, constant: 50),
            clickButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -18),
            clickButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 18),
            clickButton.heightAnchor.constraint(equalToConstant: 47)
        ])
    }
    
    @objc private func clickButtonDidTap() {
        count += 1
        clickCountLabel.style {
            textLabelStyle(String(count))
        }
    }
}
