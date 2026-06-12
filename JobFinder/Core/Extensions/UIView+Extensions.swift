//
//  UIView+Extensions.swift
//  JobFinder
//
//  Created by Gursimran Singh on 12/06/26.
//

import UIKit

extension UIView {

    func pinToSuperview(
        withInsets insets: UIEdgeInsets = .zero
    ) {

        guard let superview = superview else {
            return
        }

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            topAnchor.constraint(
                equalTo: superview.topAnchor,
                constant: insets.top
            ),

            leadingAnchor.constraint(
                equalTo: superview.leadingAnchor,
                constant: insets.left
            ),

            trailingAnchor.constraint(
                equalTo: superview.trailingAnchor,
                constant: -insets.right
            ),

            bottomAnchor.constraint(
                equalTo: superview.bottomAnchor,
                constant: -insets.bottom
            )
        ])
    }
    
    func pinToSafeArea(
        of view: UIView
    ) {

        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),

            leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),

            trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),

            bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
    }
    
    func centerInSuperview() {

            guard let superview = superview else { return }

            translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                centerXAnchor.constraint(
                    equalTo: superview.centerXAnchor
                ),
                centerYAnchor.constraint(
                    equalTo: superview.centerYAnchor
                )
            ])
        }
}

