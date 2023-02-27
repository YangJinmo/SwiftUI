//
//  Food.swift
//  Animated Header
//
//  Created by Jmy on 2023/02/27.
//

import Foundation

struct Food: Identifiable {
    var id = UUID().uuidString
    var title: String
    var description: String
    var price: String
    var image: String
}

var food = Food(
    title: "",
    description: "",
    price: "",
    image: "https://hips.hearstapps.com/hmg-prod/images/766/healthyfoodsnoteveryday-main-1508848485.jpg"
)

var foods = [
    Food(
        title: "Chocolate Cake",
        description: "Chocolate cake or chocolate gâteau is a cake flavored with melted chocolate, cocoa powder, or both",
        price: "$19",
        image: "https://i.ytimg.com/vi/Kv38mphgpqw/maxresdefault.jpg"
    ),
    Food(
        title: "Cookies",
        description: "A biscuit is a flour-based baked food product. Outside North America the bisquit is typically hard, flat, and unleavened",
        price: "$10",
        image: "https://assets.bonappetit.com/photos/5ca534485e96521ff23b382b/5:4/w_3375,h_2700,c_limit/chocolate-chip-cookie.jpg"
    ),
    Food(
        title: "Sandwich",
        description: "Trim the bread from all sides and apply butter on one bread, then apply the green chutney all over",
        price: "$9",
        image: "https://images.ctfassets.net/uexfe9h31g3m/30PK5LALEpgExQcAR9j522/7becc83c5c40312d3e81acbe5dbeb44a/Quorn_UK_deli_recipe_yorkshire-ham_1024x768.jpg?w=2000&h=2000&fm=jpg&fit=thumb&q=90&fl=progressive"
    ),
    Food(
        title: "French Fries",
        description: "French Fries, or simply fries, chips, finger chips, or French-fried potatoes, are batonnet or allumette-cut deep-fried potatoes.",
        price: "$15",
        image: "https://www.allrecipes.com/thmb/2DKPE5NB7c20ES4vhpwciKU3Low=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/French-Fries-4x3-1-2000-0a55bb658a0d41aca29f0ec4c8eba47c.jpg"
    ),
    Food(
        title: "Pizza",
        description: "Pizza is a savory dish of Italian origin consisting of a usually round, flattened base of leavened wheat-based daugh topped",
        price: "$39",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Eq_it-na_pizza-margherita_sep2005_sml.jpg/800px-Eq_it-na_pizza-margherita_sep2005_sml.jpg"
    ),
]
