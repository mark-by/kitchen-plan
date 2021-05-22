import UIKit
import PinLayout

final class IngredientsViewController: UIViewController {
    private let collectionView: UICollectionView = {
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical

        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
    }()
    private let output: IngredientsViewOutput
    private let addButton: UIBarButtonItem?
    
    var mocks: [IngredientsViewModel] = [
        IngredientsViewModel(id: 0, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
        IngredientsViewModel(id: 1, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
        IngredientsViewModel(id: 2, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
        IngredientsViewModel(id: 3, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
        IngredientsViewModel(id: 4, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
        IngredientsViewModel(id: 5, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
        IngredientsViewModel(id: 6, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
        IngredientsViewModel(id: 7, title: "тест 1", image: "https://storage.yandexcloud.net/kitchen-plan/ingredients/10011.jpg"),
    ]

    init(output: IngredientsViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let bar = navigationController?.navigationBar {
            overrideNavigateBar(bar)
        }

        overrideUserInterfaceStyle = .light

        view.backgroundColor = .white
        
        let add = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(<#T##@objc method#>)
        )
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IngredientsViewCell.self, forCellWithReuseIdentifier: "IngredientsCollectionViewCell")

        view.addSubview(collectionView)
        output.didLoadView()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.pin.all()
    }
    
    @objc func didTapAddButton() {
        let ingredientSearch = IngredientsSearchViewController(output: output as! IngredientsSearchViewOutput)
        ingredientSearch.mainViewController = self
        present(ingredientSearch, animated: true, completion: nil)
    }
}
    
extension IngredientsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IngredientsCollectionViewCell", for: indexPath) as? IngredientsViewCell else {
            return .init()
        }
        
        cell.configure(with: mocks[indexPath.item % mocks.count])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 2
        let sideLength = availableWidth / 3
        
        return CGSize(width: sideLength, height: sideLength)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
