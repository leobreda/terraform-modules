resource "aws_secretsmanager_secret" "secret" {
  name = "${var.ambiente}/${var.nome}"
  description = var.descricao
  tags = merge(
        var.tags,
        {
            Ambiente = var.ambiente
            DataCriacao = formatdate("YYYY-MM-DD hh:mm:ss", timestamp()),
            VersaoModulo = "2023.06.18"
        }
  )
}