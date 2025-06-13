//
//  ContentView.swift
//  ElapsedDayApp
//
//  Created by Demian Turner on 13/06/2025.
//

import SwiftUI
import ElapsedDayShared

struct MainView: View {
    @State private var startDate: Date = ElapsedDayModel.startDate
    @State private var label: String = ElapsedDayModel.label
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                HeaderSection()
                
                DateSection(startDate: $startDate)
                
                LabelSection(label: $label)
                
                ElapsedDaysSection(startDate: startDate, label: label)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Elapsed Days")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

// MARK: - Subviews

private struct HeaderSection: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "calendar.badge.clock")
                .font(.system(size: 50))
                .foregroundStyle(.tint)
            
            Text("Track Your Progress")
                .font(.title2)
                .fontWeight(.medium)
        }
    }
}

private struct DateSection: View {
    @Binding var startDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Start Date", systemImage: "calendar")
                .font(.headline)
            
            DatePicker(
                "Select start date",
                selection: $startDate,
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .onChange(of: startDate) { _, newValue in
                ElapsedDayModel.startDate = newValue
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct LabelSection: View {
    @Binding var label: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Label("Label", systemImage: "tag")
                .font(.headline)
            
            TextField("Enter a label (e.g., Since Wedding)", text: $label)
                .textFieldStyle(.roundedBorder)
                .onChange(of: label) { _, newValue in
                    if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        label = ElapsedDayModel.defaultLabel
                    }
                    ElapsedDayModel.label = label
                }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct ElapsedDaysSection: View {
    let startDate: Date
    let label: String
    
    private var daysElapsed: Int {
        ElapsedDayModel.daysElapsed(from: startDate)
    }
    
    private var effectiveLabel: String {
        ElapsedDayModel.effectiveLabel()
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(effectiveLabel)
                .font(.title3)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 8) {
                Image(systemName: "clock")
                    .font(.title)
                    .foregroundStyle(.secondary)
                
                Text("\(daysElapsed)")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                    .foregroundStyle(.primary)
                
                Text(daysElapsed == 1 ? "day" : "days")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

// MARK: - Preview

#Preview {
    MainView()
}
