//
//  Movie.swift
//  Hackathon
//
//  Created by Cole on 12/1/23.
//

import Foundation

struct Movie: Decodable {
    let name: String
    let length: Int
    let genre: String
    let description: String
}

extension Movie {
    static let dummyData = [
    
    Movie(
        name: "Raiders of the Lost Ark",
        length: 115,
        genre: "Action",
        description: "Raiders of the Lost Ark[b] is a 1981 American action-adventure film directed by Steven Spielberg from a screenplay by Lawrence Kasdan, based on a story by George Lucas and Philip Kaufman. Set in 1936, the film stars Harrison Ford as Indiana Jones, a globetrotting archaeologist vying with Nazi German forces to recover the long-lost Ark of the Covenant which is said to make an army invincible. Teaming up with his tough former romantic interest Marion Ravenwood (Karen Allen), Jones races to stop rival archaeologist Dr. René Belloq (Paul Freeman) from guiding the Nazis to the Ark and its power."
    ),
    Movie(
        name: "Murder on the Orient Express",
        length: 114,
        genre: "Mystery",
        description: "Murder on the Orient Express is a 2017 mystery film co-produced and directed by Kenneth Branagh from a screenplay by Michael Green, based on the 1934 novel of the same name by Agatha Christie. The film stars an ensemble cast with Branagh as Hercule Poirot, alongside Tom Bateman, Penélope Cruz, Willem Dafoe, Judi Dench, Johnny Depp, Josh Gad, Derek Jacobi, Leslie Odom Jr., Michelle Pfeiffer, and Daisy Ridley.[7] The plot follows Poirot, a world-renowned detective, as he investigates a murder on the luxury Orient Express train service in the 1930s."
    ),
    Movie(
        name: "Ferris Bueller's Day Off",
        length: 103,
        genre: "Comedy",
        description: "Ferris Bueller's Day Off is a 1986 American teen comedy film written, co-produced, and directed by John Hughes and co-produced by Tom Jacobson. The film stars Matthew Broderick, Mia Sara, and Alan Ruck, with supporting roles from Jennifer Grey, Jeffrey Jones, Cindy Pickett, Edie McClurg, and Lyman Ward. It tells the story of a high school slacker, Ferris, who skips school with his best friend, Cameron, and his girlfriend, Sloane, for a day in Chicago, and regularly breaks the fourth wall to explain his techniques and inner thoughts."
    )
    
    
        
    ]
}

//extension Recipe {
//    
//    static let dummyData = [
//        Recipe(
//            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
//            description: "This ropa vieja is great served on tortillas or over rice. Add sour cream, cheese, and fresh cilantro on the side.",
//            difficulty: "Intermediate",
//            imageUrl: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8368708.jpg&q=60&c=sc&orient=true&poi=auto&h=512",
//            name: "Cuban Ropa Vieja",
//            rating: 4.4
//        ),
//        Recipe(
//            id: "9d40a3f8-a40f-48c0-9aa6-28031fddde81",
//            description: "You only need 3 ingredients for this crockpot Italian chicken with Italian dressing and Parmesan cheese. Nothing could be easier than this for a weekday meal that's ready when you get home.",
//            difficulty: "Beginner",
//            imageUrl: "https://www.allrecipes.com/thmb/cLLmeWO7j9YYI66vL3eZzUL_NKQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7501402crockpot-italian-chicken-recipe-fabeveryday4x3-223051c7188841cb8fd7189958c62f3d.jpg",
//            name: "Crockpot Italian Chicken",
//            rating: 4.5
//        ),
//        Recipe(
//            id: "0c28ab59-e99d-4ec1-be2f-359a92537560",
//            description: "This crockpot mac and cheese recipe is creamy, comforting, and takes just moments to assemble in a slow cooker. Great for large family gatherings and to take to potluck dinners. It's always a big hit!",
//            difficulty: "Beginner",
//            imageUrl: "https://www.allrecipes.com/thmb/wRSDpUgu8VR2PpQtjGq97cuk8Fo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/237311-slow-cooker-mac-and-cheese-DDMFS-4x3-9b4a15f2c3344c1da22b034bc3b35683.jpg",
//            name: "Slow Cooker Mac and Cheese",
//            rating: 4.3
//        ),
//        Recipe(
//            id: "ef10e605-65d0-4a85-9fd8-8e3294939473",
//            description: "My mother was one of the best cooks I ever knew. Whenever she made stews we mostly found homemade dumplings in them. We never ate things from packages or microwaves and you sure could taste what food was. That's the only way I cook today - I don't use any electronic gadgets to cook with except an electric stove.",
//            difficulty: "Beginner",
//            imageUrl: "https://www.allrecipes.com/thmb/neJT4JLJz7ks8D0Rkvzf8fRufWY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/6900-dumplings-DDMFS-4x3-c03fe714205d4f24bd74b99768142864.jpg",
//            name: "Homemade Dumplings",
//            rating: 4.7
//        ),
//        Recipe(
//            id: "a69bdffc-c9ba-428b-8f06-24cef356a611",
//            description: "Succulent pork loin with fragrant garlic, rosemary, and wine.",
//            difficulty: "Advanced",
//            imageUrl: "https://www.allrecipes.com/thmb/llWmU-j1PO7kCPvKkzQnfmeBf0M=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/21766-roasted-pork-loin-DDMFS-4x3-42648a2d6acf4ef3a05124ef5010c4fb.jpg",
//            name: "Roasted Pork Loin",
//            rating: 4.5
//        ),
//        Recipe(
//            id: "85745755-11dd-4e68-8953-15f5194971bc",
//            description: "My version of chicken Parmesan is a little different than what they do in the restaurants, with less sauce and a crispier crust.",
//            difficulty: "Intermediate",
//            imageUrl: "https://www.allrecipes.com/thmb/0NW5WeQpXaotyZHJnK1e1mFWcCk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/223042-Chicken-Parmesan-mfs_001-7ab952346edc4b2da36f3c0259b78543.jpg",
//            name: "Chicken Parmesan",
//            rating: 4.8
//        )
//    ]
//    
//}
//
