//
//  ContentView.swift
//  PHPicker
//
//  Created by Jmy on 2023/06/02.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
    @StateObject var photoPickerService = PhotoPickerService()

    var body: some View {
        NavigationView {
            VStack {
                if photoPickerService.results.isEmpty {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 200))
                        .foregroundColor(.gray)
                        .opacity(0.2)
                } else {
                    ScrollView {
                        ForEach(photoPickerService.results, id: \.self) { result in
                            PhotoPickerResultView(result: result)
                                .scaledToFill()
                                .frame(maxWidth: .infinity, minHeight: 200, idealHeight: 200)
                                .clipped()
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        photoPickerService.results.removeAll()
                    } label: {
                        Image(systemName: "trash")
                    }
                    .buttonStyle(.bordered)
                }

                ToolbarItemGroup(placement: .primaryAction) {
                    VStack {
                        HStack {
                            Button {
                                photoPickerService.present(filters: [.videos, .images, .livePhotos], selectionLimit: 0)
                            } label: {
                                Image(systemName: "photo.on.rectangle.angled")
                            }

                            Divider()

                            Button {
                                photoPickerService.present(filters: [.videos], selectionLimit: 1)
                            } label: {
                                Image(systemName: "play.rectangle")
                            }

                            Button {
                                photoPickerService.present(filters: [.images], selectionLimit: 0)
                            } label: {
                                Image(systemName: "photo")
                            }

                            Button {
                                photoPickerService.present(filters: [.livePhotos], selectionLimit: 3)
                            } label: {
                                Image(systemName: "livephoto")
                            }
                        }
                    }
                }
            }
            .sheet(isPresented: $photoPickerService.isPresented) {
                PhotoPicker(service: photoPickerService)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
