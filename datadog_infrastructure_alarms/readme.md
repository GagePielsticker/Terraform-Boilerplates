# Datadog AWS Infrastructure Alarms

Stands up aws recommended infrastructure alarms using [THIS DOCUMENTATION](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Best_Practice_Recommended_Alarms_AWS_Services.html).

What this includes:
- Generic account wide alarms for basic services
- Example synthetic test setup

What this doesnt include:
- 4xx errors
- 5xx errors
- App specific configs

This was a choice made due to the nature of these alarms being dependent on your specific usage patterns. 