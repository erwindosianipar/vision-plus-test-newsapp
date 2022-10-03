//
//  DetailScreen.swift
//  vision-plus-test-newsapp
//
//  Created by Erwindo Sianipar on 03/10/22.
//

let kDetailScreen = "Detail Screen"

internal final class DetailScreen: Screen<NewsResponseModel> {
    
    override var identifier: String {
        return kDetailScreen
    }
    
    override func build() -> ViewController {
        let viewModel = DetailViewModel(screenResult: input)
        let viewController = DetailViewController(viewModel: viewModel)
        
        viewController.navigationEvent.on({ navigation in
            self.event?(navigation)
        })
        
        return viewController
    }
}
