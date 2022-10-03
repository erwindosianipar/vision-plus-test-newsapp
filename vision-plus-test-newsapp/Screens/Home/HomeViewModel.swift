//
//  HomeViewModel.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

import RxSwift

internal final class HomeViewModel {
    
    var news: [NewsResponseModel] = []
    
    func articles() -> Observable<[NewsResponseModel]> {
        return Observable.create { observer in
            APIProvider.dataRequest(endpoint: NewsEndpoint.articles, body: [:], response: [NewsResponseModel].self) { result in
                switch result {
                case .success(let result):
                    observer.onNext(result)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
