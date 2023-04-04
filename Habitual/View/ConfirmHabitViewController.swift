//
//  ConfirmHabitViewController.swift
//  Habitual
//
//  Created by Claudia Munoz on 3/29/23.
//

import UIKit

class ConfirmHabitViewController: UIViewController {
    var habitImage: Habit.Images!
    
    @IBOutlet weak var habitImageView: UIImageView!
    
    @IBOutlet weak var habitNameInputField: UITextField!
    
    @IBAction func createHabitButtonPressed(_ sender: Any) {
        var persistenceLayer = PersistenceLayer()
            guard let habitText = habitNameInputField.text else { return }
            
            persistenceLayer.createNewHabit(name: habitText, image: habitImage)
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        title = "New Habit"
        habitImageView.image = habitImage.image
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
