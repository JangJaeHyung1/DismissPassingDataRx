//
//  SecondViewController.swift
//  RxTest01
//
//  Created by jh on 2021/12/02.
//

import UIKit
import RxSwift

class SecondViewController: UIViewController {
    @IBOutlet weak var secondBtn: UIButton!
    
    private var person2 = Model(name: "jh", age: 28)
    public let viewModel = ViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind(){
        secondBtn.rx.tap
            .debug()
            .subscribe(onNext:{ [unowned self] in
                self.save(person: self.person2)
            })
            .disposed(by: disposeBag)
    }
    
    func save(person: Model) {
        dismiss(animated: true) { [weak self] in
            self?.viewModel.person.onNext(person)
            self?.viewModel.person.onCompleted()
        }
    }
}
