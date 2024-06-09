//
//  CategoryViewModel.swift
//  FaUpIn07UsedGoodsUpload
//
//  Created by joe on 6/8/24.
//

import RxSwift
import RxCocoa

struct CategoryViewModel {
    let disposeBag = DisposeBag()
    
    // ViewModel -> View
    let cellData: Driver<[Category]>
    let pop: Signal<Void>
    
    // View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    
    // ViewModel -> ParentsViewModel
    let selectedCategory = PublishSubject<Category>()
    
    init() {
        let categories = [
            Category(id: 1, name: "digital/appliances"),
            Category(id: 2, name: "games"),
            Category(id: 3, name: "sports/leisure"),
            Category(id: 4, name: "infant/child goods"),
            Category(id: 5, name: "wm's fashion/misc goods"),
            Category(id: 6, name: "beauty/cosmetics"),
            Category(id: 7, name: "men's fashion/misc goods"),
            Category(id: 8, name: "living/food"),
            Category(id: 9, name: "furniture"),
            Category(id: 10, name: "books/tickets/hobbies"),
            Category(id: 11, name: "etc.")
        ]
        
        self.cellData = Driver.just(categories)
        
        self.itemSelected
            .map { categories[$0] }
            .bind(to: selectedCategory)
            .disposed(by: disposeBag)
        
        self.pop = itemSelected
            .map { _ in Void() }
            .asSignal(onErrorSignalWith: .empty())
    }
}
