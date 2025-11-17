<#
新增 Database Copies
#>

Add-MailboxDatabaseCopy -Identity "Mailbox Database 0978398669" -MailboxServer WIN-EX2019
Add-MailboxDatabaseCopy -Identity "Mailbox Database 0979199203" -MailboxServer MSEX2019

Get-MailboxDatabaseCopyStatus * | Format-Table
