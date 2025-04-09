//
//  ContentView.swift
//  BankApp
//
//  Created by Vitor Henrique Barreiro Marinho on 08/04/25.
//

//
//  ContentView.swift
//  BankApp
//
//  Created by Vitor Henrique Barreiro Marinho on 08/04/25.
//

import SwiftUI
import TransferModule

struct BankHomeView: View {
    let categories = ["Visão Geral", "Extrato", "Transferências", "Pagamentos", "Investimentos", "Crédito"]
    @State private var selectedCategory = "Visão Geral"
    @State private var isTransferViewPresented = false

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    headerView()
                    balanceView()
                    categoriesScrollView()
                    selectedCategoryContent()
                    quickActionsView()
                    Spacer()
                }
                .padding(.bottom, 20)
            }
            .navigationTitle("Meu Banco")
            .navigationBarHidden(true)
            .sheet(isPresented: $isTransferViewPresented) {
               // TransferView()
            }
        }
    }

    // Subview para o Header
    @ViewBuilder
    private func headerView() -> some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .font(.largeTitle)
                .foregroundColor(.gray)
            Spacer()
            Image(systemName: "bell.badge.fill")
                .font(.title3)
                .foregroundColor(.blue)
        }
        .padding(.horizontal)
    }

    // Subview para o Saldo Principal
    @ViewBuilder
    private func balanceView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Saldo Total")
                .font(.caption)
                .foregroundColor(.secondary)
            Text("R$ 1.258,90")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }

    // Subview para a ScrollView de Categorias
    @ViewBuilder
    private func categoriesScrollView() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category)
                            .font(.subheadline)
                            .fontWeight(selectedCategory == category ? .bold : .regular)
                            .foregroundColor(selectedCategory == category ? .blue : .secondary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(selectedCategory == category ? Color.blue.opacity(0.1) : Color.gray.opacity(0.05))
                            )
                    }
                }
            }
        }
        .padding(.horizontal)
    }

    // Subview para o Conteúdo da Categoria Selecionada
    @ViewBuilder
    private func selectedCategoryContent() -> some View {
        VStack {
            if selectedCategory == "Transferências" {
                NavigationLink(destination: TransferView()) {
                    Text("Ir para Transferência")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            } else {
                Text("Conteúdo da Categoria:")
                    .font(.headline)
                    .foregroundColor(.gray)
                Text(selectedCategory)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 30)
    }

    // Subview para as Ações Rápidas
    @ViewBuilder
    private func quickActionsView() -> some View {
        VStack(alignment: .leading) {
            Text("Ações Rápidas")
                .font(.headline)
                .padding(.leading)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    NavigationLink(destination: TransferView()) {
                        QuickActionButton(icon: "arrow.up.doc", label: "Transferir")
                    }
                    QuickActionButton(icon: "barcode.viewfinder", label: "Pagar")
                    QuickActionButton(icon: "plus.circle.fill", label: "Adicionar")
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 30)
    }
}

struct QuickActionButton: View {
    let icon: String
    let label: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(10)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct BankHomeView_Previews: PreviewProvider {
    static var previews: some View {
        BankHomeView()
    }
}
