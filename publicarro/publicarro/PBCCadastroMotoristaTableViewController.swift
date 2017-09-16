
import UIKit

class PBCCadastroMotoristaTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //OUTLES
    @IBOutlet weak var telefone: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var cepResidencial: UITextField!
    @IBOutlet weak var cepProfissional: UITextField!
    @IBOutlet weak var cepEducacional: UITextField!
    @IBOutlet weak var renavamCarro: UITextField!
    
    @IBOutlet weak var imagePicker: UIButton!
    let picker = UIImagePickerController()
    
    var chosenImage : UIImage?
    var imageZoom : UIImageView?
    var scrollView: UIScrollView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adicionando delegate aos outlets
        self.telefone.delegate = self
        self.cepResidencial.delegate = self
        self.cepProfissional.delegate = self
        self.cepEducacional.delegate = self
        self.email.delegate = self
        self.senha.delegate = self
        self.renavamCarro.delegate = self
        
        picker.delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //TABLEVIEW
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    
    //TEXTFIELD
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if(textField == self.telefone)
        {
            return maskTelefone(textField, replacementString: string)
        }
        if(textField == self.cepResidencial || textField == self.cepProfissional || textField == self.cepEducacional)
        {
            return maskCep(textField, replacementString: string)
        }
        return true
    }
    
    // máscara para telefone
    func maskTelefone(textField: UITextField, replacementString string: String) -> Bool
    {
        if (string.characters.count >= 1) {
            if (textField.text?.characters.count <= 14) {
                if (textField.text?.characters.count == 2) {
                    let tempStr = "(" + textField.text! + ") "
                    textField.text = tempStr
                    
                } else if (textField.text?.characters.count == 10) {
                    let tempStr = textField.text! + "-"
                    textField.text = tempStr
                }
            } else {
                return false;
            }
        }
        return true
    }
    
    
    // máscara para cep
    func maskCep(textField: UITextField, replacementString string: String) -> Bool
    {
        if (string.characters.count >= 1) {
            if (textField.text?.characters.count <= 9) {
                if (textField.text?.characters.count == 2) {
                    let tempStr = textField.text! + "."
                    textField.text = tempStr
                    
                } else if (textField.text?.characters.count == 6) {
                    let tempStr = textField.text! + "-"
                    textField.text = tempStr
                }
            } else {
                return false;
            }
        }
        return true
    }
    
    //IMAGE
    @IBAction func imagePickerAction(sender: AnyObject)
    {
        
        let actionSheetCamera = UIAlertController(title: "", message: "Adicione a foto da sua habilitação", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        
        let camera = UIAlertAction(title: "Tirar foto", style: .Default, handler: { (camera) -> Void in
            self.shootPhoto()
        })

        let library = UIAlertAction(title: "Biblioteca de fotos", style: .Default, handler: { (camera) -> Void in
            self.photoFromLibrary()
        })

        let showPhoto = UIAlertAction(title: "Visualizar", style: .Default, handler: { (camera) -> Void in
            
            print("ver foto")
        })
        
        let cancel = UIAlertAction(title: "Cancelar", style: .Cancel, handler: { (cancel) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
        
        if (imagePicker.imageView?.backgroundColor != chosenImage)
        {
            actionSheetCamera.addAction(showPhoto)
        }
        actionSheetCamera.addAction(camera)
        actionSheetCamera.addAction(library)
        actionSheetCamera.addAction(cancel)
        
       
        
        self.presentViewController(actionSheetCamera, animated: true, completion: nil)


        
    }
    
    func shootPhoto() {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            picker.modalPresentationStyle = .FullScreen
            presentViewController(picker,
                animated: true,
                completion: nil)
        }
    }
    
    func photoFromLibrary()
    {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        picker.modalPresentationStyle = .Popover
        presentViewController(picker,
            animated: true,
            completion: nil)//4
        
    }
    
    //MARK: Delegates
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        imagePicker.setBackgroundImage(chosenImage, forState: UIControlState.Normal)
        
        dismissViewControllerAnimated(true, completion: nil) //5
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController)
    {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
        
}
