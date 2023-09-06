//
//  ViewController.swift
//  Buttons
//
//  Created by Igor Tumanov on 04.09.2023.
//

import UIKit

final class ViewController: UIViewController {

    private let firstButton = Button(
        title: "First Button",
        image: .init(systemName: "arrow.forward.circle")
    )
    private let secondButton = Button(
        title: "Second Medium Button",
        image: .init(systemName: "arrow.forward.circle")
    )
    private let thirdButton = Button(
        title: "Third",
        image: .init(systemName: "arrow.forward.circle")
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        thirdButton.addAction(
            UIAction { [weak self] _ in
                let vc = UIViewController()
                vc.view.backgroundColor = .white
                self?.present(vc, animated: true)
            },
            for: .touchUpInside
        )

        layout()
    }

    private func layout() {
        [firstButton, secondButton, thirdButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            firstButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            secondButton.topAnchor.constraint(equalTo: firstButton.bottomAnchor, constant: 16),
            secondButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            thirdButton.topAnchor.constraint(equalTo: secondButton.bottomAnchor, constant: 16),
            thirdButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
