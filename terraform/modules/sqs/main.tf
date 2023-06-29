resource "aws_sqs_queue" "sqs" {
  name                      = "${var.ambiente}_${var.nome}"
# description               = var.descricao # SQS não aceita descrição
  delay_seconds             = var.delay_segundos
  max_message_size          = var.tamanho_maximo_mensagem * 1024
  message_retention_seconds = var.retencao_minutos * 60 
  receive_wait_time_seconds = 10

  tags = merge(
        var.tags,
        {
            Descricao = var.descricao
            Ambiente = var.ambiente
            DataCriacao = formatdate("YYYY-MM-DD hh:mm:ss", timestamp()),
            VersaoModulo = "1.1"
        }
  )
}
