set_perms()
{
  local filepath=$1

  chmod $mode $filepath
  chown $owner $filepath
}

create_csr_and_key()
{
  local cn=$1
  openssl req -new -nodes -keyout "$cn.key" -out "$cn.csr" -subj "/CN=$cn"
  set_perms "$cn.key"
}

create_ca()
{
  create_csr_and_key $ca_name
  openssl x509 -req -in "$ca_name.csr" -days $ttl -extfile /etc/ssl/openssl.cnf -extensions v3_ca -signkey "$ca_name.key" -out "$ca_name.crt"
  set_perms "$ca_name.crt"
  rm "$ca_name.csr"
}

create_leaf()
{
  filename=$1
  cn=$2

  create_csr_and_key $leaf_name
  openssl x509 -req -in "$leaf_name.csr" -days $ttl -CA "$ca_name.crt" -CAkey "$ca_name.key" -CAcreateserial -out "$leaf_name.crt"
  set_perms "$leaf_name.crt"
  set_perms "$ca_name.srl"
  rm "$leaf_name.csr"
}
