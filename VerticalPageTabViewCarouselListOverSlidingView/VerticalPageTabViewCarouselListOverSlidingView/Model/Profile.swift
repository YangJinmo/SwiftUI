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
    Profile(id: 0, name: "Photo1", image: "https://blog.kakaocdn.net/dn/bfidfR/btqTcPLxr0r/LO9jnhLSdBQm6QXUAWgux0/img.png"),
    Profile(id: 1, name: "Photo2", image: "https://image.fmkorea.com/files/attach/new2/20221002/3254535/4585351500/5069085094/ba2d57bc21d168cb2ee6028e1440c100.png"),
    Profile(id: 2, name: "Photo3", image: "https://i.pinimg.com/236x/aa/68/82/aa68820fbf5be2da3a4865144e397783.jpg"),
    Profile(id: 3, name: "Photo4", image: "https://image.musinsa.com/mfile_s01/2019/04/08/8b053f5623f2ff61e2dc1891a9820b0a182323.jpg"),
    Profile(id: 4, name: "Photo5", image: "https://image.musinsa.com/mfile_s01/2019/04/08/fde6a902e51d0b8208e6dc907a5a37ca182323.jpg"),
]
