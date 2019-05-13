//
//  ViewController.swift
//  Ortho-Graphos
//
//  Created by David Perez on 1/12/19.
//  Copyright © 2019 David Perez P. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate {
    
   
    @IBOutlet weak var tableView: UITableView!
    
   var wordArray = [Word]()
    
    
    let wordView : wordViewModel = {
        let w = wordViewModel(frame: CGRect(x: 0, y: 40, width: 300, height: 400))
        w.label.text = "Hello"
        w.translatesAutoresizingMaskIntoConstraints = false
        w.backButton.addTarget(self, action: #selector(removeView), for: UIControl.Event.touchUpInside)
        w.trueButton.addTarget(self, action: #selector(buttonTruePressed), for: UIControl.Event.touchUpInside)
        w.falseButton.addTarget(self, action: #selector(buttonFalsePressed), for: UIControl.Event.touchUpInside)
        return w
    }()
    
    let secondWordView : wordViewModel = {
        let w = wordViewModel(frame: CGRect(x: 0, y: 40, width: 300, height: 400))
        w.label.text = "Hello"
        w.translatesAutoresizingMaskIntoConstraints = false
        w.backButton.addTarget(self, action: #selector(removeView), for: UIControl.Event.touchUpInside)
        w.trueButton.addTarget(self, action: #selector(buttonTruePressed), for: UIControl.Event.touchUpInside)
        w.falseButton.addTarget(self, action: #selector(buttonFalsePressed), for: UIControl.Event.touchUpInside)
        return w
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.\
        let ftchRequest: NSFetchRequest<Word> = Word.fetchRequest()
        
        do {
           var wordArray = try PersistanceSrvc.context.fetch(ftchRequest)
            self.wordArray = wordArray.sorted(by: {$0.word < $1.word}) ?? []
            
            tableView.reloadData()
        } catch {
            print("Error saving context")
        }
        tableView.separatorColor = .clear
        tableView.delegate = self
        let array = returnFakeWordArray()
        print(array)
    }
    
    
    
    @IBAction func playTapped(_ sender: UIBarButtonItem) {
        
        
       setupSecondView()
       setupWordView()
       
        print("play tapped")
    }
    
    
    func setupWordView(){
        view.addSubview(wordView)
        wordView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        wordView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        wordView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        wordView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6).isActive = true
    }
    
    @IBAction func addTapped(_ sender: UIBarButtonItem) {
        let alertView = UIAlertController(title: "Palabra", message: nil, preferredStyle: .alert)
        alertView.addTextField { (textFld) in
            textFld.placeholder = "palabra nueva"
        }
        let action = UIAlertAction(title: "Agregar", style: .default) { (alertAction) in
            let word = alertView.textFields?.first?.text
            let wordFromEntity = Word(context: PersistanceSrvc.context)
            if word != "" {
                wordFromEntity.word = word!.capitalized
                PersistanceSrvc.saveContext()
                self.wordArray.append(wordFromEntity)
                self.tableView.reloadData()
                self.wordArray.sort(by:{$0.word < $1.word})
                let array = self.returnFakeWordArray()
                print(array)
            }
        }
        let cancelAction = UIAlertAction(title: "cancelar", style: UIAlertAction.Style.cancel) { (UIAlertAction) in
            
        }
        alertView.addAction(action)
        alertView.addAction(cancelAction)
        present(alertView, animated: true) {
            print("alertView presentesd")
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
    }
    
    func fakeWord(array: [String])->[String]{
        var wrongArray: [String] = []
        
        let hashTable: [String: String] = [
            "z": "s",
            "y": "ll",
            "h": "",
            "j": "g",
            "x": "cc",
            "v": "b",
            "á": "a",
            "é": "e",
            "í": "i",
            "ó": "o",
            "ú": "u"
        ]
        
        for word in array {
            for c in word{
                for l in hashTable.keys {
                    if c.description == l {
                        let newWord =  word.replacingOccurrences(of: c.description, with: hashTable[l] ?? "", options: .literal)
                        wrongArray.append(newWord)
                    }
                }
            }
        }
        return wrongArray
    }
    
    func returnFakeWordArray() -> [String] {
        var wordToStringArray: [String] = []
        for i in wordArray {
            wordToStringArray.append(i.word.lowercased())
            print(wordToStringArray)
        }
        let wrongWordArray = fakeWord(array: wordToStringArray)
        return wrongWordArray
    }
    
    
    @objc
    func buttonFalsePressed(){
        
        
        var transform =  CATransform3DIdentity
        transform.m34 = 1.0/500.0
        transform = CATransform3DRotate(transform, (CGFloat.pi), 0, 1, 0.0)
        
        var transformTwo = CATransform3DIdentity
        transformTwo.m34 = 1.0/500.0
        transformTwo = CATransform3DRotate(transform, (CGFloat.pi), 0, 1, 0.0)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 2, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
            self.wordView.layer.transform = transform
            self.wordView.layer.zPosition = self.wordView.frame.width/2
            self.secondWordView.layer.transform = transformTwo
            self.secondWordView.layer.zPosition = self.wordView.frame.width/2 - 10
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
    }
    
    func setupSecondView(){
        
        
        wordView.addSubview(secondWordView)
        wordView.sendSubviewToBack(secondWordView)
       
        secondWordView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        secondWordView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        secondWordView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8).isActive = true
        secondWordView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6).isActive = true
        var transform =  CATransform3DIdentity
        transform.m34 = -1.0/500.0
        
        transform = CATransform3DRotate(transform, (CGFloat.pi), 0, 1, 0.0)
      
        secondWordView.layer.transform = transform
        secondWordView.layer.zPosition = self.wordView.frame.width/2
        
    }
    
    @objc
    func buttonTruePressed(){
        
        var transform =  CATransform3DIdentity
        transform.m34 = -1.0/500.0
        
        transform = CATransform3DRotate(transform, (CGFloat.pi), 0, 1, 0.0)
        
        UIView.animate(withDuration: 0.5, delay: 0.1, usingSpringWithDamping: 2, initialSpringVelocity: 2, options: [.curveEaseOut], animations: {
            self.wordView.layer.transform = transform
            self.wordView.layer.zPosition = self.wordView.frame.width/2
        }, completion: nil)
    }
    
    @objc
    func removeView(){
        wordView.removeFromSuperview()
        wordView.layer.transform = CATransform3DIdentity
    }
    
}



extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: nil)
        cell.textLabel?.font = UIFont(name: "Helvetic-Neue", size: 20)
        cell.textLabel?.text = wordArray[indexPath.row].word
       // cell.detailTextLabel?.text = ""
        return cell
    }
    
}
