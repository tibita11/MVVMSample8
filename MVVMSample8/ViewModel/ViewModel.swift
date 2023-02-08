//
//  ViewModel.swift
//  MVVMSample8
//
//  Created by 鈴木楓香 on 2023/02/08.
//

import Foundation
import RxSwift
import RxCocoa
import RxOptional

struct ViewModelInput {
    let changeButton: Observable<Void>
}

protocol ViewModelOutput {
    var label1Title: Driver<String> { get }
    var label2Title: Driver<String> { get }
    var label3Title: Driver<String> { get }
    var label4Title: Driver<String> { get }
}

protocol ViewModelType {
    var outputs: ViewModelOutput? { get }
    func setup(input: ViewModelInput)
}

class ViewModel: ViewModelType {
    var outputs: ViewModelOutput?
    
    let disposeBag = DisposeBag()
    /// label1の更新
    var labelt1TitleObservable: Observable<String>!
    /// label2の更新
    var labelt2TitleObservable: Observable<String>!
    /// label3の更新
    var labelt3TitleObservable: Observable<String>!
    /// label4の更新
    var labelt4TitleObservable: Observable<String>!
    
    init() {
        // 初期化
        self.outputs = self
    }
    
    /// 購読処理
    func setup(input: ViewModelInput) {
        let changeButtonObservable = input.changeButton.share()
        
        labelt1TitleObservable = changeButtonObservable
            .flatMap { return Observable<String>.create { observer in
                observer.onNext("Happy!")
                return Disposables.create()
            } }
        
        labelt2TitleObservable = changeButtonObservable
            .flatMap { return Observable<String>.create { observer in
                observer.onNext("Lucky!!")
                return Disposables.create()
            } }
        
        labelt3TitleObservable = changeButtonObservable
            .flatMap { return Observable<String>.create { observer in
                observer.onNext("Enjoy!!!")
                return Disposables.create()
            } }
        
        labelt4TitleObservable = changeButtonObservable
            .flatMap { return Observable<String>.create { observer in
                observer.onNext("💙💚💛")
                return Disposables.create()
            } }
            
    }
    
    
}

extension ViewModel: ViewModelOutput {
    var label1Title: Driver<String> {
        return labelt1TitleObservable
            .asDriver(onErrorJustReturn: "")
    }
    
    var label2Title: Driver<String> {
        return labelt2TitleObservable
            .asDriver(onErrorJustReturn: "")
    }
    
    var label3Title: Driver<String> {
        return labelt3TitleObservable
            .asDriver(onErrorJustReturn: "")
    }
    
    var label4Title: Driver<String> {
        return labelt4TitleObservable
            .asDriver(onErrorJustReturn: "")
    }
}
