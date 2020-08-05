//
//  ViewController.swift
//  SwiftDemo
//
//  Created by apple on 2017/11/1.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    var tableView : UITableView!
    let win = UIWindow.init(frame: UIScreen.main.bounds)
    @IBOutlet weak var top: UITextField!
    @IBOutlet weak var bot: UITextField!
    var dataArr = ["学习成就","每天学习计划","学习帮助"]
    let _vNothin = FWNothingView.init(frame: .zero)
    var personS = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.pushViewController(ZZSelectSitViewController(), animated: true)
        return;
            
        self.view.backgroundColor = UIColor.cyan
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "whatF"
        dataDeal()
        sfSort()
        let tbc = TBCycleView.init(frame: CGRect.init(x: 150, y: 300, width: 100, height: 100))
        tbc.drawProgress(0.8)
        self.view.addSubview(tbc)
        
        let dic = [["name":"namename","age":2],["name":"namename2","age":3],["name":NSNull.init(),"age":2]] as [[String : Any]]
        //        let model = Person.objc
        let mirror = Mirror.init(reflecting: Person())
        var models = [Person]()
        for subDic in dic {
            let model = Person()
            for (key,value) in mirror.children{
                if let k = key
                {
                    if let v = subDic[k]{
                        
                    }
                }
            }
            models.append(model)
        }
        
        let btn1 = ZZMyButton.init(frame: CGRect.init(x: 60, y: 100, width: 130, height: 60))
        btn1.backgroundColor = .yellow
        btn1.addTarget(self, action: #selector(click), for: .touchUpInside)
        view.addSubview(btn1)
        
        let btn2 = ZZZMyButton.init(frame: CGRect.init(x: 60, y: 200, width: 130, height: 60))
        btn2.backgroundColor = .red
        btn2.addTarget(self, action: #selector(filter), for: .touchUpInside)
        view.addSubview(btn2)
        codeTest()
        return
        //
        return
//        print(models)
        
        _ = self.navigationController?.pushViewController(ssViewController(), animated: true)
       
            self.view.backgroundColor = UIColor.cyan
        buildNullListView()
        //        codeTest()
        function()
        let c = """
congqianyouzuolingjianshan
"""
        let ar = c.split(separator: "o")
        print("")
        //        let aLayer = CALayer.init()
        //        aLayer.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        //        aLayer.position = CGPoint.init(x: 150, y: 150)
        //        aLayer.contents = UIImage.init(named: "2")?.cgImage
        //        self.view.layer.addSublayer(aLayer)
        
        //        arr()
        //        scanner()
        
        //        UIApplication.shared.openURL(URL.init(string: "aspentech://yunduoketang.com/view/activity://&a=1")!)
        
        //        map()
        //
        //        迭代器()
        //
        //        flatMap()
        //
        //        reduce()
        //        filter()
        
        
        //        let btn = UIButton.init(type: .custom)
        //        btn.setTitleColor(UIColor.red, for: .normal)
        //        btn.setTitle("变变变", for: .normal)
        //        btn.setTitleColor(UIColor.red, for: .disabled)
        //        btn.addTarget(self, action: #selector(click(_:)), for: .touchUpInside)
        //        btn.frame = CGRect.init(x: 150, y: 350, width: 100, height: 100)
        //        self.view.addSubview(btn)
        
        //        bot.delegate = self
        //        top.delegate = self
    }
    @objc func click(_ btn:UIButton) {
        //        print("\(top.text) \n \(bot.text)")
        //        btn.isEnabled = false
        //        whatIsWriteCopy()
        
       navigationController?.pushViewController(ZTViewController(), animated: true)
    }
    /*
     var x = [1,2,3]
     var y = x
     x.append(5)
     y.removeLast()
     x // [1, 2, 3, 5]
     y // [1, 2]
     这种行为就被称为 "写时复制" 。它的工作方式是，每当数组被改变，它首先检查它对存储缓冲区的引用是否是唯一的，或者说，检查数组本身是不是这块缓冲区的唯一拥有者。如果是，那么缓冲区可以进行原地变更；也不会有复制被进行。不过，如果缓冲区有一个以上的持有者 (如本例中)，那么数组就需要先进行复制，然后对复制的值进行变化，而保持其他的持有者不受影响。”
     
     */
    
    @objc func arr(){
        var a = [1,2,3]
        var b = a
        a.remove(at: 0)
        b.append(4)
        
        
        var a2 = NSMutableArray.init(object: "1")
        var b2 = a2
        a2.remove("1")
        b2.add("2")
        
        var a3 = ["1"]
        var b3 = a3
        a3.remove(at: 0)
        b3.append("34")
        
        print("")
    }
    
    func scanner() {
        for i in 0..<Int.max {
            print("int is .........\(i)")
            let scanner = BinaryScanner.init(data: "abdfn".data(using: .utf8)!)
            DispatchQueue.global().async {
                scanner.scanRemainingBytes(scanner: scanner)
            }
            scanner.scanRemainingBytes(scanner: scanner)
        }
        //        let scanner = BinaryScanner.init(data: "abdfn".data(using: .utf8)!)
        //        scanner.scanRemainingBytes(scanner: scanner)
        print("")
    }
    
    
    @objc func filter(){
        let ages = [
            "Tim": 53, "Angela": 54, "Craig": 44,
            "Jony": 47, "Chris": 37, "Michael": 34,
            ]
        
        
        let a = ages.keys.filter {
            key in ages[key]! < 50
        }
        print(a)
    }
    
    
    func 迭代器() {
        
        let arr = Array(0...10)
        var iterator = arr.makeIterator()
        while let a = iterator.next() {
            print(a)
        }
        
        
        let arr2 = ["1","2","three"]
        var intArr2 = arr2.map({Int($0)})
        
        if var i = intArr2[2]{
            i = 0
            intArr2[2] = i
        }
        for var i in intArr2{
            if nil == i{
                i = 0
                intArr2[2] = i
            }
        }
        
        let intArray = intArr2.filter({nil != $0})
        for case let i? in intArr2{
            print(i)
        }
        print("gg")
    }
    
    
    func reduce(){
        let arr = [1,2,3,4]
        let b = arr.reduce([Int](), {[$1]+$0})
        let c = arr.reduce(0, +)
        
        let d = personS.reduce([String](), { $0 + [$1.city]})
        
        if d.first?.first == Optional("1"){
            print("sha")
        }
        
        print("")
        
    }
    
    func flatMap(){
        let arr = ["1","2,","3","four"]
        let arrInt = arr.map({Int($0)})
        let intArr = arrInt.flatMap({$0})
        print("\(arrInt),\(intArr)")
    }
    
    func map(){
        let arr = [1,2,3,2,1,5,4,6]
        
        let arr2 = arr.reduce(0,{$0 * $1})
        
        let persons: [[String: String]] = [["name": "Carl Saxon", "city": "New York, NY", "age": "44"],
                                           ["name": "Travis Downing", "city": "El Segundo, CA", "age": "34"],
                                           ["name": "Liz Parker", "city": "San Francisco, CA", "age": "32"],
                                           ["name": "John Newden", "city": "New Jersey, NY", "age": "21"],
                                           ["name": "Hector Simons", "city": "San Diego, CA", "age": "37"],
                                           ["name": "Brian Neo", "age": "27"],
                                           [:]]
        
        
        for person in persons {
            let per = Person()
            per.name = person["name"] ?? ""
            per.age = Int(person["age"] ?? "") ?? 0
            per.city = person["city"] ?? ""
            personS.append(per)
        }
        
        
        for person in personS{
            // 浅复制 person的指针未变 personS里面的内容会随着person的变化变化
            person.name = "aa"
        }
        
        let city = persons.filter { (person) -> Bool in
            (person["city"] ?? "").hasPrefix("New")
        }
        let cityS = personS.filter{$0.city.count>0}
        
        let mapCity = personS.compactMap {$0.city}
        let mapCity1 = persons.compactMap {$0["city"]}
        let justMap = persons.compactMap {$0["city"]}
        print("")
    }
    
    
    func swipeValue(_ a: inout Int,_ b: inout Int) {
        let c = a
        a = b
        b = c
    }
    
    struct State {
        var name:String
        var population:Int
        var asPropertyList:[AnyHashable:Any] {
            var result:[AnyHashable:Any] = [:]
            result["name"] = "jack"
            result["population"] = 1000
            return result
        }
    }
    
    
    func canThrowAnError() throws{
        let age = 3
        assert(age >= 0, "A person's age cannot be less than zero")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = dataArr[indexPath.row]
        cell?.backgroundColor = UIColor.clear
        return cell!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - build view
    func buildNullListView() {
        let attriString = NSMutableAttributedString.init(string: "亲，您还没有购买课程，不如去课程看看吧")
        
        _vNothin.attributed = attriString
        _vNothin.isFullSet = true
        self.view.addSubview(_vNothin)
        //        _vNothin.delegate = self
    }
    
    func aa(){
        let a = 10000
        let _ = Float(a)
        if let c = Float("123") {
            print(c)
        }
        
        let img = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 320, height: 568))
        img.image = UIImage.init(named: "bg.png")
        self.view.addSubview(img)
        
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: 320, height: 568), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clear
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        
        /*
         set集合是无序的 不重复的
         */
        var arr:Set = [1,2,3,2,1,5,4,6]
        arr.remove(2)
        arr.remove(at: arr.index(of: 6)!)
        print(arr)
        arr.insert(1)
        print(arr)
        let c = arr.dropLast()
        print(c)
        let arr2 = arr.map { (a) -> Int in
            return a*a
        }
        let arr3 = arr2.mmap { (a) -> Int in
            return a*a
        }
        let arr4 = arr2.mmmp { (a) -> Int in
            return a*a
        }
        let arr5 = arr2.reversed()
        print(arr2)
        
        for a in arr2 where a > 5{
            print(a)
        }
        let arr6 = arr2.filter { (a) -> Bool in
            return a%2 == 0
        }
        let arr7 = arr2.contains { (a) -> Bool in
            return a > 15
        }
        
        let arr8 = arr2.reduce(10,{$0 + $1})
        
        var newArr = arr.sorted(by: { $0 > $1 })
        print(newArr)
        
        //        newArr.map { (a) -> T in
        //            <#code#>
        //        }
        newArr.remove(at: 0)
        //inout 关键字 类似*
        var aa = 1
        var bb = 2
        swipeValue(&aa, &bb)
        print("\(aa) \(bb)")
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
}

