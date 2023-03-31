//
//  GridWithScrollView.swift
//  Grid
//
//  Created by Jmy on 2023/03/29.
//

import SwiftUI

struct GridWithScrollView1: View {
    let rows = 10
    let columns = 10

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach(0 ..< rows) { rowIndex in
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 0) {
                                ForEach(0 ..< columns) { columnIndex in
                                    Text("(\(rowIndex), \(columnIndex))")
                                        .frame(width: 50, height: 50)
                                }
                            }
                        }
                        .id(rowIndex)
                    }
                }
            }
            .onAppear {
                // Scroll to the middle of the grid on app launch
                let middleRowIndex = rows / 2
                let middleColumnIndex = columns / 2
                withAnimation {
                    scrollViewProxy.scrollTo(middleRowIndex, anchor: .top)
                    scrollViewProxy.scrollTo(middleColumnIndex, anchor: .leading)
                }
            }
        }
    }
}

import SwiftUI

struct GridWithScrollView2: View {
    let rows = 10
    let columns = 10

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(0 ..< rows, id: \.self) { rowIndex in
                        LazyHStack(spacing: 0) {
                            ForEach(0 ..< columns, id: \.self) { columnIndex in
                                Text("(\(rowIndex), \(columnIndex))")
                                    .border(.red)
                                    .frame(
                                        width: UIScreen.main.bounds.width,
                                        height: UIScreen.main.bounds.height
                                    )
                                    .border(.green)
                            }
                        }
                        .id(rowIndex)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .ignoresSafeArea()
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true

                let middleRowIndex = rows / 2
                let middleColumnIndex = columns / 2

                withAnimation {
                    scrollViewProxy.scrollTo(0, anchor: .top)
                    scrollViewProxy.scrollTo(0, anchor: .leading)
                }
            }
            .onDisappear {
                UIScrollView.appearance().isPagingEnabled = false
            }
        }
    }
}

import SwiftUI

struct GridWithScrollView3: View {
    let rows = 10
    let columns = 10

    var body: some View {
        ScrollViewReader { scrollViewProxy in
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 0) {
                    ForEach(0 ..< rows) { rowIndex in
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 0) {
                                ForEach(0 ..< columns) { columnIndex in
                                    Text("(\(rowIndex), \(columnIndex))")
                                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                                }
                            }
                        }
                        .id(rowIndex)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .onAppear {
                // Enable paging for the ScrollView
                UIScrollView.appearance().isPagingEnabled = true

                // Scroll to the middle of the grid on app launch
                let middleRowIndex = rows / 2
                let middleColumnIndex = columns / 2
                withAnimation {
                    scrollViewProxy.scrollTo(middleRowIndex, anchor: .center)
                    scrollViewProxy.scrollTo(middleColumnIndex, anchor: .center)
                }
            }
        }
    }
}

import SwiftUI

struct GridWithScrollView4: View {
    let rows = 10
    let columns = 10

    var body: some View {
        TabView {
            ForEach(0 ..< rows) { rowIndex in
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing: 0) {
                        ForEach(0 ..< columns) { columnIndex in
                            Text("(\(rowIndex), \(columnIndex))")
                                .border(.red)
                                .frame(
                                    width: UIScreen.main.bounds.width,
                                    height: UIScreen.main.bounds.height
                                )
                                .border(.green)
                        }
                    }
                }
                .id(rowIndex)
            }
        }
        .onAppear {
            UIScrollView.appearance().isPagingEnabled = true
        }
        .ignoresSafeArea()
    }
}

struct GridWithScrollView5: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0 ..< 10) { index in
                            TabView {
                                Text("Tab \(index)")
                            }
                            .tabViewStyle(PageTabViewStyle())
                            .frame(
                                width: UIScreen.main.bounds.width,
                                height: UIScreen.main.bounds.height
                            )
                            .border(.green)
                        }
                    }
                }
                .border(.red)
            }
        }
        .onAppear {
            UIScrollView.appearance().isPagingEnabled = true
        }
        .ignoresSafeArea()
    }
}

