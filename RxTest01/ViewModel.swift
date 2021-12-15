//
//  ViewModel.swift
//  RxTest01
//
//  Created by jh on 2021/12/02.
//

import Foundation
import RxSwift

final class ViewModel {
    let model = PublishSubject<Model>()
    let person = PublishSubject<Model>()
}

