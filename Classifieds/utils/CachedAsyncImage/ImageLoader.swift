//
//  ImageLoader.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 23/11/2022.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    // MARK: - Types
    
    enum LoadingState {
        case idle
        case loading
        case loaded(UIImage)
        case failed(Error)
    }
    
    struct NotValidImageError: Error { }
    
    // MARK: - Dependencies
    
    private let url: URL
    private var cache: ImageCache?
    
    // MARK: - Properties
    
    @Published
    private(set) var state: LoadingState = .idle
    
    private var cancellable: AnyCancellable?
    
    // MARK: - LifeCycle

    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }
    
    // MARK: - Actions
    
    func load() {
        state = .loading
        
        if let image = cache?[url] {
            self.state = .loaded(image)
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap {
                guard let image = UIImage(data: $0.data) else {
                    throw NotValidImageError()
                }
                
                return image
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
    
    // MARK: - Helpers
    
    private func save(_ image: UIImage?) {
        cache?[url] = image
    }
    
}
