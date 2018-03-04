`Editor: Yuxin SHI`
`Date: 23/02/2018`

# OPENSSL
1. Generer une paire de cles RSA.    

```bash
$: openssl
//to generate a private key
OpenSSL> genrsa -out rsa_private_tp1.pem 1024
Generating RSA private key, 1024 bit long modulus
........++++++
...................++++++
e is 65537 (0x10001)

OpenSSL> rsa -in rsa_private_tp1.pem -pubout -out rsa_public_tp1.pem
writing RSA key

```
1.
2. Pouvez-vous determiner les parametres RSA utilises par la cle generer?
$ -in cle_private -text -onout
  e = 65537, n = modulus
  d =private exponent
3. X
4. Chiffrer et dechiffrer un fichier.
```
$openssl rsautl -encrypt -pubin -inkey rsa_public_tp1.pem -in secret -out secret.en
$opessl rsautl -decrypt -inky rsa_private_tp1.pem  -in secret.en -out secret.de
```
5. Binome. ignore
6. Signer le fichier de fichier, puis verifier la signature.   
  ```
  $ openssl pkeyutl -sign -in secret -inkey rsa_private_tp1.pem -out secret.sig
  $ openssl pkeyutl -verify -in secret -sigfile secret.sig -pubin -inkey rsa_public_tp1.pem
  Signature Verified Successfully
  ```
7. Utiliser AES pour chiffrer et dechiffrer un petit fichier.
  ```
$ openssl aes-128-cbc -salt -in secret -out secret.aes
enter aes-128-cbc encryption password:
Verifying - enter aes-128-cbc encryption password:
$ cat secret.aes
Salted__�@R>�y�{B������׃�
                          l3�
# dechiffrer
$ openssl aes-128-cbc -d -salt -in secret.aes -out secret.deaes
enter aes-128-cbc decryption password:
  ```
![](secu_tp17.png)
8. Creer 3 message, calculer l'empreinte de chaque message. Modif-en un legerement. Verifier si les messages sont modifies.