class Person: NSObject,Codable {
    var name = ""
    var age = 0
    var city = ""
}

extension Array{
    func mmap<T>(_ transform: (Element) throws -> T) rethrows -> [T] {
        var result:[T] = []
        result.reserveCapacity(count)
        for x in self{
            result.append(try transform(x))
        }
        return result
    }
    
    func mmmp<Int>(_ transform: (Element) ->Int)->[Int]{
        var result:[Int] = []
        for x in self {
            result.append(transform(x))
        }
        return result
    }
}

class BinaryScanner {
    var position:Int
    let data:Data
    
    init(data:Data) {
        self.position = 0
        self.data = data
    }
    
    func scanRemainingBytes(scanner:BinaryScanner){
        while let byte = scanner.scanByte() {
            print(byte)
        }
    }
}

extension BinaryScanner {
    func scanByte() -> UInt8?{
        guard position < data.endIndex else {
            return nil
        }
        position += 1
        return data[position-1]
    }
}

/*
 结构体
 “对结构体进行改变，在语义上来说，与重新为它进行赋值是相同的。即使在一个更大的结构体上只有某一个属性被改变了，也等同于整个结构体被用一个新的值进行了替代。在一个嵌套的结构体的最深层的某个改变，将会一路向上反映到最外层的实例上，并且一路上触发所有它遇到的 willSet 和 didSet。”  eg: rect.origin.x 会导致整个rect被新值替代
 */
