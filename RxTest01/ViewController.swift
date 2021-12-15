//
//  ViewController.swift
//  RxTest01
//
//  Created by jh on 2021/12/02.
//

import UIKit
import RxCocoa
import RxSwift



class ViewController: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    @IBOutlet weak var setBtn: UIButton!
    @IBOutlet weak var presentSecondVCBtn: UIButton!
    
    private let viewModel = ViewModel()
    private var disposeBag = DisposeBag()
    
    private var person1 = Model(name: "김민수", age: 26)
    private var person = BehaviorRelay<[Model]>(value: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    func bind(){
        
        // 버튼누르면 viewModel로 값 전달
        setBtn.rx.tap.asObservable()
            .subscribe(onNext:{ [unowned self] in
                viewModel.model.onNext(self.person1)
            })
            .disposed(by: disposeBag)
        
        // 값 바뀌면 ui 수정
        viewModel.model.asObserver()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] person in
                self.nameLbl.text = person.name
                self.ageLbl.text = "\(person.age)"
            })
            .disposed(by: disposeBag)
        
//        presentSecondVCBtn.rx.tap
//            .flatMap(presentModal)
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { [weak self] (person) in
//                self?.nameLbl.text = person.name
//                self?.ageLbl.text = "\(person.age)"
//            })
//            .disposed(by: disposeBag)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let secondVC = segue.destination as? SecondViewController else {
            fatalError("Controller not found")
        }
        secondVC.viewModel.person
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [unowned self] person in
                self.nameLbl.text = person.name
                self.ageLbl.text = "\(person.age)"
            })
            .disposed(by: disposeBag)
    }
    
    
    func presentModal() -> Observable<Model> {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destVC = storyboard.instantiateViewController(withIdentifier: "secondVC") as! SecondViewController
        self.present(destVC, animated: true, completion: nil)
        return destVC.viewModel.person
    }
}