struct GridWithScrollView6: View {
    var body: some View {
        TabView {
            ForEach(0 ..< 10) { index in
                ScrollView {
                    VStack {
                        Text("Tab \(index)")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 20) { index2 in
                                    Text("Item \(index2)")
                                        .padding()
                                }
                            }
                        }
                        .frame(height: 200)
                    }
                }
                .tabItem {
                    Text("Tab \(index)")
                }
            }
        }
    }
}

struct GridWithScrollView7: View {
    init() {
        UIScrollView.appearance().isPagingEnabled = true
    }

    var body: some View {
        TabView {
            ForEach(0 ..< 10) { index in
                ScrollView {
                    VStack {
                        Text("Tab \(index)")
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< 20) { index2 in
                                    Text("Item \(index2)")
                                        .padding()
                                }
                            }
                        }
                        .frame(height: 200)
                    }
                }
                .tabItem {
                    Text("Tab \(index)")
                }
                // ignore safe area
                .ignoresSafeArea()
            }
        }
    }
}

struct GridWithScrollView8: View {
    let rows = Array(0 ..< 10)
    let columns = Array(0 ..< 10)

    init() {
        UIScrollView.appearance().isPagingEnabled = true
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 0) {
                ForEach(rows, id: \.self) { row in
                    GeometryReader { geo in
                        let minX = geo.frame(in: .global).minX
                        let minY = geo.frame(in: .global).minY

                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 0) {
                                ForEach(columns, id: \.self) { column in
                                    Color.blue
                                        .frame(width: geo.size.width)
                                        .overlay {
                                            Text("(\(row), \(column))")
                                        }
                                }
                                .border(.red)
                            }
                        }
                        .frame(height: geo.size.height)
                    }
                    .frame(height: UIScreen.main.bounds.height)
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct GridWithScrollView9: View {
    @State private var currentPage: Int = 0

    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach(0 ..< 10) { _ in
                        GeometryReader { geo in
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 0) {
                                    ForEach(0 ..< 5) { _ in
                                        Color.blue
                                            .frame(width: geo.size.width)
                                    }
                                }
                                .frame(height: geo.size.height)
                                .offset(x: CGFloat(currentPage) * UIScreen.main.bounds.width)
                                .frame(width: UIScreen.main.bounds.width)
                                .gesture(
                                    DragGesture(minimumDistance: 20)
                                        .onEnded { value in
                                            if value.translation.width > 0 {
                                                currentPage = max(currentPage - 1, 0)
                                            } else {
                                                currentPage = min(currentPage + 1, 4)
                                            }
                                        }
                                )
                            }
                            .frame(height: UIScreen.main.bounds.height)
                        }
                    }
                }
            }
            .overlay(
                PageControl(numberOfPages: 5, currentPage: $currentPage)
                    .padding(.vertical, 10)
            )
            .onAppear {
                UIScrollView.appearance().isPagingEnabled = true
            }
        }
    }
}

struct PageControl: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentPage: Int

    func makeUIView(context: Context) -> UIPageControl {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .gray
        return pageControl
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentPage
    }
}

struct GridWithScrollView10: View {
    @State private var selection = 0
    let tabs = ["Tab 1", "Tab 2", "Tab 3"]

