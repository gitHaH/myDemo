//
//  SortViewController.swift
//  SwiftDemo
//
//  Created by apple on 2018/10/9.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

extension ViewController{
    
    func sfSort() {
        let now = NSDate()
        let b = "2019-11-30"
        let a = "2017-11-20"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let dateFuture = dateFormat.date(from: b)
        let datePast = dateFormat.date(from: a)
        
        let timeF = dateFuture?.timeIntervalSinceNow
        let timeP = now.timeIntervalSince(datePast!)
        // 几天后
        let c = Int(ceil(timeF!/(3600*24)))
        //几天前
        let d = Int(floor(timeP/(3600*24)))
        
//        findSubArrMaxSum()
        quick()
//        maopao()
    }
    //  O(n)
    func tong(){
        var originArr = [10,5,8,30,8,6]
        var tongArr = Array.init(repeating: 0, count: originArr.max()!)
        for i in 0..<originArr.count{
            tongArr[originArr[i]-1] += 1
        }
        for i in 0..<tongArr.count{
            for _ in 0..<tongArr[i]{
                print(i+1)
            }
        }
    }
    
    // O(n²)  n*(n-1)/2
    func maopao(){
        var originArr = [10,30,8,6,5]
        for i in 0..<originArr.count-1{
            for j in 0..<originArr.count-i-1{
                print("i = \(i) and j = \(j) but\n j = \(originArr[j]) j+1=\(originArr[j+1]) ")
                if originArr[j+1] < originArr[j]{
                    let tmp = originArr[j]
                    originArr[j] = originArr[j+1]
                    originArr[j+1] = tmp
                }
            }
        }
        
        print(originArr)
    }
    // 快速排序的最差时间复杂度和 冒泡排序是一样的，都是 O(N²)，它的平均时间复杂度为 O (NlogN)
    func quick(){
        var originArr = [3,4,5,2,1]//[10,5,30,8,6,15,26]
        quickSort(arr: &originArr, left: 0,right: originArr.count-1)
        print(originArr)
    }
    func quickSort( arr:inout [Int],left:Int,right:Int){
        guard right>left else {
            return
        }
        let tmp = arr[left]
        var i = left,j = right
        while i != j {
            while arr[j] >= tmp && j>i{
                j -= 1
                print("j is \(arr[j])")
            }
            print("selectRight is \(arr[j])")
            while arr[i] <= tmp && i<j{i += 1}
            print("selectLeft is \(arr[i])")
            if i<j {
                let t = arr[i]
                arr[i] = arr[j]
                arr[j] = t
            }
        }
        arr[left] = arr[i]
        arr[i] = tmp
        
        quickSort(arr: &arr, left: left, right: i-1)
        quickSort(arr: &arr, left: i+1, right: right)
    }
    
    func findSubArrMaxSum(){
        let originArr = [-5,8,30,-8,6]
        var max = 0
        var this = 0
        for (_,i) in originArr.enumerated() {
            this += i
            if this > max{
                max = this
            }else if this < 0{
                this = 0
            }
        }
        print(max)
    }
}

struct Queue {
    var data = Array.init(repeating: 0, count: 100)
    var head = 0
    var tail = 0
}
