import UIKit

class DetailsViewController: UIViewController{
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonWeakness: UILabel!
    @IBOutlet weak var pokemonHP: UILabel!
    @IBOutlet weak var pokemonNumber: UILabel!
    @IBOutlet weak var pokemonEvolves: UILabel!
    @IBOutlet weak var pokemonCard: UIImageView!
    @IBOutlet weak var pokemonType: UILabel!
    
    var card: Card!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemonCard.layer.cornerRadius = 8
        pokemonCard.layer.masksToBounds = true
        pokemonCard.contentMode = .scaleAspectFill
        pokemonCard.backgroundColor = .red
        
        configure(with: card)
        
    }
    func configure(with card: Card){
        pokemonName.text = card.name
        pokemonHP.text = "HP: \(card.hp)"
        pokemonNumber.text = "Numero: \(card.nationalPokedexNumbers![0])"
        pokemonEvolves.text = "Evolui de: \(card.evolvesFrom ?? " ")"
        if card.types != nil{
            pokemonType.text = "Tipo: \(card.types[0])"
        } else {
            pokemonType.text = "Pokemon não evolui de outro"
        }
        pokemonCard.download(path: card.images.large)
    }
}
