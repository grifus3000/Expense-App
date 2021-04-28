//
//  Model.swift
//  Expense
//
//  Created by Grifus on 27.03.2021.
//
import SwiftUI
import Foundation

struct SuperStract: Codable, Hashable {
    var titleOfStruct: String
    var priceOfStruct: String
    var id: Int
}

class mainWork: ObservableObject {
    @Published var allDataInStruct: [SuperStract] = []
    var fileName = "fileOfStructData.json"
    @Published var changedTitle = ""

    func sum() -> Int {
        var sum = 0
        for i in allDataInStruct {
            sum = sum + Int(i.priceOfStruct)!
        }
        return sum
    }
    
    func addToStruct(title: String, price: String) {
        allDataInStruct.append(SuperStract(titleOfStruct: title, priceOfStruct: price, id: allDataInStruct.count))
    }
    
    func deleteItem(index: IndexSet) {
        allDataInStruct.remove(atOffsets: index)
        for i in 0..<allDataInStruct.count {
            allDataInStruct[i].id = i
        }
        saveData()
    }
    
    func onlyNumbers(str: String) -> Bool {
        let newStr = str.filter { $0.isNumber }
        if str == newStr && str != "" {
            return true
        }
        return false
    }
    
    func saveData() {
        let dirUrl = FileManager.default.temporaryDirectory
        let fileUrl = dirUrl.appendingPathComponent(fileName)
        let json = try? JSONEncoder().encode(allDataInStruct)
        do {
            try json!.write(to: fileUrl)
        } catch {
            print("can't write data in file")
        }
    }
    
    func loadData() {
        let dirUrl = FileManager.default.temporaryDirectory
        let fileUrl = dirUrl.appendingPathComponent(fileName)
        if !FileManager.default.fileExists(atPath: fileUrl.path) {
            let some = ""
            let json = try? JSONEncoder().encode(some)
            do {
                try json!.write(to: fileUrl)
            } catch {
                print("can't write data in file")
            }
        }
        let data = try? Data(contentsOf: fileUrl, options: [])
        guard let array = try? JSONDecoder().decode([SuperStract].self, from: data!) else {return}
        allDataInStruct = array
    }
    
    func alertFunc(index: Int) {
        let alert = UIAlertController(title: "Change values", message: "", preferredStyle: .alert)
        
        alert.addTextField { textField in
            textField.text = self.allDataInStruct[index].titleOfStruct
        }
        alert.addTextField { textField in
            textField.text = self.allDataInStruct[index].priceOfStruct
        }
        
        alert.textFields?[1].keyboardType = .phonePad
        
        let change = UIAlertAction(title: "Change", style: .default) { _ in
            if self.onlyNumbers(str: alert.textFields?[1].text ?? "") {
                self.allDataInStruct[index].titleOfStruct = alert.textFields?[0].text ?? ""
                self.allDataInStruct[index].priceOfStruct = alert.textFields?[1].text ?? ""
                self.saveData()
            } else {
                print("You should only enter numbers")
            }
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        alert.addAction(change)
        alert.addAction(cancel)
        
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        
    }
}

