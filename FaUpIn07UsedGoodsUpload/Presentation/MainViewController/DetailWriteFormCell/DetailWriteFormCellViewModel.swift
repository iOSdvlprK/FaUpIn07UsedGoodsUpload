//
//  DetailWriteFormCellViewModel.swift
//  FaUpIn07UsedGoodsUpload
//
//  Created by joe on 6/9/24.
//

import RxSwift
import RxCocoa

struct DetailWriteFormCellViewModel {
    // View -> ViewModel
    let contentValue = PublishRelay<String?>()
}
