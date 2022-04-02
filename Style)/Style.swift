//
//  StyleCore.swift
//  Avrora
//
//  Created by Misha Fedorov on 26.03.2022.
//

import Foundation
import UIKit

typealias SingleStyle<T> = (T) -> Void

precedencegroup StylePrecedence {
    associativity: left
}

infix operator ~>: StylePrecedence

func ~> <T>(_ first: @escaping SingleStyle<T>,
            _ second: @escaping SingleStyle<T>) -> SingleStyle<T> {
    return {
        first($0)
        second($0)
    }
}

@resultBuilder
struct StyleBuilder<T> {
    static func buildBlock(_ components: SingleStyle<T>...) -> [SingleStyle<T>] {
        components
    }
}

protocol View {}

extension UIView: View {}

extension View {
    func style(@StyleBuilder<Self> _ styles: () -> [SingleStyle<Self>]) {
        styles().forEach {
            $0(self)
        }
    }
}


//MARK: Label styles
/// Base style
let baseLayoutStyle: SingleStyle<UIView> = {
    $0.translatesAutoresizingMaskIntoConstraints = false
}

let baseLabelStyle: SingleStyle<UILabel> = {
    $0.numberOfLines = 0
    $0.lineBreakMode = .byCharWrapping
    $0.font = .systemFont(ofSize: 30, weight: .heavy)
    $0.textColor = .darkGray
}

let textCenterLabelStyle = baseLabelStyle ~> {
    $0.textAlignment = .center
}

let textLabelStyle: (String) -> SingleStyle<UILabel> = { text in
    {
        $0.text = text
    }
}

//MARK: Button styles

let baseButtonStyle: SingleStyle<UIButton> = {
    $0.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
}

let roundedButtonStyle: SingleStyle<UIButton> = {
    $0.layer.cornerRadius = 10
}

let pinkButtonStyle: SingleStyle<UIButton> = baseButtonStyle ~> {
    $0.backgroundColor = .systemPink
    $0.setTitleColor(UIColor.white, for: .normal)
    $0.setTitleColor(UIColor.white.withAlphaComponent(0.5), for: .highlighted)
}

let pinkRoundedButtonStyle: (String) -> SingleStyle<UIButton> = { title in
    pinkButtonStyle ~> roundedButtonStyle ~> {
        $0.setTitle(title, for: .normal)
    }
}

let buttonAction: (Any?, Selector) -> SingleStyle<UIButton> = { obj, selector in
    return {
        $0.addTarget(obj, action: selector, for: .touchUpInside)
    }
}
