//
//  delete button.swift
//  Plant App
//
//  Created by Manar on 27/10/2025.
//

import SwiftUI

struct delete_button: View {
    var body: some View {
        VStack {
            VStack(spacing: 10) {
                
                HStack {
                    Button(action: {
                        // withAnimation { showSheet = false }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Darkm"))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    
                    Spacer()
                    
                    Text("Set Reminder")
                        .foregroundColor(.white)
                        .font(.system(size: 19))
                    
                    Spacer()
                    
                    Button(action: {
                        //    withAnimation { showSheet = false }
                    }) {
                        Image(systemName: "checkmark")
                            .font(.system(size: 23, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Greene"))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 30)
                
                // --------------------------------- حقل Plant Name
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 380, height: 59)
                    
                    HStack {
                        Text("Plant Name")
                            .foregroundColor(.white)
                            .padding(.leading, 25)
                        
                        Spacer()
                        
                        TextField("Pothos", text: .constant(""))
                            .foregroundColor(.gray)
                            .padding(.trailing, 25)
                    }
                }
                .padding(.top, 40)
                
                // --------------------------------- Room + Light
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 388, height: 108)
                    Spacer().frame(height: 150)
                    
                    VStack(spacing: 15) {
                        // Room
                        HStack {
                            HStack(spacing: 6) {
                                Image(systemName: "location")
                                    .foregroundColor(.white)
                                Text("Room")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Menu {
                                Button("Bedroom") { }
                                Button("Living Room") { }
                                Button("Kitchen") { }
                                Button("Balcony") { }
                                Button("Bathroom") { }
                            } label: {
                                HStack(spacing: 6) {
                                    Text("Bedroom")
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                                .foregroundColor(.white)
                            }
                        }
                        ZStack {
                            Rectangle()
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 1)
                        }
                        // Light
                        HStack {
                            HStack(spacing: 6) {
                                Image(systemName: "sun.max")
                                    .foregroundColor(.white)
                                Text("Light")
                                    .foregroundColor(.white)
                            }
                            Spacer()
                            Menu {
                                Button("􀆭 Full Sun") { }
                                Button("􀆷 Partial Sun") { }
                                Button("􀆹 Low Light") { }
                            } label: {
                                HStack(spacing: 6) {
                                    Text("Full Sun")
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                                .foregroundColor(.white)
                            }
                        }
                        
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.top, 20)
                ZStack(alignment: .bottom){
                    
                    Spacer()
                        
                        .frame(height: 150)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 388, height: 108)
                    
                    
                    VStack(spacing: 10) {
                        
                        // Watering days
                        HStack{
                            Image(systemName: "drop")
                                .foregroundColor(.white)
                            Text("Watering Days")
                                .foregroundColor(.white)
                        Spacer()
                            Menu {
                                Button("Every Day") { }
                                Button("Every 2 days") { }
                                Button("Every 3 days") { }
                                Button("Once a week") { }
                                Button("Every 10 days") { }
                                Button("Every 2 weeks") { }
                            } label: {
                                HStack(spacing: 10) {
                                    Text("Every Day")
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                                .foregroundColor(.white)
                            }
                        }
                        
                        // 🔴 Divider
                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 1)
                        
                        // 🔴 Age
                        HStack {
                            Image(systemName: "drop")
                                .foregroundColor(.white)
                            Text("Water")
                                .foregroundColor(.white)
                            Spacer()
                            Menu {
                                Button("20 - 50 ml") { }
                                Button("50 - 100 ml") { }
                                Button("100 - 200 ml") { }
                                Button("200 - 300 ml") { }
                                
                            } label: {
                                HStack(spacing: 6) {
                                    Text("20 - 50 ml")
                                    Image(systemName: "chevron.up.chevron.down")
                                }
                                .foregroundColor(.white)
                            }
                        }
                        
                        
                        //-----------------------------------------
                        
                        
                        
                        .padding(8) // مسافة عن الزاوية
                    }

                }
                .padding(.horizontal, 20)

                // 🔴 Delete Box نا نضيف الزر الجديد
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white.opacity(0.1)) // نفس لون البوكسات
                        .frame(width: 388, height: 59)
                    
                    Button(action: {
                        print("Delete tapped")
                    }) {
                        Text("Delete Reminder")
                            .foregroundColor(.red) // النص فقط أحمر
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                    }
                    .frame(width: 388, height: 59)
                }
                .padding(.top, 20)

            }
        }
        .padding(.bottom,-100 )
        
        
        
        
        .offset(y: -150) // عدلي الرقم
        
        .frame(maxWidth: .infinity)
        .frame(height: 790)
        .background(
            Color("Darkm")
                .cornerRadius(30)
                .padding(.bottom, -25)
        )
    
        //sheet effect ------------------------------
            .transition(.move(edge: .bottom))
               .zIndex(1)
        }
    }
    

#Preview {
    delete_button()
}
