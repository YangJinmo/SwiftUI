//
//  ErrorAlertBootCamp.swift
//  Utils
//
//  Created by Jmy on 1/25/24.
//

import SwiftUI

struct ErrorAlertBootCamp: View {
    // @State private var errorTitle: String? = nil
    @State private var error: Error? = nil

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
        .alert(error?.localizedDescription ?? "Error", isPresented: Binding(value: $error)), actions: {
            Button(action: {
            }, label: {
                Text("OK")
            })
        }, message: {
            Text("MESSAGE GOES HERE")
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
            case .urlError(error: let error):
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
            case .urlError(error: let error):
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
            case .urlError(error: let error):
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
            let myError: Error = MyCustomError
        }
    }
}

#Preview {
    ErrorAlertBootCamp()
}
