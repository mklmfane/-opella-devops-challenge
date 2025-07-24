package terraform.analysis

required_tags := {"Environment", "Owner", "Project"}

deny_required_tags[msg] if {
  rc := input.resource_changes[_]
  startswith(rc.type, "aws_")
  rc.type != "aws_subnet"
  tag := required_tags[_]
  not rc.change.after.tags[tag]

  msg := sprintf("❌ Missing required tag '%s' on resource: %s", [tag, rc.address])
}
