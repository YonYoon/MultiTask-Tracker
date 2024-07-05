//
//  ViewController.swift
//  MultiTask Tracker
//
//  Created by Zhansen Zhalel on 03.07.2024.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Задний фон
        view.backgroundColor = UIColor(named: "Main")
        
        setSquare()
        setButton2()
    }

    private func setSquare(){
        let square1 = createRectangle(frame: CGRect(x: view.frame.width-381, y: 182, width: 369, height: 97))
        let square2 = createRectangle(frame: CGRect(x: view.frame.width-381, y: 294, width: 369, height: 458))
        // Обьявляем рамки
        [square1,square2].forEach {item in
            view.addSubview(item)}
    }
    private func setButton2(){
        let button12 = createButton2(frame: CGRect(x: 32, y: 351, width: 150, height: 60))
        let button22 = createButton2(frame: CGRect(x: 213, y: 351, width: 150, height: 60))
        // Обьявляем рамки
        [button12,button22].forEach {item in
            view.addSubview(item)}
    }

    private func createRectangle(frame: CGRect) -> UIView{
        let square = UIView()
        square.backgroundColor = UIColor (named: "Rectangle")
        square.frame = frame
        square.layer.cornerRadius = 30
        return square
    }

    private func createButton2(frame: CGRect) -> UIView{
        let square = UIView()
        square.backgroundColor = UIColor (named: "Button Home 2")
        square.frame = frame
        square.layer.cornerRadius = 15
        return square
    }
}
