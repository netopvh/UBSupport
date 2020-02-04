//
//  Strings.swift
//  UBSupport
//
//  Created by Usemobile on 06/05/19.
//

import Foundation

extension String {
    
    static var support: String {
        switch currentLanguage {
        case .en:
            return "Support & Help"
        case .pt:
            return "Suporte e ajuda"
        case .es:
            return "Apoyo y ajuda"
        }
    }
    
    static var emptytext: String {
        switch currentLanguage {
        case .en:
            return "There are currently no Support & Help items available."
        case .pt:
            return "No momento não há nenhum item de Suporte e ajuda disponível"
        case .es:
            return "Actualmente no hay artículos de Soporte y Ayuda disponibles."
        }
    }
    
    static var sendMessage: String {
        switch currentLanguage {
        case .en:
            return "Send Message"
        case .pt:
            return "Enviar Mensagem"
        case .es:
            return "Enviar mensaje"
        }
    }
    
    static var doubts: String {
        switch currentLanguage {
        case .en:
            return "Did this content\nanswer your questions?"
        case .pt:
            return "Este conteúdo respondeu\nsuas dúvidas?"
        case .es:
            return "¿Este contenido respondió sus preguntas?"
        }
    }
    
    static var yes: String {
        switch currentLanguage {
        case .en:
            return "Yes"
        case .pt:
            return "Sim"
        case .es:
            return "Si"
        }
    }
    
    static var no: String {
        switch currentLanguage {
        case .en:
            return "No"
        case .pt:
            return "Não"
        case .es:
            return "No"
        }
    }
    
    static func contact(email: String, phone: String) -> String {
        switch currentLanguage {
        case .en:
            return """
            Send your message
            Email: \(email)
            Phone: \(phone)
            """
        case .pt:
            return """
            Envie sua mensagem
            Email: \(email)
            Telefone: \(phone)
            """
        case .es:
            return """
            Envia tu mensaje
            Email: \(email)
            Teléfono: \(phone)
            """
        }
    }
    
    static var doubt: String {
        switch currentLanguage {
        case .en:
            return "Doubt"
        case .pt:
            return "Dúvida"
        case .es:
            return "Duda"
        }
    }
    
    static var suggestion: String {
        switch currentLanguage {
        case .en:
            return "Suggestion"
        case .pt:
            return "Sugestão"
        case .es:
            return "Sugerencia"
        }
    }
    
    static var commercial: String {
        switch currentLanguage {
        case .en:
            return "Commercial"
        case .pt:
            return "Comercial"
        case .es:
            return "Comercial"
        }
    }
    
    static var marketing: String {
        switch currentLanguage {
        case .en:
            return "Marketing"
        case .pt:
            return "Marketing"
        case .es:
            return "Marketing"
        }
    }
    
    static var financial: String {
        switch currentLanguage {
        case .en:
            return "Financial"
        case .pt:
            return "Financeiro"
        case .es:
            return "Financiera"
        }
    }
    
    static var comment: String {
        switch currentLanguage {
        case .en:
            return "Comment..."
        case .pt:
            return "Comentário..."
        case.es:
            return "Comentar"
        }
    }
    
    static var send: String {
        switch currentLanguage {
        case .en:
            return "Send"
        case .pt:
            return "Enviar"
        case .es:
            return "Enviar"
        }
    }
    
    static var contact: String {
        switch currentLanguage {
        case .en:
            return "Contact Us"
        case .pt:
            return "Fale Conosco"
        case .es:
            return "Hable con nosotros"
        }
    }
    
    static var subject: String {
        switch currentLanguage {
        case .en:
            return "Subject"
        case .pt:
            return "Assunto"
        case .es:
            return "Asunto"
        }
    }
    
    static var model: String {
        switch currentLanguage {
        case .en:
            return ""
        case .pt:
            return ""
        case .es:
            return ""
        }
    }
    
}
