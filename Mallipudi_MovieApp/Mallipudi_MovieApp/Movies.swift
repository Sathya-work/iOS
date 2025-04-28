//
//  Movies.swift
//  Mallipudi_MovieApp
//
//  Created by Sathyanarayana on 4/24/25.
//

import Foundation

struct Movies {
    var genre: String
    var list_Array: [MovieList]
}

struct MovieList {
    var movieName: String
    var movieImage: String
    var movieInfo: String
}

let genres = ["Action", "Drama", "Horror", "Sci-Fi"].sorted()

let actionMovies = [
    MovieList(movieName: "Mad Max: Fury Road", movieImage: "madmax", movieInfo: "In a post-apocalyptic wasteland, Max teams up with a mysterious woman, Furiosa. Together, they flee from a tyrannical ruler and his army in a high-octane chase. The film features explosive action sequences and stunning visuals."),
    MovieList(movieName: "John Wick", movieImage: "johnwick", movieInfo: "A legendary assassin comes out of retirement to avenge the death of his beloved dog. John Wick's path is filled with intense combat and breathtaking action. The underworld soon realizes they have crossed the wrong man."),
    MovieList(movieName: "Die Hard", movieImage: "diehard", movieInfo: "NYPD officer John McClane battles terrorists who have taken hostages in a Los Angeles skyscraper. With limited resources, he must outsmart the criminals and save his wife. This action thriller redefined the genre."),
    MovieList(movieName: "Gladiator", movieImage: "gladiator", movieInfo: "A Roman general is betrayed and his family murdered by a corrupt prince. Forced into slavery, he rises through the ranks of the gladiatorial arena. Driven by vengeance, he seeks justice for his loved ones."),
    MovieList(movieName: "The Dark Knight", movieImage: "darkknight", movieInfo: "Batman faces his greatest psychological and physical challenge when the Joker wreaks havoc on Gotham. With his moral limits tested, Batman must decide how far he is willing to go. The film explores chaos and heroism.")
]

let dramaMovies = [
    MovieList(movieName: "The Shawshank Redemption", movieImage: "shawshank", movieInfo: "Two imprisoned men form a deep bond over the years, finding solace and eventual redemption through acts of common decency. Their friendship transcends the harsh realities of prison life. This story is a powerful testament to hope and perseverance."),
    MovieList(movieName: "Forrest Gump", movieImage: "forrestgump", movieInfo: "A slow-witted but kind-hearted man witnesses and unwittingly influences several defining historical events. His unwavering love for Jenny shapes his life's journey. The film combines humor, drama, and nostalgia in a heartfelt narrative."),
    MovieList(movieName: "The Godfather", movieImage: "godfather", movieInfo: "The aging patriarch of a powerful crime family transfers control to his reluctant son. The story delves into loyalty, power, and betrayal within the mafia world. It is a profound exploration of family and corruption."),
    MovieList(movieName: "Fight Club", movieImage: "fightclub", movieInfo: "An insomniac office worker forms an underground fight club with a charismatic soap maker. Their rebellion against consumer culture spirals into chaos and destruction. The film challenges identity and societal norms."),
    MovieList(movieName: "12 Years a Slave", movieImage: "12years", movieInfo: "A free black man is kidnapped and sold into slavery in the pre-Civil War United States. His harrowing journey highlights the brutal realities of slavery and the resilience of the human spirit. This powerful narrative is both heartbreaking and inspiring.")
]

let horrorMovies = [
    MovieList(movieName: "The Conjuring", movieImage: "conjuring", movieInfo: "Paranormal investigators Ed and Lorraine Warren help a family terrorized by a dark presence in their farmhouse. The haunting escalates into terrifying supernatural events. The film blends suspense, scares, and a chilling true story."),
    MovieList(movieName: "Get Out", movieImage: "getout", movieInfo: "A young African-American man visits his white girlfriend’s family estate, uncovering disturbing secrets beneath the surface. The film combines social commentary with psychological horror. It is a sharp critique of racism wrapped in suspense."),
    MovieList(movieName: "It", movieImage: "it", movieInfo: "A group of kids in a small town face their worst fears when a shape-shifting evil clown terrorizes them. They must band together to confront the entity that preys on their childhoods. The film explores themes of friendship and overcoming fear."),
    MovieList(movieName: "A Quiet Place", movieImage: "quietplace", movieInfo: "In a post-apocalyptic world, a family lives in complete silence to avoid deadly creatures that hunt by sound. Their struggle to survive is filled with tension and emotional depth. The film masterfully uses silence as a storytelling device."),
    MovieList(movieName: "Hereditary", movieImage: "hereditary", movieInfo: "After the death of their secretive grandmother, a family is haunted by mysterious and tragic occurrences. Dark family secrets unravel, leading to terrifying consequences. The film is a disturbing exploration of grief and inherited trauma.")
]

let sciFiMovies = [
    MovieList(movieName: "Inception", movieImage: "inception", movieInfo: "A skilled thief steals secrets by entering people’s dreams, navigating complex layers of subconscious. He is offered a chance to erase his criminal past by planting an idea instead of stealing one. The film challenges perceptions of reality and time."),
    MovieList(movieName: "Interstellar", movieImage: "interstellar", movieInfo: "A team of explorers travel through a wormhole in space to find a new home for humanity as Earth faces environmental collapse. The journey tests their endurance and relationships across time and space. The film combines scientific theory with emotional storytelling."),
    MovieList(movieName: "The Matrix", movieImage: "matrix", movieInfo: "A hacker discovers that reality is a simulated construct controlled by machines. He joins a rebellion to free humanity from this illusion. The film revolutionized sci-fi cinema with its groundbreaking visual effects and philosophical themes."),
    MovieList(movieName: "Blade Runner 2049", movieImage: "bladerunner", movieInfo: "A young blade runner uncovers a long-buried secret that has the potential to disrupt society. His quest leads him to question the nature of humanity and identity. The film is a visually stunning exploration of dystopia and consciousness."),
    MovieList(movieName: "Dune", movieImage: "dune", movieInfo: "A young nobleman leads a rebellion on a desert planet rich in a valuable resource. Political intrigue and prophecy intertwine as he struggles to fulfill his destiny. The film is an epic tale of power, survival, and destiny in a vast universe.")
]

let moviesCollection: [Movies] = [
    Movies(genre: "Action", list_Array: actionMovies),
    Movies(genre: "Drama", list_Array: dramaMovies),
    Movies(genre: "Horror", list_Array: horrorMovies),
    Movies(genre: "Sci-Fi", list_Array: sciFiMovies)
]
