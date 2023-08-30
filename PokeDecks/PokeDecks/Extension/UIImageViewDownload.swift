import UIKit

extension UIImageView{
    func download(path: String){
        if path == path, !path.isEmpty, let imageUrl = URL(string: path) {
            
            let task = URLSession.shared.dataTask(with: .init(url: imageUrl)) { data, response, error in
                if error != nil { return }
                
                guard let data else { return }
                
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
            task.resume()
        }
    }
}

