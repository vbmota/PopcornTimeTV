

import Foundation

class DescriptionCollectionViewController: CollectionViewController {
    
    var headerTitle: String?
    var sizingCell: DescriptionCollectionViewCell?
    
    override var dataSource: [AnyHashable] {
        get {
            return dataSourceTuple.flatMap({ $0.value })
        } set {}
    }
    
    var dataSourceTuple: [(key: Any, value: String)] = [("", "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(UINib(nibName: String(describing: DescriptionCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: "cell")
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DescriptionCollectionViewCell
        
        let data = dataSourceTuple[indexPath.row]
        
        if let text = data.key as? String {
            cell.keyLabel.text = text
        } else if let attributedText = data.key as? NSAttributedString {
            cell.keyLabel.attributedText = attributedText
        }
        cell.valueLabel.text = data.value
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = dataSourceTuple[indexPath.row]
        
        sizingCell = sizingCell ?? .fromNib()
        
        if let text = data.key as? String {
            sizingCell?.keyLabel.text = text
        } else if let attributedText = data.key as? NSAttributedString {
            sizingCell?.keyLabel.attributedText = attributedText
        }
        sizingCell?.valueLabel.text = data.value
        
        sizingCell?.setNeedsLayout()
        sizingCell?.layoutIfNeeded()
        
        return sizingCell?.systemLayoutSizeFitting(UILayoutFittingCompressedSize) ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return headerTitle == nil ? .zero : CGSize(width: collectionView.bounds.width, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader, let title = headerTitle {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)
            
            let titleLabel = view.viewWithTag(1) as? UILabel
            titleLabel?.text = title
            
            return view
        }
        return super.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }
}
