//
//  ErrorAlertBootCamp.swift
//  Utils
//
//  Created by Jmy on 1/25/24.
//

import SwiftUI

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
        .alert(alert?.title ?? "Error", isPresented: Binding(value: $alert)) {
            if let alert {
                getButtonsForAlert(alert: alert)
            }
        } message: {
            if let subtitle = alert?.subtitle {
                Text(subtitle)
            }
        }
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

    enum MyCustomError: Error, LocalizedError {
        case noInternetConnection
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
    }

    enum MyCustomAlert: Error, LocalizedError {
        case noInternetConnection
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
            alert = .noInternetConnection
        }
    }
}

#Preview {
    ErrorAlertBootCamp()
}
