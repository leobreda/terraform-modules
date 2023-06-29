variable "nome" {
  type = string
  validation{
    condition = length(var.nome) >= 5
    error_message = "[nome] deve ser maior que 5 caracteres"
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
  type = map
}