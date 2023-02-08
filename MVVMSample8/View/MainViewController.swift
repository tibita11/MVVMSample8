//
//  MainViewController.swift
//  MVVMSample8
//
//  Created by 鈴木楓香 on 2023/02/08.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class MainViewController: UIViewController {
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    private let disposeBag = DisposeBag()
    private var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        // 初期設定
        viewModel = ViewModel()
        let input = ViewModelInput(changeButton: changeButton.rx.tap.asObservable())
        viewModel.setup(input: input)
        
        // label1更新処理
        viewModel.outputs?.label1Title
            .drive(label1.rx.text)
            .disposed(by: disposeBag)
        
        // label2更新処理
        viewModel.outputs?.label2Title
            .drive(label2.rx.text)
            .disposed(by: disposeBag)
        
        // label3更新処理
        viewModel.outputs?.label3Title
            .drive(label3.rx.text)
            .disposed(by: disposeBag)
        
        // label4更新処理
        viewModel.outputs?.label4Title
            .drive(label4.rx.text)
            .disposed(by: disposeBag)
    }


}
