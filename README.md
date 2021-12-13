# Animaly - Frontend

Animaly is a mobile application designed for animals's lovers especially cats and dogs.
This application will give you the ability to adopt and buy animal equipments if needed. 

---
## Requirements

For development, you will need:

### Environnement Installation
- #### xCode installation

 Either on the AppStore of iOS or you need a virtual machine of macOS

 Once done , open xcode and create a new project :
  
       new project
       cocoa application
       name the project and select "Swift" and "Storyboard"

### Project architecture:
- #### MVVM
For our project we used the MVVM pattern to organise it : 
 
       Model
       ModelView
       View
       
### Model:
- #### Exemple User:

       struct User: Identifiable, Decodable, Equatable {
              var id : Int
              var email : String
              var mdp: String
              var nomprenom : String
              var adresse : String
              var localisation : String
              var role: String
              var pdp: String
        }
        
### Services:
- #### Exemple NodeUrl:

       import Foundation
        struct urlNode {
        var url: String = "http://192.168.254.128:3000/users/"
        }    
        
### Views:
- #### Exemple LoginViewController:
Containing the functions , IBOutels , and IBActions


### Interfaces:
![image](https://user-images.githubusercontent.com/79059784/145903407-9141da85-c86b-457b-9964-f5df4f4ae268.png)



      
