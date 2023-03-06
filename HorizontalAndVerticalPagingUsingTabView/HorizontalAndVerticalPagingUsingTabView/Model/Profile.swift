//
//  Profile.swift
//  HorizontalAndVerticalPagingUsingTabView
//
//  Created by Jmy on 2023/03/06.
//

import Foundation

struct Profile: Identifiable {
    var id: Int
    var name: String
    var image: String
}

var data = [
    Profile(id: 0, name: "Photo1", image: "https://i.pinimg.com/originals/f8/bc/3d/f8bc3d093e75df741eb536eb3078ff9e.jpg"),
    Profile(id: 1, name: "Photo2", image: "https://i.pinimg.com/564x/80/db/f7/80dbf7d7b9e598cf591593b0e9f6f10a.jpg"),
    Profile(id: 2, name: "Photo3", image: "https://i.pinimg.com/originals/0d/56/5b/0d565b58c4c5f2fe4b252994ac54e329.jpg"),
    Profile(id: 3, name: "Photo4", image: "https://i.pinimg.com/originals/da/f7/af/daf7af53cb6bbb5e343e82527b1e359d.jpg"),
    Profile(id: 4, name: "Photo5", image: "https://i.pinimg.com/originals/2f/be/1b/2fbe1b30103101bb1ad7ca3e9805ec05.jpg"),
]
