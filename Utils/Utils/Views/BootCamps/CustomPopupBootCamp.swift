//
//  CustomPopupBootCamp.swift
//  Utils
//
//  Created by Jmy on 1/24/24.
//

import SwiftUI

struct CustomPopupBootCamp: View {
    @State private var isShow = false

    var body: some View {
        VStack {
            Button("Show Popup") {
                withAnimation(.spring(duration: 0.25)) {
                    isShow.toggle()
                }
            }
            .padding()
        }
        .popup(
            isShow: $isShow,
            title: "Title",
            message: "lorem ipsum is simply dummy text of the printing and typesetting industry"
        )
    }
}

#Preview {
    CustomPopupBootCamp()

    if #available(iOS 17.0, *) {
//        CustomPopupDemo()
    } else {
        // Fallback on earlier versions
    }
}

import SwiftUI

struct CustomPopupModifier: ViewModifier {
    @Binding var isShow: Bool
    var title: String
    var message: String

    func body(content: Content) -> some View {
        ZStack {
            content

            if isShow {
                Color.black.opacity(0.5)
                    .transition(.opacity)

                VStack(spacing: 16) {
                    Text(title)
                        .font(.headline)

                    Text(message)
                        .font(.subheadline)

                    Button {
                        withAnimation(.spring(duration: 0.25)) {
                            isShow.toggle()
                        }
                    } label: {
                        Text("OK")
                            .buttonStyle(.plain)
                            .font(.headline)
                            .foregroundColor(.gray800)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .padding(.horizontal, 20)
                            .background(Color.accentColor)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.scale)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func popup(isShow: Binding<Bool>, title: String, message: String) -> some View {
        modifier(CustomPopupModifier(isShow: isShow, title: title, message: message))
    }
}

import SwiftUI

struct CustomPopupView: View {
    @Binding var showPopup: Bool
    let title: String
    let message: String

    var body: some View {
        ZStack {
            if showPopup {
                // Dimmed background
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            showPopup = false
                        }
                    }

                // Popup content
                VStack(spacing: 20) {
                    Text(title)
                        .font(.headline)

                    Text(message)
                        .multilineTextAlignment(.center)

                    Button("Close") {
                        withAnimation {
                            showPopup = false
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 10)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

@available(iOS 17.0, *)
struct CustomPopupDemo: View {
    @State private var isPresented = false

    var body: some View {
        VStack {
            Button("Show Popup") {
                withAnimation {
                    isPresented = true
                }
            }
        }
        .popupView(isPresented: $isPresented, content: CustomDialogView.init)
    }
}

@available(iOS 17.0, *)
struct CustomDialogView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            VStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(.yellow, in: .circle)

                Text("Important Notice")
                    .font(.largeTitle)
                    .bold()

                Text("Please ensure you have backed up your data before proceeding.")
                    .font(.body)
                    .multilineTextAlignment(.center)
            }
            .padding()

            Spacer()

            Button("Dismiss") {
                dismiss()
            }
            .padding()
        }
        .containerRelativeFrame(.vertical) { height, _ in height / 2 }
        .containerRelativeFrame(.horizontal) { width, _ in width / 1.2 }
        .background(.thinMaterial, in: .rect(cornerRadius: 20, style: .continuous))
        .presentationBackground(.clear)
    }
}

@available(iOS 16.4, *)
struct PopViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let modalContent: AnyView
    @State private var isAnimate = false

    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented) {
                if isAnimate {
                    modalContent
                        .transition(.scale)

                } else {
                    ZStack { }
                        .presentationBackground(.clear)
                }
            }
            .transaction { transaction in
                if isAnimate == false {
                    transaction.disablesAnimations = true
                }
            }
            .onChange(of: isPresented) { newValue in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        isAnimate = newValue
                    }
                }
            }
    }
}

@available(iOS 16.4, *)
extension View {
    func popupView<ModalContent: View>(isPresented: Binding<Bool>, content: @escaping () -> ModalContent) -> some View {
        let modalContent = AnyView(content())
        return modifier(PopViewModifier(isPresented: isPresented, modalContent: modalContent))
    }
}
