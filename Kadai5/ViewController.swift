//
//  ViewController.swift
//  Kadai5
//
//  Created by daiki umehara on 2021/06/03.
//

import UIKit

enum CalcError: Error {
    case invalidCalculation(String)
}

typealias CalcCompletionHandler<T> = (Result<T, CalcError>) -> Void

protocol CalculatorProtocol {
    func calculate(num1: Double, num2: Double, completion: CalcCompletionHandler<Double>)
}

class ViewController: UIViewController {
    @IBOutlet private var divideView: CalculateView!
    @IBOutlet private var answerLabel: UILabel!

    private let calculator: CalculatorProtocol = DivisionCalculator()

    override func viewDidLoad() {
        super.viewDidLoad()
        divideView.configure(calculation: .division)
    }

    @IBAction private func didTapCalcButton(_ sender: Any) {
        guard let firstValue = divideView.firstValue else {
            makeAndShowAlert(message: "左側に数字を入力してください")
            return
        }
        guard let secondValue = divideView.secondValue else {
            makeAndShowAlert(message: "右側に数字を入力してください")
            return
        }

        calculator.calculate(num1: firstValue, num2: secondValue, completion: {
            switch $0 {
            case .success(let value):
                answerLabel.text = String(value)
            case .failure(.invalidCalculation(let message)):
                makeAndShowAlert(message: message)
            }
        })
    }

    private func makeAndShowAlert(message: String) {
        let alert = UIAlertController(title: "課題5", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
