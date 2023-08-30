import UIKit

class CardsViewController: UIViewController {
    
    private var cards: [Card] = []
    
// MARK: - Criação de componentes
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Poke Cards"
        return label
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .none
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView(){
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        addViewsInHierarchy()
        setupConstraints()
        fetchRemoteCartds()
    }
    
    //MARK: - Adicionar views na hierarquia
    private func addViewsInHierarchy(){
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
    }
    
    //MARK: - Setup das constraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
        
    }
    
    
    private func fetchRemoteCartds() {
        let url = URL(string: "https://api.pokemontcg.io/v2/cards?api_key=d6f39d9c-59c4-471b-b2cb-1fd8bef8f88f")!
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        
        let task = URLSession.shared.dataTask(with: request){ data, _, error in
            if error != nil { print(error); return }
            
            guard let data else { return }
            
            print(String(data: data, encoding: .utf8))
            
            guard let remoteCards = try? decoder.decode(PokeTCGApi.self, from: data )  else { print("erro", error);return}
            print(remoteCards)
            
            self.cards = remoteCards.data
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        task.resume()
    }
}

extension CardsViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        cards.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CardCell()
        let card = cards[indexPath.row]
        cell.setup(card: card)
        return cell
    }
}

extension CardsViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = cards[indexPath.row]
        let storyboard = UIStoryboard(name: "Details", bundle: Bundle(for:DetailsViewController.self))
        let detailsViewController = storyboard.instantiateViewController(withIdentifier: "Details") as! DetailsViewController
        detailsViewController.card = card
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
}

