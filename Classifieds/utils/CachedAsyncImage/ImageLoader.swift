//
//  ImageLoader.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    enum LoadingState {
        case idle
        case loading
        case loaded(UIImage)
        case failed(Error)
    }
    
    struct NotValidImageError: Error { }
    
    private let url: URL
    private var cache: ImageCache?
    
    @Published
    private(set) var state: LoadingState = .idle
    
    private var cancellable: AnyCancellable?

    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    func load() {
        state = .loading
        
        if let image = cache?[url] {
            self.state = .loaded(image)
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                if let image = UIImage(data: $0.data) {
                    return image
                } else {
                    throw NotValidImageError()
                }
            }
            .map(LoadingState.loaded)
            .catch { error in
                Just(.failed(error))
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.state = state
                if case let .loaded(image) = state {
                    self?.save(image)
                }
            }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    private func save(_ image: UIImage?) {
        cache?[url] = image
    }
    
}
