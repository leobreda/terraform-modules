resource "random_password" "passwd" {
  length  = 8
  special = true
  numeric = true
  upper   = true
  lower   = true
}

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


resource "aws_secretsmanager_secret_version" "service_password" {
  secret_id     = aws_secretsmanager_secret.secret.id
  secret_string = random_password.passwd.result
}


