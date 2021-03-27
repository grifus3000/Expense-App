//
//  ContentView.swift
//  Expense
//
//  Created by Grifus on 27.03.2021.
//

import SwiftUI



struct ContentView: View {
    @State var onNumberAllert = false
    @State var oneTitle: String = ""
    @State var onePrice: String = ""
    @ObservedObject var worker = mainWork()
    
    
    
    var body: some View {
        HStack {
            VStack{
                //                Button(action: {
                //                    print(allData)
                //                }, label: {
                //                    Text("Read struct")
                //                })
                Button(action: {
                    if worker.onlyNumbers(str: onePrice) {
                        worker.addToStruct(title: oneTitle, price: onePrice)
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
                    ForEach(worker.allData) {k in
                        HStack {
                            Text(k.titleOfStruct)
                                .frame(width: 150 ,height: 30, alignment: .center)
                            Text(k.priceOfStruct)
                                .frame(width: 150 ,height: 30, alignment: .center)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        worker.deleteItem(index: indexSet)
                    })
                }
                Form {
                    HStack {
                        Text("General price")
                            .frame(width: 150 ,height: 30, alignment: .center)
                        Text("\(worker.sum())")
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
