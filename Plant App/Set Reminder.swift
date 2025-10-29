//
//  Set Reminder.swift
//  Plant App
//
//  Created by Manar on 20/10/2025.
//

import SwiftUI

struct Plant: Identifiable {
    let id = UUID()
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isWatered: Bool = false
}

struct Set_Reminder: View {
    @State private var showSheet = false
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full Sun"
    @State private var wateringDays: String = "Every Day"
    @State private var waterAmount: String = "20 - 50 ml"
    
    @State private var plants: [Plant] = []

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 12) {
                // Header
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 50)
                    .padding(.horizontal, 20)
                
                Rectangle()
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 1)
                    .padding(.horizontal, 20)
                Spacer()
                Text("Your plants are waiting for a sip 💦")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                Spacer()
                
                // Progress
                let totalPlants = plants.count
                let wateredCount = plants.filter { $0.isWatered }.count
                let progressValue = totalPlants > 0 ? Float(wateredCount) / Float(totalPlants) : 0
                
                ProgressView(value: progressValue)
                    .padding(.horizontal, 20)
                    .tint(Color("Greene"))
                
                // List with swipe-to-delete
                List {
                    ForEach(plants.indices, id: \.self) { index in
                        let plant = plants[index]
                        
                        // إذا تبي تخفي المسقّاة مثل منطقك السابق:
                        if !plant.isWatered {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("In \(plant.room)")
                                    .font(.system(size: 15))
                                    .foregroundColor(.gray)
                                    
                                HStack(spacing: 10) {
                                    Image(systemName: plant.isWatered ? "checkmark.circle.fill" : "checkmark.circle")
                                        .foregroundColor(plant.isWatered ? Color("Greene") : .gray)
                                        .font(.system(size: 25))
                                        .onTapGesture {
                                            plants[index].isWatered.toggle()
                                        }
                                    
                                    Text(plant.name)
                                        .font(.system(size: 28))
                                        .foregroundColor(.white)
                                }
                                
                                HStack(spacing: 16) {
                                    HStack(spacing: 5) {
                                        Image(systemName: "sun.max")
                                            .foregroundColor(.yellow)
                                        Text(plant.light)
                                            .font(.system(size: 14))
                                            .foregroundColor(.yellow)
                                    }
                                    .padding(6)
                                    .background(Color.white.opacity(0.1))
                                    .cornerRadius(10)
                                    
                                    HStack(spacing: 5) {
                                        Image(systemName: "drop")
                                            .foregroundColor(.blue)
                                        Text(plant.waterAmount)
                                            .font(.system(size: 14))
                                            .foregroundColor(.blue)
                                    }
                                    .padding(6)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                }
                                
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 1)
                            }
                            .listRowBackground(Color.black)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    plants.remove(at: index)
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                        }
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden) // إخفاء خلفية الليست الافتراضية
                .background(Color.black)
            }
            
            // زر الإضافة فوق كل شيء
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation { showSheet = true }
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("Greene"))
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(20)
                }
            }
            
            // Sheet
            if showSheet {
                VStack {
                    VStack(spacing: 10) {
                        HStack {
                            Button(action: {
                                withAnimation { showSheet = false }
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
                                let newPlant = Plant(name: plantName.isEmpty ? "Pothos" : plantName,
                                                     room: selectedRoom,
                                                     light: selectedLight,
                                                     wateringDays: wateringDays,
                                                     waterAmount: waterAmount)
                                plants.append(newPlant)
                                
                                plantName = ""
                                selectedRoom = "Bedroom"
                                selectedLight = "Full Sun"
                                wateringDays = "Every Day"
                                waterAmount = "20 - 50 ml"
                                
                                withAnimation { showSheet = false }
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
                        
                        // Plant Name
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 380, height: 59)
                            HStack {
                                Text("Plant Name")
                                    .foregroundColor(.white)
                                    .padding(.leading, 25)
                                Spacer()
                                TextField("Pothos", text: $plantName)
                                    .foregroundColor(.white)
                                    .padding(.trailing, 25)
                            }
                        }
                        .padding(.top, 40)
                        
                        // Room + Light
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 388, height: 108)
                            VStack(spacing: 15) {
                                HStack {
                                    HStack(spacing: 6) {
                                        Image(systemName: "location")
                                            .foregroundColor(.white)
                                        Text("Room")
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    Menu {
                                        Button("Bedroom") { selectedRoom = "Bedroom" }
                                        Button("Living Room") { selectedRoom = "Living Room" }
                                        Button("Kitchen") { selectedRoom = "Kitchen" }
                                        Button("Balcony") { selectedRoom = "Balcony" }
                                        Button("Bathroom") { selectedRoom = "Bathroom" }
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text(selectedRoom)
                                            Image(systemName: "chevron.up.chevron.down")
                                        }
                                        .foregroundColor(.white)
                                    }
                                }
                                
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 1)
                                
                                HStack {
                                    HStack(spacing: 6) {
                                        Image(systemName: "sun.max")
                                            .foregroundColor(.white)
                                        Text("Light")
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    Menu {
                                        Button("Full Sun") { selectedLight = "Full Sun" }
                                        Button("Partial Sun") { selectedLight = "Partial Sun" }
                                        Button("Low Light") { selectedLight = "Low Light" }
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text(selectedLight)
                                            Image(systemName: "chevron.up.chevron.down")
                                        }
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 20)
                        
                        // Watering
                        ZStack {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.1))
                                .frame(width: 388, height: 108)
                            VStack(spacing: 15) {
                                HStack {
                                    Image(systemName: "drop")
                                        .foregroundColor(.white)
                                    Text("Watering Days")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Menu {
                                        Button("Every Day") { wateringDays = "Every Day" }
                                        Button("Every 2 days") { wateringDays = "Every 2 days" }
                                        Button("Every 3 days") { wateringDays = "Every 3 days" }
                                        Button("Once a week") { wateringDays = "Once a week" }
                                        Button("Every 10 days") { wateringDays = "Every 10 days" }
                                        Button("Every 2 weeks") { wateringDays = "Every 2 weeks" }
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text(wateringDays)
                                            Image(systemName: "chevron.up.chevron.down")
                                        }
                                        .foregroundColor(.white)
                                    }
                                }
                                
                                Rectangle()
                                    .fill(Color.white.opacity(0.2))
                                    .frame(height: 1)
                                
                                HStack {
                                    Image(systemName: "drop")
                                        .foregroundColor(.white)
                                    Text("Water")
                                        .foregroundColor(.white)
                                    Spacer()
                                    Menu {
                                        Button("20 - 50 ml") { waterAmount = "20 - 50 ml" }
                                        Button("50 - 100 ml") { waterAmount = "50 - 100 ml" }
                                        Button("100 - 200 ml") { waterAmount = "100 - 200 ml" }
                                        Button("200 - 300 ml") { waterAmount = "200 - 300 ml" }
                                    } label: {
                                        HStack(spacing: 6) {
                                            Text(waterAmount)
                                            Image(systemName: "chevron.up.chevron.down")
                                        }
                                        .foregroundColor(.white)
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.top, 40)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 790)
                    .offset(y: -170)
                    .background(
                        Color("Darkm")
                            .cornerRadius(30)
                            .padding(.bottom, -25)
                    )
                    .transition(.move(edge: .bottom))
                    .zIndex(1)
                }
            }
        }
    }
}

#Preview {
    Set_Reminder()
}
