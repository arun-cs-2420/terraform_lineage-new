output "sns_topic_arn" {
  value = aws_sns_topic.fifo_sns_topic.arn
}


output "sns_email_topic_arn" {
  value = aws_sns_topic.email_topic.arn
}
output "sns_file"{
value = aws_sns_topic.sns_topic_file.arn
}