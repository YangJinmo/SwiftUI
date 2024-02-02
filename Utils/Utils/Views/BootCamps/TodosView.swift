//
//  TodosView.swift
//  Utils
//
//  Created by Jmy on 2/2/24.
//

import SwiftUI

struct TodoItem: Identifiable {
    var id: UUID
    var title: String
}

func prepareData() -> [TodoItem] {
    print("prepareData() called")

    var newList = [TodoItem]()

    for i in 0 ... 20 {
        let newTodo = TodoItem(id: UUID(), title: "내 할일 \(i)")

        print("newTodo.id: \(newTodo.id) / title: \(newTodo.title)")
        newList.append(newTodo)
    }

    return newList
}

struct TodosView: View {
    @State var todoItems = [TodoItem]()

    init() {
        _todoItems = State(initialValue: prepareData())
    }

    var body: some View {
        NavigationView {
            List(todoItems) { todoItem in
                NavigationLink(destination: Text("\(todoItem.title)")) {
                    Text("\(todoItem.title)")
                }
            }
            .navigationTitle(Text("할 일 목록"))
        }
    }
}

#Preview {
    TodosView()
}
