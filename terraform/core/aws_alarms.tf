# Billing alert topic
resource "aws_sns_topic" "billing_alerts" {
  name = "billing-alerts"
}

# Billing alert
resource "aws_cloudwatch_metric_alarm" "billing" {
  alarm_name          = "billing-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "EstimatedCharges"
  namespace           = "AWS/Billing"
  period              = "3600" # 1 hour
  statistic           = "Maximum"
  threshold           = "10"
  alarm_description   = "Billing alarm for statement greater than $10USD"
  alarm_actions       = [aws_sns_topic.billing_alerts.arn]
  datapoints_to_alarm = "1"
  dimensions = {
    Currency = "USD"
  }
}
