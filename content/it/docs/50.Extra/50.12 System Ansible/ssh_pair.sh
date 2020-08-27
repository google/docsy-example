#ssh-keygen -f filename
#ssh-copy-id root@192.983389.3.3.3.

# -o      Causes ssh-keygen to save private keys using the new OpenSSH format
#         rather than the more compatible PEM format.  The new format has
#         increased resistance to brute-force password cracking but is not sup‐
#         ported by versions of OpenSSH prior to 6.5.  Ed25519 keys always use 
#         the new private key format.
cd group_vars
for port in {20,25,26,27,28,29,31,33,42,60,61,62} 
do
 #echo $port\22
 #ssh-copy-id -p $port\22 root@test 
 name=$(ssh -p $port\22 root@test  'cat /etc/hostname|cut -d'-' -f3' )
 echo "alias $name=\'ssh -p $port\22 root@test\'"  #>~/.bash_aliases
 
 #nome=$(ssh -p $port\22 root@test  'cat /etc/hostname|cut -d'-' -f3' )
 #touch "${nome,,}"
done
