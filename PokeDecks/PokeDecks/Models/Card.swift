struct Card: Decodable {

    let name: String
    let hp: String
    let evolvesFrom: String?
    let types: [String]
    let nationalPokedexNumbers: [Int]?
    let images: Images
    let weaknesses: Weakness?
      
       
    struct Images: Decodable {
        let small: String
        let large: String
       }
    
    struct Weakness: Decodable{
        let type: String
        let value: String
    }
    
}

