//
//  Button.swift
//  Buttons
//
//  Created by Igor Tumanov on 06.09.2023.
//

import UIKit

final class Button: UIButton {

    private var downscaleAnimator: UIViewPropertyAnimator?
    private var upscaleAnimator: UIViewPropertyAnimator?
    private var isDisabledByPresentingModally = false

    convenience init(title: String?, image: UIImage?) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.titleAlignment = .leading

        configuration.image = image
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 8

        configuration.contentInsets = .init(top: 10, leading: 14, bottom: 10, trailing: 14)

        var background = UIBackgroundConfiguration.clear()
        background.backgroundColor = .systemBlue
        background.cornerRadius = 12

        configuration.background = background
        configuration.baseForegroundColor = .white

        self.init(configuration: configuration)

        configurationUpdateHandler = { button in
            switch button.state {

            case .normal:
                button.configuration?.background.backgroundColor = .systemBlue
                button.configuration?.baseForegroundColor = .white

            case .disabled:
                button.configuration?.background.backgroundColor = .systemGray2
                button.configuration?.baseForegroundColor = .systemGray3

            default:
                break
            }
        }
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()

        isDisabledByPresentingModally.toggle()
        isEnabled = !isDisabledByPresentingModally
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        upscaleAnimator?.stopAnimation(true)
        downscaleAnimator?.stopAnimation(true)

        downscaleAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [weak self] in
            self?.transform = .init(scaleX: 0.85, y: 0.85)
        }

        downscaleAnimator?.startAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        downscaleAnimator?.stopAnimation(true)
        downscaleAnimator?.finishAnimation(at: .current)

        upscaleAnimator = UIViewPropertyAnimator(duration: 0.1, curve: .linear) { [weak self] in
            self?.transform = .identity
        }

        upscaleAnimator?.startAnimation()
    }
}
