resource "aws_backup_vault" "default" {
  name = "default-backup-vault"
  tags = {
    Name = "default-backup-vault"
  }
}

# Creëert een back-upplan
resource "aws_backup_plan" "ec2_backup_plan" {
  name = "ec2-backup-plan"  # Naam van het back-up plan

  rule {
    rule_name         = "daily-backup"  # Naam van de back-up regel
    target_backup_vault_name = "default"  # Doel-backup vault
    schedule          = var.backup_schedule  # Het back-up schema
    lifecycle {
      delete {
        after = var.backup_retention_days  # Verwijder de back-up na de retentieperiode
      }
    }
  }
}

# Creëert een back-up selectie
resource "aws_backup_selection" "ec2_backup_selection" {
  plan_id          = aws_backup_plan.ec2_backup_plan.id  # Verwijst naar het back-up plan
  name             = "ec2-backup-selection"  # Naam van de selectie
  iam_role_arn     = "arn:aws:iam::aws_account_id:role/aws-backup-role"  # IAM rol voor back-up
  resources = [var.ec2_instance_arn]  # Verwijst naar de EC2 instance ARN
}
