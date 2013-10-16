class raid {
  if $::raid =~ /adaptec-raid/        { include raid::adaptec }
  if $::raid =~ /lsi-megasas/         { include raid::lsi-megasas }
  if $::raid =~ /linux-software-raid/ { include raid::linux-md }
}
