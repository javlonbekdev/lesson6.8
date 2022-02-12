//
//  AddPostScreen.swift
//  lesson8.8
//
//  Created by Javlonbek on 05/02/22.
//

import SwiftUI

struct AddPostScreen: View {
    @ObservedObject var storage = StorageStore()
    @ObservedObject var database = RealtimeStore()
    @Environment(\.presentationMode) var presentation
    @State var isLoading = false
    @State var firstname = ""
    @State var lastname = ""
    @State var phone = ""
    
    @State var defImage = Image(systemName: "person.fill")
    @State var pickedImage: UIImage? = nil
    @State var showImagePicker: Bool = false
    
    func addNewPost(urlString: String) {
        isLoading = true
        let post = Post(firstname: firstname, lastname: lastname, phone: phone, imgUrl: urlString)
        database.storePost(post: post) { success in
            if success {
                print(success)
                self.presentation.wrappedValue.dismiss()
            }
            isLoading = false
        }
    }
    
    func uploadImage() {
        storage.uploadImage(pickedImage!) { downloadURL in
            let urlString = downloadURL!.absoluteString
            print(urlString)
            addNewPost(urlString: urlString)
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                Button(action: {
                                    self.showImagePicker.toggle()
                                }, label: {
                                    ZStack{
                                        if pickedImage != nil {
                                            Image(uiImage: pickedImage!).resizable()
                                        } else {
                                            defImage.resizable()
                                        }
                                    }.frame(height: 100).frame(width: 100).scaledToFit()
                                })
                                .sheet(isPresented: $showImagePicker, onDismiss: {
                                    self.showImagePicker = false
                                }, content: {
                                    ImagePicker(image: self.$pickedImage, isShown: self.$showImagePicker)
                                })
                
                TextField("Firstname", text: $firstname)
                    .frame(maxWidth: .infinity).padding().background(.gray.opacity(0.2)).cornerRadius(8)
                
                TextField("Lastname", text: $lastname)
                    .frame(maxWidth: .infinity).padding().background(.gray.opacity(0.2)).cornerRadius(8)
                
                TextField("Phone", text: $phone)
                    .frame(maxWidth: .infinity).padding().background(.gray.opacity(0.2)).cornerRadius(8)
                
                Button {
//                    addNewPost()
                    uploadImage()
                } label: {
                    Spacer()
                    Text("Add").foregroundColor(.white)
                    Spacer()
                }.padding().background(.red).cornerRadius(8)
                
                Spacer()
            }.padding()
            if isLoading {
                ProgressView()
            }
        }.navigationTitle("Add Contact")
            .navigationBarItems(leading: Button(action: {
                presentation.wrappedValue.dismiss()
            }, label: {
                HStack{
                    Image(systemName: "chevron.backward")
                    Text("Posts")
                }
            })).foregroundColor(.red)
            .navigationBarBackButtonHidden(true)
    }
}

struct AddPostScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddPostScreen()
    }
}
