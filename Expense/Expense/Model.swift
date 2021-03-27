//
//  Model.swift
//  Expense
//
//  Created by Grifus on 27.03.2021.
//

import Foundation

struct SuperStract: Identifiable {
    var id: Int
    
    var titleOfStruct: String
    var priceOfStruct: String
}

class mainWork: ObservableObject {
    
    @Published var allData: [SuperStract] = [] //UserDefaults.standard.array(forKey: "struct") as? [SuperStract] ?? []
    //@State var arr: [String] = []//= UserDefaults.standard.array(forKey: "price") as? [String] ?? []
    
    
    //    func saveData(values: [SuperStract], id: Int) {
    //        let data = UserDefaults.standard
    //        data.set(values, forKey: String(id))
    //        print(values)
    //    }
    //
    //    func saveTest(val: [Int], key: String) {
    //        let data = UserDefaults.standard
    //        data.set(val, forKey: key)
    //        for i in 0..<allData.count {
    //            print(data.string(forKey: key))
    //        }
    //    }
    
    
    func sum() -> Int {
        var sum = 0
        for i in 0..<allData.count {
            sum = sum + Int(allData[i].priceOfStruct)!
        }
        return sum
    }
    
    func addToStruct(title: String, price: String) {
        allData.append(SuperStract(id: allData.count, titleOfStruct: title, priceOfStruct: price))
        //arr.append(price)
    }
    
    func deleteItem(index: IndexSet) {
        allData.remove(atOffsets: index)
        for i in 0..<allData.count {
            allData[i].id = i
        }
    }
    
    func onlyNumbers(str: String) -> Bool {
        let newStr = str.filter { $0.isNumber }
        if str == newStr && str != "" {
            return true
        }
        return false
    }
}
