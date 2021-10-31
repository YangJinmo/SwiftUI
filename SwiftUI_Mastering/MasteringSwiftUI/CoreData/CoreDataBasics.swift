//
//  Mastering SwiftUI
//  Copyright (c) KxCoding <help@kxcoding.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import CoreData
import SwiftUI

struct CoreDataBasics: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var showEditScene = false

    @Environment(\.managedObjectContext) var context
    // 뷰가 생성되는 시점에 시스템 공유 데이터로 설정되어 있는 컨텍스트가
    // 이 속성에 자동으로 저장됩니다.
    // 프리뷰에서 정상적이지 않음. 씬델리게이트에 추가한 부분이 프리뷰에서는 동작하지 않기 때문에

    @FetchRequest(entity: MemberEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \MemberEntity.name, ascending: true)])
    // 데이터를 읽어오는 코드는 UIKit과 차이가 있습니다.
    // UIKit에서는 FetchRequest를 생성하고 context에게 실행을 요청합니다.
    // SwiftUI에서도 FetchRequest를 생성해야하지만 만드는 방식이 다릅니다.

    // Core Data에서 가져온 데이터를 저장하는 속성을 선언해야 합니다.
    // 속성의 형식은 FetchedResults로 선언하고
    // 타입 파라미터를 MemberEntity로 선언해야 합니다.
    // 이렇게 해야 members에 자동으로 저장됩니다.
    var members: FetchedResults<MemberEntity>

    func createMember() {
        guard name.count > 0, let ageValue = Int16(age) else {
            return
        }

        let newMember = MemberEntity(context: context)
        newMember.name = name
        newMember.age = ageValue

        do {
            try context.save()
        } catch {
            print(error)
        }

        name = ""
        age = ""
    }

    func delete(at rows: IndexSet) {
        for index in rows {
            context.delete(members[index])
            // 배열과 구조가 동일해서 subscript 문법으로 원하는 인덱스에 접근할 수 있습니다.
        }

        do {
            try context.save()
        } catch {
            print(error)
        }
    }

    var body: some View {
        VStack {
            HStack {
                VStack {
                    TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    TextField("Age", text: $age)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                Button(action: {
                    self.createMember()
                }, label: {
                    Text("Save")
                })
                    .padding()
            }
            .padding()

            List {
                ForEach(members) { member in
                    Button(action: {
                        self.showEditScene = true
                    }, label: {
                        HStack {
                            // MemberEntity로 타입 캐스팅
                            // 강제 추출 연산자 사용 (!)
                            Text((member as MemberEntity).name!)
                            Spacer()
                            Text("\((member as MemberEntity).age)")
                        }
                    })
                        .sheet(isPresented: self.$showEditScene) {
                            EditScene(showEditScene: self.$showEditScene, member: member)
                                .environment(\.managedObjectContext, self.context)
                        }
                    // NavigationView 나 ChildView 일 때는 자동으로 주입되지만
                    // sheet는 자동으로 주입되지 않습니다.
                    // 그래서 .environment(\.managedObjectContext, self.context) 추가
                }
                .onDelete(perform: delete)
            }
        }
    }
}

struct CoreDataBasics_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBasics()
            .environment(\.managedObjectContext, CoreDataManager.shared.mainContext)
    }
}
