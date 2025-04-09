import SwiftUI

public struct TransferView: View {
    @State private var recipientName: String = ""
    @State private var recipientAccountNumber: String = ""
    @State private var transferAmount: String = ""
    @State private var isTransferring: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    public init(){}

    public var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Destinatário")) {
                    TextField("Nome Completo", text: $recipientName)
                        .autocapitalization(.words)
                    TextField("Número da Conta", text: $recipientAccountNumber)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Valor da Transferência")) {
                    TextField("Valor (R$)", text: $transferAmount)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button(action: {
                        // Simulação de transferência
                        initiateTransfer()
                    }) {
                        HStack {
                            Spacer()
                            Text("Transferir")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                    }
                    .disabled(isTransferring || recipientName.isEmpty || recipientAccountNumber.isEmpty || transferAmount.isEmpty)

                    if isTransferring {
                        ProgressView("Transferindo...")
                    }
                }
            }
            .navigationTitle("Transferência")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Resultado da Transferência"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    func initiateTransfer() {
        guard let amount = Double(transferAmount.replacingOccurrences(of: ",", with: ".")) else {
            alertMessage = "Por favor, insira um valor válido."
            showAlert = true
            return
        }

        isTransferring = true

        // Simulação de um processo de transferência assíncrono (substitua pela sua lógica real)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isTransferring = false
            let success = Bool.random() // Simula sucesso ou falha
            if success {
                alertMessage = "Transferência de R$ \(String(format: "%.2f", amount)) para \(recipientName) realizada com sucesso!"
            } else {
                alertMessage = "Falha ao realizar a transferência. Por favor, tente novamente."
            }
            showAlert = true

            // Limpar os campos após a tentativa de transferência (opcional)
            recipientName = ""
            recipientAccountNumber = ""
            transferAmount = ""
        }
    }
}

struct TransferView_Previews: PreviewProvider {
    static var previews: some View {
        TransferView()
    }
}