    var body: some View {
        VStack {
            TabView(selection: $selection) {
                Text("Content for Tab 1")
                    .tag(0)
                Text("Content for Tab 2")
                    .tag(1)
                Text("Content for Tab 3")
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

            ScrollView {
                VStack(spacing: 20) {
                    ForEach(0 ..< 100) { index in
                        Text("Item \(index)")
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .background(Color.gray)
                    }
                }
                .frame(height: 300)
                .offset(x: CGFloat(selection) * -UIScreen.main.bounds.width, y: 0)
            }
        }
    }
}

struct GridWithScrollView11: View {
    @State private var selectedTab = 0
    let tabs = ["Tab 1", "Tab 2", "Tab 3"]

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(0 ..< tabs.count) { index in
                        Text(tabs[index])
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(selectedTab == index ? Color.blue : Color.gray)
                            .foregroundColor(.white)
                            .onTapGesture {
                                selectedTab = index
                            }
                    }
                }
            }

            ScrollViewReader { proxy in
//                let minX = proxy.frame(in: .global).minX
//                let minY = proxy.frame(in: .global).minY
//                let size = proxy.size
//
//                print("minX: \(minX)")
//                print("minY: \(minY)")
//                print("size: \(size)")
//                print("-minX < (size.width / 2): \(-minX < (size.width / 2))")
//                print("minX < (size.width / 2): \(minX < (size.width / 2))")
//                print("-minY < (size.height / 2): \(-minY < (size.height / 2))")
//                print("minY < (size.height / 2): \(minY < (size.height / 2))")

                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0 ..< tabs.count) { index in
                            Text("Content for \(tabs[index])")
                                .font(.title)
                                .frame(maxWidth: .infinity, minHeight: 300)
                                .background(selectedTab == index ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .id(index)
                                .onTapGesture {
                                    selectedTab = index
                                }
                        }
                    }
                    .onChange(of: selectedTab) { _ in
                        withAnimation {
                            proxy.scrollTo(selectedTab, anchor: .top)
                        }
                    }
                }
            }
        }
    }
}

struct DemoScrollViewOffsetView: View {
    @State private var offset = CGFloat.zero
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0 ..< 100) { i in
                    Text("Item \(i)").padding()
                }
            }.background(GeometryReader {
                Color.clear.preference(key: ViewOffsetKey.self,
                                       value: -$0.frame(in: .named("scroll")).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self) { print("offset >> \($0)") }
        }.coordinateSpace(name: "scroll")
    }
}

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct SelectedItem: Identifiable, Equatable {
    let id = UUID()
    let name: String
}

struct Model {
    var items: [SelectedItem]
    init() {
        items = []
        for i in 0 ..< 100 {
            items.append(SelectedItem(name: "Item \(i)"))
        }
    }
}

struct SelectedItemView: View {
    let data = Model()

    @State private var selectedItem: SelectedItem? = nil

    var body: some View {
        ScrollView {
            ForEach(data.items) { item in
                Button(item.name) {
                    selectedItem = item
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                .overlay(
                    Text("Info for \(item.name)")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                        .opacity(selectedItem == item ? 0.9 : 0)
                        .zIndex(1)
                )
            }
        }
    }
}

struct GridWithScrollView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedItemView()
    }
}

import SwiftUI

extension View {
    public func customBottomSheet<SheetContent: View>(
        isPresented: Binding<Bool>,
        sheetContent: @escaping () -> SheetContent
    ) -> some View {
        modifier(BottomSheet(isPresented: isPresented, sheetContent: sheetContent))
    }
}

struct BottomSheet<SheetContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let sheetContent: () -> SheetContent

    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer()
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    self.isPresented = false
                                }
                            }) {
                                Text("done")
                                    .padding(.top, 5)
                            }
                        }

                        sheetContent()
                    }
                    .padding()
                }
                .zIndex(.infinity)
                .transition(.move(edge: .bottom))
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
}

// version branch
extension View {
    @ViewBuilder
    func modify<Content: View>(@ViewBuilder _ transform: (Self) -> Content?) -> some View {
        if let view = transform(self), !(view is EmptyView) {
            view
        } else {
            self
        }
    }
}

// view()
// .modify {
//    if #available(iOS 16.0, *) {
//        $0.sheet(isPresented: $showingAddSheet) {
//            // sheetView()
//            .presentationDetents([.medium])
//        }
//    } else {
//        $0.customBottomSheet(isPresented: $showingAddSheet) {
//            // sheetView()
//        }
//    }
// }
