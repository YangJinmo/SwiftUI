//
//  LottieView.swift
//  Utils
//
//  Created by Jmy on 2023/08/23.
//

import Combine
import Lottie
import SwiftUI

struct LottieView: UIViewRepresentable {
    typealias UIViewType = UIView

    var type: AnimationType = .loading
    var progress: Double = 0
    var completed: (() -> Void)?

    enum AnimationType: String {
        case loading

        var name: String {
            rawValue
        }

        var start: CGFloat {
            switch self {
            case .loading: return 2
            }
        }

        var end: CGFloat {
            switch self {
            case .loading: return 157
            }
        }

        var complete: CGFloat {
            switch self {
            case .loading: return 210
            }
        }
    }

    func makeUIView(context: Context) -> UIView {
        let progressLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 17, weight: .bold)
            label.textColor = UIColor(.limeGreen)
            label.text = Int((progress * 100).rounded()).description
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        let animationView: LottieAnimationView = {
            let animationView = LottieAnimationView(name: type.name)
            animationView.currentProgress = CGFloat(progress)
            animationView.translatesAutoresizingMaskIntoConstraints = false
            return animationView
        }()

        let view = UIView(frame: .zero)
        view.addSubview(progressLabel)
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            progressLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 140),
            animationView.widthAnchor.constraint(equalToConstant: 140),
        ])

        animationView.play(fromFrame: type.start, toFrame: type.end, loopMode: .loop)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let progressLabel = uiView.subviews.compactMap({ $0 as? UILabel }).first {
            progressLabel.text = Int((progress * 100).rounded()).description
        }

        if progress == 1.0, let animationView = uiView.subviews.compactMap({ $0 as? LottieAnimationView }).first {
            animationView.play(fromFrame: type.end, toFrame: type.complete, loopMode: .playOnce) { played in
                if played {
                    completed?()
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: LottieView

        init(_ parent: LottieView) {
            self.parent = parent
        }
    }
}

#Preview {
    LottieView(type: .loading, progress: 1)
}
