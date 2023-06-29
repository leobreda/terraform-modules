variable "nome" {
  type = string
  
  validation{
    condition = length(var.nome) > 5
    error_message = "[nome] deve ser maior que 5 caracteres"
  }
}

variable "delay_segundos" {
  type = number
  description = "Tempo (em segundos) que uma mensagem fica 'reservada' para um determinado consumer, quando há uma concorrência na leitura da fila"
  
  validation{
    condition = (var.delay_segundos!=0) && (var.delay_segundos <= 300)
    error_message = "[delay] deve ser entre 1 segundo e 5 minutos (300)"
  }

}

variable "tamanho_maximo_mensagem" {
  type = number
  description = "Tamanho máximo (em kB) de cada mensagem"

 validation{
    condition = (var.tamanho_maximo_mensagem!=0) && (var.tamanho_maximo_mensagem > 50)
    error_message = "[tamanho_maximo_mensagem] deve ser entre 1kB e 50kB"
  }
}

variable "retencao_minutos" {
  type = number
  description = "Tempo máximo (em minutos) de armazenamento da mensagem, sendo excluída automaticamente após o período."
  
   validation{
    condition = (var.retencao_minutos!=0) && (var.retencao_minutos <= 300)
    error_message = "[tempo_retencao] deve ser entre 1min e 300min (5 horas)"
  }
}

variable "descricao" {
  type = string

   validation{
    condition = length(var.descricao) > 10
    error_message = "[descricao] deve ser maior que 10 caracteres"
  }
}

variable "ambiente" {
  type = string
  description = "Ambiente da aplicação (DEV, HOM ou PROD)"

  validation {
    condition     = contains(["DEV", "HOM", "PROD"], var.ambiente)
    error_message = "[ambiente] deve ser DEV, HOM ou PROD"
  }
}

variable "tags" {
 type= map(string)
}