//
//  main.swift
//  Assesment Paulo ( Gustavo Fonseca)
//
//  Created by md10 on 05/12/16.
//  Copyright © 2016 md10. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l >= r
    default:
        return !(lhs < rhs)
    }
}


//QUESTÃO 1 - PARTE 1"
//------------------------------------------------------------------------------------------------------------------
extension String{
    var validarEmail: String {return "^[a-z0-9_.-]+[@]([a-z0-9]+[.]{1})([a-z0-9]+[.]{0,1}){1,}"}
    var validarTelefone: String{return "^[+][0-9]{2,3}[\\s]{0,2}[(]{0,1}[0-9]{2,3}[)]{0,1}[\\s]{0,2}[0-9]{0,1}[\\s]{0,1}[0-9]{4}[-]{0,1}[\\s]{0,2}[0-9]{4}"}
    var validarDataNascimento: String {return "[0-9]{2}+[\\/]{1}+[0-9]{2}+[\\/]{1}+[0-9]{4}"}
}

struct RegexHelper{
    
    let regex: NSRegularExpression?
    
    init(_ pattern: String){
        regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(_ input: String) -> Bool{
        if let matches = regex?.matches(in: input, options: [], range: NSMakeRange(0, input.characters.count)){
            return matches.count > 0
        }else{
            return false
        }
    }
    
}

//------------------------------------------------------------------------------------------------------------------


//QUESTÃO 1 - PARTE 2"
//------------------------------------------------------------------------------------------------------------------
protocol Personagem {
    func andar ()
    func parar()
    func atacar(_ personagem: Personagem)
    
    var nome : String {get}
    var forca : Int {get set}
    var inteligencia : Int {get set}
    var destreza : Int {get set}
    var pontosDeVida : Int {get set}
    var pontosDeMagia : Int {get set}
}
//------------------------------------------------------------------------------------------------------------------


//QUESTÃO 1 - PARTE 3"
//------------------------------------------------------------------------------------------------------------------

class Guerreiro : Personagem {
    var nome: String
    var forca : Int
    var inteligencia : Int
    var destreza : Int
    var pontosDeVida : Int
    var pontosDeMagia : Int
    
    init(_ nome: String, _ forca: Int, _ inteligencia: Int, _ destreza: Int, _ pontosDeVida: Int, _ pontosDeMagia: Int){
        self.nome = nome
        self.forca = forca
        self.inteligencia = inteligencia
        self.destreza = destreza
        self.pontosDeVida = pontosDeVida
        self.pontosDeMagia = pontosDeVida
    }
    
    func atacar(_ personagem: Personagem) {
        var personagem = personagem
        
        // Diminuir pontos de vida do personagem que atacou
        personagem.pontosDeVida -= (10 + self.forca)
        print("O personagem \(personagem.nome) foi atacado e ficou com \(personagem.pontosDeVida) pontos de vida")
    }
    
    func andar() {
        print("O personagem \(self.nome) está andando")
    }
    func parar() {
        print("O personagem \(self.nome) está parando")
    }
}

class Mago : Personagem {
    var nome: String
    var forca : Int
    var inteligencia : Int
    var destreza : Int
    var pontosDeVida : Int
    var pontosDeMagia : Int
    var magias: [String: Int] = ["RaioDeFogo" : 15, "MarcaArcana" : 20, "RaioDeAcido" : 10, "RaioDeGelo" : 30]
    
    
    init(_ nome: String, _ forca: Int, _ inteligencia: Int, _ destreza: Int, _ pontosDeVida: Int, _ pontosDeMagia: Int){
        self.nome = nome
        self.forca = forca
        self.inteligencia = inteligencia
        self.destreza = destreza
        self.pontosDeVida = pontosDeVida
        self.pontosDeMagia = pontosDeVida
    }
    
    func atacar(_ personagem: Personagem) {
        var personagem = personagem
        personagem.pontosDeVida -= (10 + self.inteligencia)
        print("O personagem \(personagem.nome) foi atacado e ficou com \(personagem.pontosDeVida) pontos de vida")
    }
    func andar() {
        print("O \(self.nome) está andando")
    }
    func parar() {
        print("O \(self.nome) para")
    }
}
//------------------------------------------------------------------------------------------------------------------


//QUESTÃO 1 - PARTE 4"
//------------------------------------------------------------------------------------------------------------------

class BatalhaService<T>{
    
