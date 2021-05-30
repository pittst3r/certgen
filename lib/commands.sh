after_generate()
{
  rm $PWD/*.csr
  chmod $mode $PWD/*
}

create_csr_and_key()
{
  local cn=$1

  openssl req -new -nodes -keyout "$cn.key" -out "$cn.csr" -subj "/CN=$cn"
}

create_ca()
{
  create_csr_and_key $ca_name
  openssl x509 -req -in "$ca_name.csr" -days $ttl -extfile /etc/ssl/openssl.cnf -extensions v3_ca -signkey "$ca_name.key" -out "$ca_name.crt"
  after_generate
}

create_leaf()
{
  create_csr_and_key $leaf_name
  openssl x509 -req -in "$leaf_name.csr" -days $ttl -CA "$ca_name.crt" -CAkey "$ca_name.key" -CAcreateserial -out "$leaf_name.crt"
  after_generate
}
