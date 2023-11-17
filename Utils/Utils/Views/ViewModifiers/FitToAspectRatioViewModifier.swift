//
//  FitToAspectRatioViewModifier.swift
//  Utils
//
//  Created by Jmy on 2023/10/08.
//

import SwiftUI

/// https://gist.github.com/karigrooms/fdf435274f4403abd57b1ed533dcea53

/// Common aspect ratios
public enum AspectRatio: CGFloat {
    case square = 1
    case threeToFour = 0.75
    case fourToThree = 1.75
}

/// Fit an image to a certain aspect ratio while maintaining its aspect ratio
public struct FitToAspectRatioViewModifier: ViewModifier {
    private let aspectRatio: CGFloat

    public init(_ aspectRatio: CGFloat) {
        self.aspectRatio = aspectRatio
    }

    public init(_ aspectRatio: AspectRatio) {
        self.aspectRatio = aspectRatio.rawValue
    }

    public func body(content: Content) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(.clear))
                .aspectRatio(aspectRatio, contentMode: .fit)

            content
                .scaledToFill()
                .layoutPriority(-1)
        }
        .clipped()
    }
}

// Image extension that composes with the `.resizable()` modifier
public extension Image {
    func fitToAspectRatio(_ aspectRatio: CGFloat) -> some View {
        resizable().modifier(FitToAspectRatioViewModifier(aspectRatio))
    }

    func fitToAspectRatio(_ aspectRatio: AspectRatio) -> some View {
        resizable().modifier(FitToAspectRatioViewModifier(aspectRatio))
    }
}

public extension View {
    func fitToAspectRatio(_ aspectRatio: CGFloat) -> some View {
        modifier(FitToAspectRatioViewModifier(aspectRatio))
    }

    func fitToAspectRatio(_ aspectRatio: AspectRatio) -> some View {
        modifier(FitToAspectRatioViewModifier(aspectRatio))
    }
}