    static func iniciarBatalha<T:Personagem,U:Personagem>(_ primeiroPersonagem: T, segundoPersonagem: U){
        
        primeiroPersonagem.andar()
        segundoPersonagem.andar()
        print("Quando \(primeiroPersonagem.nome) encontra \(segundoPersonagem.nome)")
        primeiroPersonagem.parar()
        print("Então \(segundoPersonagem.nome) se asusta ao ver o \(primeiroPersonagem.nome) parado e")
        segundoPersonagem.parar()
        print("Os \(primeiroPersonagem.nome) olha para \(segundoPersonagem.nome) e fala: A luta termina só com a morte de alguém.")
        print("\(segundoPersonagem.nome) concorda com a cabeça e então \(primeiroPersonagem.nome) avança para o ataque.\n")
        
        while(true){
            
            if(primeiroPersonagem.pontosDeVida <= 0){
                print("Fim da luta")
                print("O personagem \(primeiroPersonagem.nome) MORREU")
                break
            }else{
                primeiroPersonagem.atacar(segundoPersonagem)
            }
            
            if(segundoPersonagem.pontosDeVida <= 0){
                print("Fim da luta")
                print("O personagem \(segundoPersonagem.nome) MORREU")
                break
            }else{
                segundoPersonagem.atacar(primeiroPersonagem)
            }
            
            
        }
        
    }
    
}
//------------------------------------------------------------------------------------------------------------------


//QUESTÃO 1 - PARTE 5"
//------------------------------------------------------------------------------------------------------------------

enum ErrosGame: Error{
    case emailInvalido
    case telefoneInvalido
    case dataNascimentoInvalida
    case nomeDeveSerPreenchido
    case menorDeIdade
    case opcaoInvalida
}

extension ErrosGame: CustomStringConvertible{
    
    var description:String {
        switch(self){
        case .emailInvalido:
            return "Esse e-mail é inválido"
        case .telefoneInvalido:
            return "Esse telefone é inválido"
        case .dataNascimentoInvalida:
            return "Essa data de nascimento é inválida"
        case .nomeDeveSerPreenchido:
            return "O nome deve conter ao menos dois caracteres"
        case .menorDeIdade:
            return "Você precisa ser maior de 18 anos"
        case .opcaoInvalida:
            return "Opção inválida"
        }
    }
}

//------------------------------------------------------------------------------------------------------------------


//QUESTÃO 1 - PARTE 6"
//------------------------------------------------------------------------------------------------------------------


// Feito na classe Mago

//------------------------------------------------------------------------------------------------------------------


//QUESTÃO 1 - PARTE 7"
//------------------------------------------------------------------------------------------------------------------

class Jogador{
    var nome:String?
    var email:String?
    var dataDeNascimento: Date?
    var telefone:String?
    
