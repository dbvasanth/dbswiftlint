//
//  PackageRequiredTableViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 03/10/22.
//

import UIKit
import DTTextField

class PackageRequiredTableViewCell: UITableViewCell {
    @IBOutlet weak var bloodtestTextField: DTTextField!
    @IBOutlet weak var ctscansTextField: DTTextField!
    @IBOutlet weak var ultrasoundTextField: DTTextField!
    @IBOutlet weak var xrayTextField: DTTextField!
    
    var nextAction : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup(){
        bloodtestTextField.borderColor = .clear
        ctscansTextField.borderColor = .clear
        ultrasoundTextField.borderColor = .clear
        xrayTextField.borderColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func bloodTestTapped(_ sender: UIButton) {
    }
    @IBAction func ctScansTapped(_ sender: UIButton) {
    }
    @IBAction func ultraSoundTapped(_ sender: UIButton) {
    }
    @IBAction func xrayTapped(_ sender: UIButton) {
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        if let act = nextAction{
            act()
        }
    }
    
}
