resource "aws_ssm_parameter" "params" {
  name  = "/${lower(var.ambiente)}/${var.nome}"
  description = var.descricao
  type  = "String"
  value = var.valor

   tags = merge(
        var.tags,
        {
            Ambiente = var.ambiente
            DataCriacao = formatdate("YYYY-MM-DD hh:mm:ss", timestamp()),
            VersaoModulo = "1.0"
        }
  )
}