    init(nome:String, email:String, dataDeNascimento: Date, telefone:String){
        self.nome = nome
        self.email = email
        self.dataDeNascimento = dataDeNascimento
        self.telefone = telefone
    }
    
}


// Main

var estudantesDeMagia = [Mago]()
var estudantesDaArteDaGuerra = [Guerreiro]()

var gamer: Jogador?

let formatadorDeData = DateFormatter()
formatadorDeData.dateFormat = "dd/MM/yyyy"

func obterDados() throws{
    
    var nome: String?
    var email: String?
    var telefone: String?
    var data: String?
    
    while(true){
        
        while(true){
            print("Por favor, informe o seu nome\n")
            nome = readLine(strippingNewline: true)
            
            do{
                if (nome?.characters.count >= 2){break} else {throw ErrosGame.nomeDeveSerPreenchido}
            }catch{
                print(ErrosGame.nomeDeveSerPreenchido.description)
            }
            
        }//while interno
        
        while(true){
            print("Por favor, informe o seu e-mail\n")
            email = readLine(strippingNewline: true)
            
            do{
                if (RegexHelper.init((email?.validarEmail)!).match(email!)){break} else {throw ErrosGame.emailInvalido}
            }catch{
                print(ErrosGame.emailInvalido.description)
            }
        }//while interno
        
        while(true){
            print("Por favor, informe o seu telefone\n")
            telefone = readLine(strippingNewline: true)
            
            do{
                if (RegexHelper.init((telefone?.validarTelefone)!).match(telefone!)){break} else {throw ErrosGame.telefoneInvalido}
            }catch{
                print(ErrosGame.telefoneInvalido.description)
            }
        }//while interno
        
        while(true){
            print("Por favor, informe o sua data de nascimento\n")
            data = readLine(strippingNewline: true)
            var mensagem:String = ""
            
            do{
                
                if (RegexHelper.init((data?.validarDataNascimento)!).match(data!)){}
                else {
                    mensagem += ErrosGame.dataNascimentoInvalida.description + "\n"
                    throw ErrosGame.dataNascimentoInvalida
                }
                
                if (validarIdade(formatadorDeData.date(from: data!)!)){
                    break
                } else {
                    mensagem += ErrosGame.menorDeIdade.description + "\n"
                    throw ErrosGame.menorDeIdade
                }
                
            }catch{
                print(mensagem)
            }
            
        }//while interno
        
        //        print(dateF.dateFromString(data!)!)
        gamer = Jogador(nome: nome!, email: email!, dataDeNascimento: formatadorDeData.date(from: data!)!, telefone: telefone!)
        
        break
    }// while externo
    
}


func validarIdade(_ data: Date) -> Bool{
    
    let calendar = Calendar.current
    var dateComponent = (calendar as NSCalendar).components([.day, .month, .year], from: Date())
    let anoNiver = Calendar.current.dateComponents([.year], from: data,to:Date()).year!
    dateComponent.year = 18
    let dataAtual = calendar.date(from: dateComponent)
    
    if (anoNiver >= 18) {
        return true
    }else{
        return false
    }

}


// INÍCIO DO JOGOO!!!

try obterDados()

// Criação dos BOOTS
var boot1Mago = Mago("Dungeon", 15, 80, 70, 310, 110)
var boot2Mago = Mago("Pluton", 10, 75, 80, 300, 120)
var boot3Guerreiro = Guerreiro("Armagedom", 90, 15, 90, 380, 15)
var boot4Guerreiro = Guerreiro("Urion", 95, 10, 80, 320, 5)

print("Olá \(gamer!.nome!), bem vindo!")
print("Escolha qual luta deseja")

var sair: Bool = false

while(sair == false){
    
    while(true){
        print("\n")
        print("1 - Mago:\(boot1Mago.nome) Vs Mago:\(boot2Mago.nome)")
        print("2 - Guerreiro:\(boot3Guerreiro.nome) Vs Guerreiro:\(boot4Guerreiro.nome)")
        print("3 - Mago:\(boot1Mago.nome) Vs Guerreiro:\(boot3Guerreiro.nome)")
        print("4 - Guerreiro:\(boot4Guerreiro.nome) Vs Mago:\(boot2Mago.nome)")
        print("\nDigite o número da luta")
        var luta = readLine(strippingNewline: true)
        
        do{
            
            if luta! == "1"{BatalhaService<Personagem>.iniciarBatalha(boot1Mago, segundoPersonagem: boot2Mago); break}
            else if luta! == "2"{BatalhaService<Personagem>.iniciarBatalha(boot3Guerreiro, segundoPersonagem: boot4Guerreiro); break}
            else if luta! == "3"{BatalhaService<Personagem>.iniciarBatalha(boot1Mago, segundoPersonagem: boot3Guerreiro); break}
            else if luta! == "4"{BatalhaService<Personagem>.iniciarBatalha(boot2Mago, segundoPersonagem: boot4Guerreiro); break}
            else{throw ErrosGame.opcaoInvalida}
            
        }catch{
            print(ErrosGame.opcaoInvalida.description)
        }
    }
    
    while(true){
        print("\n Deseja sair? 1 - Sim / 2 - Não")
        var sairInput = readLine(strippingNewline: true)
        
        do{
            if sairInput == "1"{
                sair = true
                break
            }else if sairInput == "2"{
                sair = false
                break
            }else{
                throw ErrosGame.opcaoInvalida
            }
        }catch{
            print(ErrosGame.opcaoInvalida.description)
        }
    }
    
    
}
