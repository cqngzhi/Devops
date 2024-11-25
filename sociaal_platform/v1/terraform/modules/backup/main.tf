# Backup Vault Resource
resource "aws_backup_vault" "my_vault" {
  name = "my-backup-vault"
  tags = {
    Name = "my-backup-vault"  # Naam van de Backup Vault
  }
}

# Backup Plan Resource
resource "aws_backup_plan" "my_back_plan" {
  name = "my-backup-plan"

  rule {
    rule_name         = "my-backup-rule"  # Naam van de back-up regel
    target_vault_name = aws_backup_vault.my_vault.name  # Dynamisch de naam van de Backup Vault gebruiken
    schedule          = var.backup_schedule  # Gebruik de ingevoerde back-up schema variabele
    completion_window = 60  # Maximale tijd in minuten voor de back-up voltooiing

    lifecycle {
      delete_after = var.backup_retention_days  # Gebruik de variabele voor de retentieperiode van de back-up
    }
  }
}

# Backup Selection Resource
resource "aws_backup_selection" "myselection" {
  iam_role_arn = var.backup_iam_role_arn  # Dynamisch de ARN van de IAM rol gebruiken
  name         = "test_selection"  # Naam van de back-up selectie
  plan_id      = aws_backup_plan.my_back_plan.id  # Verwijst naar het eerder gedefinieerde back-up plan

  resources = [
    var.ec2_instance_arn  # Gebruik de variabele voor de ARN van de EC2 instance die geback-upt moet worden
  ]
}
