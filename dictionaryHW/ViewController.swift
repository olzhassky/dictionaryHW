//
//  ViewController.swift
//  dictionaryHW
//
//  Created by Olzhas Zhakan on 18.08.2023.
//

import UIKit
import Alamofire
import SnapKit

class ViewController: UIViewController {
    var historyArray: [String] = []
    let textRU: UITextField = {
        let label = UITextField()
        label.placeholder = "Введите текст"
        return label
    }()
    
    let result: UILabel = {
        let label = UILabel()
        label.text = "Перевод"
        return label
    }()
    let translate: UIButton = {
        let button = UIButton()
        button.setTitle("Translate", for: .normal)
        button.addTarget(self, action: #selector(translateButton), for: .touchUpInside)
        button.configuration = .filled()
        return button
    }()
    let history: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(historyButton), for: .touchUpInside)
        button.setTitle("History", for: .normal)
        button.configuration = .filled()
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textRU)
        view.addSubview(result)
        view.addSubview(translate)
        view.addSubview(history)
        makeConstraints()
  
    }
    func makeConstraints() {
        textRU.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(50)
        }
        translate.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(textRU.snp.bottom).offset(100)
        }
        result.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(translate.snp.bottom).offset(100)
        }
        history.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(50)
            $0.left.right.equalToSuperview()
            
        }
    }
    
    @objc func translateButton() {
            guard let text = textRU.text, !text.isEmpty else {
                result.text = "Введите текст"
                return
            }
            guard let translation = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                result.text = "Ошибка"
                return
            }
        let en = "en-ru"
        let ru = "ru-en" // для тестов
            let url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=dict.1.1.20230817T204836Z.a24d3b07ee246d8f.3c9e6b9e1612c81554e307eb54e1a2cb4bc47170&lang=\(ru)&text=\(translation)"
            
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(Welcome.self, from: data)
                        if let translation = result.def.first?.tr.first?.text {
                            self.result.text = translation
                            self.historyArray.append(translation)
                        } else {
                            self.result.text = "Перевод не найден"
                        }
                    } catch {
                        print(error)
                        self.result.text = "Ошибка"
                    }
                case .failure(let error):
                    print(error)
                    self.result.text = "Ошибка"
                }
            }
        }
    func addHistory(text: String) {
       var historyArray = UserDefaults.standard.stringArray(forKey: "history") ?? []
        historyArray.append(text)
        UserDefaults.standard.set(historyArray, forKey: "history")
    }
    @objc func historyButton() {
        print(historyArray)
        let secondViewController = SecondViewController()
        secondViewController.historyArray = historyArray
        navigationController?.pushViewController(secondViewController, animated: true)
        
    }
}
