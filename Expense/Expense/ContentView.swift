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
    @State var x = 0
    var body: some View {
        HStack {
            
            VStack{
                
                //                Button(action: {
                //                    print(worker.allDataInStruct)
                //                }, label: {
                //                    Text("Read struct")
                //                })
                // кнопка добавления данных в массив и сохранения
                Button(action: {
                    if worker.onlyNumbers(str: onePrice) {
                        worker.addToStruct(title: oneTitle, price: onePrice)
                        worker.saveData()
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
                
                // создание формы для предстваления данных
                Form {
                    // ввод данных
                    HStack {
                        TextField("Enter title", text: $oneTitle)
                        TextField("Enter price", text: $onePrice)
                            .keyboardType(.phonePad)
                    }
                    .frame(height: 30, alignment: .center)
                    
                    // вывод данных
                    
                    ForEach(worker.allDataInStruct, id: \.self) {k in
                        
                        HStack {
                            Text(k.titleOfStruct)
                                .onTapGesture {
                                    worker.alertFunc(index: k.id)
                                }
                                .frame(width: 150 ,height: 30, alignment: .center)
                            Text(k.priceOfStruct)
                                .frame(width: 150 ,height: 30, alignment: .center)
                        }
                        
                    }
                    
                    .onDelete(perform: { indexSet in
                        print(indexSet)
                        worker.deleteItem(index: indexSet)
                    })
                    
                }
                
                // подсчет общей суммы
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
        } .onAppear() {
            worker.loadData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
