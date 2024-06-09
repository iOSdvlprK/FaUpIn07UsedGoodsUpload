//
//  MainViewModel.swift
//  FaUpIn07UsedGoodsUpload
//
//  Created by joe on 6/4/24.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let titleTextFieldCellViewModel = TitleTextFieldCellViewModel()
    let priceTextFieldCellViewModel = PriceTextFieldCellViewModel()
    let detailWriteFormCellViewModel = DetailWriteFormCellViewModel()
    
    // ViewModel -> View
    let cellData: Driver<[String]>
    let presentAlert: Signal<Alert>
    let push: Driver<CategoryViewModel>
    
    // View -> ViewModel
    let itemSelected = PublishRelay<Int>()
    let submitButtonTapped = PublishRelay<Void>()
    
    init(model: MainModel = MainModel()) {
        let title = Observable.just("post title")
        let categoryViewModel = CategoryViewModel()
        let category = categoryViewModel
            .selectedCategory
            .map { $0.name }
            .startWith("Select a category")
        
        let price = Observable.just("$ price (optional)")
        let detail = Observable.just("Please enter the content")
        
        self.cellData = Observable
            .combineLatest(
                title,
                category,
                price,
                detail
            ) { [$0, $1, $2, $3] }
            .asDriver(onErrorJustReturn: [])
        
        let titleMessage = titleTextFieldCellViewModel
            .titleText
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- Enter post title"] : [] }
        
        let categoryMessage = categoryViewModel
            .selectedCategory
            .map { _ in false }
            .startWith(true)
            .map { $0 ? ["- Select a category"] : [] }
        
        let detailMessage = detailWriteFormCellViewModel
            .contentValue
            .map { $0?.isEmpty ?? true }
            .startWith(true)
            .map { $0 ? ["- Please enter the content"] : [] }
        
        let errorMessage = Observable
            .combineLatest(
                titleMessage,
                categoryMessage,
                detailMessage
            ) { $0 + $1 + $2 }
        
        self.presentAlert = submitButtonTapped
            .withLatestFrom(errorMessage)
            .map(model.setAlert)
            .asSignal(onErrorSignalWith: .empty())
        
        self.push = itemSelected
            .compactMap { row -> CategoryViewModel? in
                guard case 1 = row else { return nil }
                return categoryViewModel
            }
            .asDriver(onErrorDriveWith: .empty())
    }
}
