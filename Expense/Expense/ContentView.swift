//
//  ContentView.swift
//  Expense
//
//  Created by Grifus on 27.03.2021.
//

import SwiftUI

struct SuperStract: Identifiable {
    var id: Int
    
    var titleOfStruct: String
    var priceOfStruct: String
}

struct ContentView: View {
    @State var onNumberAllert = false
    @State var oneTitle: String = ""
    @State var onePrice: String = ""
    @State var allData: [SuperStract] = [] //UserDefaults.standard.array(forKey: "struct") as? [SuperStract] ?? []
    //@State var arr: [String] = []//= UserDefaults.standard.array(forKey: "price") as? [String] ?? []

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
    
    var body: some View {
        HStack {
            VStack{
                //                Button(action: {
                //                    print(allData)
                //                }, label: {
                //                    Text("Read struct")
                //                })
                Button(action: {
                    if onlyNumbers(str: onePrice) {
                        addToStruct(title: oneTitle, price: onePrice)
                        //UserDefaults.standard.set(allData, forKey: "struct")
                        //saveData(values: allData, id: allData.count)
                        //saveTest(val: Int(onePrice)!, key: oneTitle)
                        //print(allData)
                        oneTitle = ""
                        onePrice = ""
                    } else {
                        onNumberAllert.toggle()
                    }
                }, label: {
                    Text("Add item")
                })
                .padding(.top)
                .alert(isPresented: $onNumberAllert, content: {
                    Alert(title: Text("You should only enter numbers"))
                })
                Form {
                    HStack {
                        TextField("Enter title", text: $oneTitle)
                        TextField("Enter price", text: $onePrice)
                            .keyboardType(.phonePad)
                    }
                    .frame(height: 30, alignment: .center)
                    ForEach(allData) {k in
                        HStack {
                            Text(k.titleOfStruct)
                                .frame(width: 150 ,height: 30, alignment: .center)
                            Text(k.priceOfStruct)
                                .frame(width: 150 ,height: 30, alignment: .center)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        deleteItem(index: indexSet)
                    })
                }
                Form {
                    HStack {
                        Text("General price")
                            .frame(width: 150 ,height: 30, alignment: .center)
                        Text("\(sum())")
                            .frame(width: 150 ,height: 30, alignment: .center)
                    }
                }
                .frame(height: 100, alignment: .top)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
