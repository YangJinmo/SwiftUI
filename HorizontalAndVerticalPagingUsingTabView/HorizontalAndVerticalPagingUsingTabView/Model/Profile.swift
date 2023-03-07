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

var verticalProfiles = [
    Profile(id: 0, name: "Vertical Profile 1", image: "https://i.pinimg.com/originals/f8/bc/3d/f8bc3d093e75df741eb536eb3078ff9e.jpg"),
    Profile(id: 1, name: "Vertical Profile 2", image: "https://i.pinimg.com/564x/80/db/f7/80dbf7d7b9e598cf591593b0e9f6f10a.jpg"),
    Profile(id: 2, name: "Vertical Profile 3", image: "https://i.pinimg.com/originals/0d/56/5b/0d565b58c4c5f2fe4b252994ac54e329.jpg"),
    Profile(id: 3, name: "Vertical Profile 4", image: "https://i.pinimg.com/originals/da/f7/af/daf7af53cb6bbb5e343e82527b1e359d.jpg"),
    Profile(id: 4, name: "Vertical Profile 5", image: "https://i.pinimg.com/originals/2f/be/1b/2fbe1b30103101bb1ad7ca3e9805ec05.jpg"),
]

var horizontalProfiles = [
    Profile(id: 0, name: "Horizontal Profile 1", image: "https://image.musinsa.com/mfile_s01/2019/04/08/fde6a902e51d0b8208e6dc907a5a37ca182323.jpg"),
    Profile(id: 1, name: "Horizontal Profile 2", image: "https://image.fmkorea.com/files/attach/new2/20221002/3254535/4585351500/5069085094/ba2d57bc21d168cb2ee6028e1440c100.png"),
    Profile(id: 2, name: "Horizontal Profile 3", image: "https://i.pinimg.com/236x/aa/68/82/aa68820fbf5be2da3a4865144e397783.jpg"),
    Profile(id: 3, name: "Horizontal Profile 4", image: "https://image.musinsa.com/mfile_s01/2019/04/08/8b053f5623f2ff61e2dc1891a9820b0a182323.jpg"),
    Profile(id: 4, name: "Horizontal Profile 5", image: "https://blog.kakaocdn.net/dn/bfidfR/btqTcPLxr0r/LO9jnhLSdBQm6QXUAWgux0/img.png"),
]
