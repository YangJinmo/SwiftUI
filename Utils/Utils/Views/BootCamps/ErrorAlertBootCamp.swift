//
//  ErrorAlertBootCamp.swift
//  Utils
//
//  Created by Jmy on 1/25/24.
//

import SwiftUI

protocol AppAlert {
    var title: String { get }
    var subtitle: String? { get }
    var buttons: AnyView { get }
}

extension View {
    func showCustomAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self.alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert)) {
            alert.wrappedValue?.buttons
        } message: {
            if let subtitle = alert.wrappedValue?.subtitle {
                Text(subtitle)
            }
        }
    }
}

struct ErrorAlertBootCamp: View {
    // @State private var errorTitle: String? = nil
    // @State private var error: Error? = nil
    @State private var alert: MyCustomAlert? = nil

    var body: some View {
        Button {
            saveData()
        } label: {
            Text("CLICK ME")
        }
        .showCustomAlert(alert: $alert)
//        .alert(errorTitle ?? "Error", isPresented: Binding(value: $errorTitle)) {
//            Button(action: {
//            }, label: {
//                Text("OK")
//            })
//        }
//        .alert(error?.localizedDescription ?? "Error", isPresented: Binding(value: $error)), actions: {
//            Button(action: {
//            }, label: {
//                Text("OK")
//            })
//        }, message: {
//            Text("MESSAGE GOES HERE")
//        }
//        .alert(alert?.title ?? "Error", isPresented: Binding(value: $alert)) {
//            if let alert {
//                getButtonsForAlert(alert: alert)
//            }
//            alert?.getButtonsForAlert
//        } message: {
//            if let subtitle = alert?.subtitle {
//                Text(subtitle)
//            }
//        }
    }

    @ViewBuilder
    private func getButtonsForAlert(alert: MyCustomAlert) -> some View {
        switch alert {
        case .noInternetConnection:
            Button(action: {
            }, label: {
                Text("OK")
            })
        case .dataNotFound:
            Button(action: {
            }, label: {
                Text("RETRY")
            })
        default:
            Button("Delete", role: .destructive) {
            }
        }
    }

//    enum MyCustomError: Error, LocalizedError {
//        case noInternetConnection
//        case dataNotFound
//        case urlError(error: Error)
//
//        var errorDescription: String? {
//            switch self {
//            case .noInternetConnection:
//                return "Please check you internet connection and try again."
//            case .dataNotFound:
//                return "There was an error loading data. Please try again!"
//            case let .urlError(error: error):
//                return "Error: \(error.localizedDescription)"
//            }
//        }
//    }

    enum MyCustomAlert: Error, LocalizedError, AppAlert {
        case noInternetConnection(onOkPressed: () -> Void, onRetryPressed: () -> Void)
        case dataNotFound
        case urlError(error: Error)

        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Please check you internet connection and try again."
            case .dataNotFound:
                return "There was an error loading data. Please try again!"
            case let .urlError(error: error):
                return "Error: \(error.localizedDescription)"
            }
        }

        var title: String {
            switch self {
            case .noInternetConnection:
                return "No Internet Connection"
            case .dataNotFound:
                return "No Data"
            case .urlError:
                return "Error"
            }
        }

        var subtitle: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return nil
            case let .urlError(error: error):
                return "Error: \(error.localizedDescription)"
            }
        }

        var buttons: AnyView {
            AnyView(getButtonsForAlert)
        }

        @ViewBuilder
        var getButtonsForAlert: some View {
            switch self {
            case let .noInternetConnection(onOkPressed: onOkPressed, onRetryPressed: onRetryPressed):
                HStack {
                    Button(action: {
                        onOkPressed()
                    }, label: {
                        Text("OK")
                    })

                    Button(action: {
                        onRetryPressed()
                    }, label: {
                        Text("RETRY")
                    })
                }
            case .dataNotFound:
                Button(action: {
                }, label: {
                    Text("RETRY")
                })
            default:
                Button("Delete", role: .destructive) {
                }
            }
        }
    }

    private func saveData() {
        let isSuccessful = false

        if isSuccessful {
            // do something
        } else {
            // error

            // errorTitle = "An error occured!"
            // let myError: Error = URLError(.badURL)
            // let myError: Error = MyCustomError.urlError(error: URLError(.badURL))
            // error = myError

            // let alert = MyCustomAlert = .dataNotFound
            alert = .noInternetConnection(onOkPressed: {
                print("onOkPressed")
            }, onRetryPressed: {
                print("onRetryPressed")
            })
        }
    }
}

#Preview {
    ErrorAlertBootCamp()
}
