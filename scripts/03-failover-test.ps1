<#
測試 DAG Failover
#>

Get-MailboxDatabaseCopyStatus * | Format-Table Name,Status,ActiveCopy

Move-ActiveMailboxDatabase "Mailbox Database 0978398669" `
 -ActivateOnServer WIN-EX2019 -Confirm:$false

Get-MailboxDatabaseCopyStatus *
