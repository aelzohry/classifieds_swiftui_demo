//
//  CachedAsyncImage.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import SwiftUI
import Combine

struct CachedAsyncImage<Placeholder: View, ErrorView: View, ImageView: View>: View {
    
    private let placeholder: Placeholder
    private let error: (Error) -> ErrorView
    private let image: (UIImage) -> ImageView
    
    @ObservedObject private var imageLoader: ImageLoader
    
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder = ProgressView.init,
        @ViewBuilder error: @escaping (Error) -> ErrorView = { _ in EmptyView() },
        @ViewBuilder image: @escaping (UIImage) -> ImageView = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.error = error
        self.image = image
        imageLoader = ImageLoader(url: url, cache: Environment(\.imageCache).wrappedValue)
        imageLoader.load()
    }
    
    var body: some View {
        ZStack {
            switch imageLoader.state {
            case .idle, .loading:
                placeholder
                
            case .loaded(let image):
                self.image(image)
                
            case .failed(let error):
                self.error(error)
            }
        }
    }
}

struct CachedAsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        CachedAsyncImage(
            url: URL(string: "https://image.dummyjson.com/150")!,
            error: { _ in Text("Error") }
        )
    }
}
