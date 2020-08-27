rm -r ~/idempiere
mkdir -p ~/idempiere/a{1..2}/b{3..5}/c{6..9}
cat >  ~/idempiere/UU.{$RANDOM,$RANDOM,$RANDOM}.html<<EOF
<!DOCTYPE html>
<html>
<body>
sjkdhsljhljshdfljvh
</body>
</html>
EOF
touch  ~/idempiere/a{1..2}/UU.{$RANDOM,$RANDOM,$RANDOM}.html
touch  ~/idempiere/a{1..2}/b{3..5}/UU.{$RANDOM,$RANDOM,$RANDOM}.html
touch  ~/idempiere/a{1..2}/b{3..5}/c{6..9}/UU.{$RANDOM,$RANDOM,$RANDOM}.html
touch  ~/idempiere/a{1..2}/b{3..5}/UU-{6..9}-UU.{$RANDOM,$RANDOM,$RANDOM}.html
tree ~/idempiere
