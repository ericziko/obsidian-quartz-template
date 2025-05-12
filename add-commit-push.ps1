$date = Get-Date -Format "yyyy-MM-dd HH:mm tt"
$comment="Updated - $date"
& git add .;git commit -m "$comment";git push;