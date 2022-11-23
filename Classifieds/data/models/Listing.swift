//
//  Listing.swift
//  Classifieds
//
//  Created by Ahmed Elzohry on 22/11/2022.
//

import Foundation

/*
 {
     "created_at": "2019-02-24 04:04:17.566515",
     "price": "AED 5",
     "name": "Notebook",
     "uid": "4878bf592579410fba52941d00b62f94",
     "image_ids": [
        "9355183956e3445e89735d877b798689"
     ],
     "image_urls": [
        "..."
     ],
     "image_urls_thumbnails": [
        "..."
     ]
     },
 */
struct Listing: Decodable {
    let uid: String
    let name: String
    let price: String
    let createdAt: Date
    let imageUrls: [String]
    let imageUrlsThumbnails: [String]
    
    var thumbnailUrl: URL? {
        guard let firstUrlString = imageUrlsThumbnails.first,
                let url = URL(string: firstUrlString) else { return nil }
        return url
    }
}

extension Listing: Identifiable {
    var id: String { uid }
}

extension Listing {
    static var sample: Listing {
        .init(
            uid: "4878bf592579410fba52941d00b62f94",
            name: "Notebook",
            price: "AED 5",
            createdAt: .now, //"2019-02-24 04:04:17.566515",
            imageUrls: [
                "https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689?AWSAccessKeyId=ASIASV3YI6A4UP5BBPXO&Signature=Sp4q7qPnwlaGGEwqa2iJb0KNtgo%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEKH%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIHrEhbhjDdj2E2UiE9zI2k6bep1GhIQ9uEanEO0oVe6yAiAGVl%2BDfYTMZqIMyqfCT5dJs72q7eGzhQH7RE2ViPDaayr7Agiq%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAQaDDE4NDM5ODk2Njg0MSIMpEaBnQSnNaheLjE3Ks8CPpCz0pWgWrFZ7BPzs0fJLnSbl%2B%2BlFi59pSqKPk7n61dwl7CJa%2B68UIwFp%2BYa33gjW7DCurmg2okF3ITFEy6hf2M7lTUEGfPiZ%2FbfzFZZn1h7lyUK4dckaVY1CBcpdQzN01r7ZC%2FYE%2F8vDCqDLTti74BzXqfZRwqCyY1CR4FH07zcxbeU9TeXjCViBKdzqGLLBWXcK69zphinQUQV8ZQ0VqFPlQFd%2BRPge5d1PIn64%2FRP12cyHNwcwtssCgjd52%2FKRDvXpix8In25p0LlB6qC4r%2FFm3MHkKKxDoDcIta2ryFH1F2v7bGseVBrVcrHJ9z0i8pS3ibJHzBYqELdvvnpyieimpIaaNxUdYbi%2B368T5vuQHHSz8sib4lLLjTL9mm6Zdjxcca2fXyPgu8OaF08KOOmfESXc7tXIK%2FsabVJkF0n%2BtOt4OO2BTN%2BY1b50lswsPXzmwY6nwFsgtWuDYDrvIf5%2BlJPqQo0yXNnoMkkWNetmqs%2FTJygnw6HPuE5V0MtLGgS3G8cR8c4hqLoO3k2WxqijjQZiMGvOaW0b%2FHrBERMFjvD1Aun3uIEFEcLbis2nv78ha8hKwp1qK2KcL1NyEdQIbpYaE9IhjM0uw0s8QHJcCtSikfkWK528pK5WM44HBgzBG130rAOINE4iYTh6SbUu6hkOUE%3D&Expires=1669138627"
            ],
            imageUrlsThumbnails: [
                "https://demo-app-photos-45687895456123.s3.amazonaws.com/9355183956e3445e89735d877b798689-thumbnail?AWSAccessKeyId=ASIASV3YI6A4UP5BBPXO&Signature=QVv2G%2FRXePMAX8karSvhJeRJHHg%3D&x-amz-security-token=IQoJb3JpZ2luX2VjEKH%2F%2F%2F%2F%2F%2F%2F%2F%2F%2FwEaCXVzLWVhc3QtMSJGMEQCIHrEhbhjDdj2E2UiE9zI2k6bep1GhIQ9uEanEO0oVe6yAiAGVl%2BDfYTMZqIMyqfCT5dJs72q7eGzhQH7RE2ViPDaayr7Agiq%2F%2F%2F%2F%2F%2F%2F%2F%2F%2F8BEAQaDDE4NDM5ODk2Njg0MSIMpEaBnQSnNaheLjE3Ks8CPpCz0pWgWrFZ7BPzs0fJLnSbl%2B%2BlFi59pSqKPk7n61dwl7CJa%2B68UIwFp%2BYa33gjW7DCurmg2okF3ITFEy6hf2M7lTUEGfPiZ%2FbfzFZZn1h7lyUK4dckaVY1CBcpdQzN01r7ZC%2FYE%2F8vDCqDLTti74BzXqfZRwqCyY1CR4FH07zcxbeU9TeXjCViBKdzqGLLBWXcK69zphinQUQV8ZQ0VqFPlQFd%2BRPge5d1PIn64%2FRP12cyHNwcwtssCgjd52%2FKRDvXpix8In25p0LlB6qC4r%2FFm3MHkKKxDoDcIta2ryFH1F2v7bGseVBrVcrHJ9z0i8pS3ibJHzBYqELdvvnpyieimpIaaNxUdYbi%2B368T5vuQHHSz8sib4lLLjTL9mm6Zdjxcca2fXyPgu8OaF08KOOmfESXc7tXIK%2FsabVJkF0n%2BtOt4OO2BTN%2BY1b50lswsPXzmwY6nwFsgtWuDYDrvIf5%2BlJPqQo0yXNnoMkkWNetmqs%2FTJygnw6HPuE5V0MtLGgS3G8cR8c4hqLoO3k2WxqijjQZiMGvOaW0b%2FHrBERMFjvD1Aun3uIEFEcLbis2nv78ha8hKwp1qK2KcL1NyEdQIbpYaE9IhjM0uw0s8QHJcCtSikfkWK528pK5WM44HBgzBG130rAOINE4iYTh6SbUu6hkOUE%3D&Expires=1669138627"
            ]
        )
    }
}
