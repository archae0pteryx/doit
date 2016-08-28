#!/bin/bash
copy_pasta="git clone https://github.com/archae0pteryx/kittens.git && cd kittens && ./kittens.sh"
priv_do_keyfile="path_to_private_key" # usually your ~/.ssh/id_rsa
pub_do_keyfile="path_to_public_key"
d_name='db'
d_image='ubuntu-16-04-x64'
d_size='512mb'
d_reg='sfo1'


gen_fingerprint () {
  ssh-keygen -E md5 -lf $pub_do_keyfile > hulk-o-mania/fp.pub
  echo "Fingerprint [+]"
  cat hulk-o-mania/fp.pub
  sleep 1
}
root_check () {
	if [[ "$EUID" -ne 0 ]]; then
		echo "root dagnabbit. root!"
		sleep 1
		exit 0
	else
		echo "root [+]"
    sleep 1
	fi
}
doctl_check () {
  if [[ ! -e /usr/local/bin/doctl ]]; then
    echo "doctl not installed!"
    exit 0
  fi
  echo "doctl [+]"
  sleep 1
}
setup () {
  echo "Not built yet."
}

home () {
  clear
  cat << "EOF"
                     %%%%
                    %%%%-(
                  _%%%%%_/                        \ ' /
                _%%%%%%%%                        - (_) -
              _%%%%%%%/ \%                        / , \
             %%%%%%%%%\\ \_
               %%%%%%   \ \\
                   )    /\_/
                 /(___. \
                 '----' (
                /       )
    ---....____/        (_____ __ _ ___ ___ __ _ _ _____ _ _ ___
              /         )---...___ =-= = -_= -=_= _-=_-_ -=- =-_
            ,'          (         ```--.._= -_= -_= _-=- -_= _=-
         ,-'            )                 ``--._=-_ =-=_-= _-= _
         '-._    '-..___(                       ``-._=_-=_- =_-=
             ``---....__)                            `-._-=_-_=-
                   )|)|                                  `-._=-_
                  '-'-.\_                                    `-.'
EOF
echo '_______________________________________________________________'
echo '                                    DO Droplet Generator       '
echo '_______________________________________________________________'
}

show_menus() {
  echo "(D)efaults"
  echo "(S)et Up"
	echo "(Q)uit"
}

opts () {
	read -r -p "? " choice
	case $choice in
    "d") godo ;;
    "s") setup ;;
    "q") exit 0 ;;
		*) echo -e "${RED}..ERROR..${STD}" && sleep 2
	esac
}

godo () {
  doctl compute droplet create $d_name --region $d_reg --image $d_image	--size $d_size --ssh-keys fp.pub || echo "there was a problem duder."
  echo "Please wait..."
  sleep 13
  echo "Droplets IP:"
  ipv4=$(doctl compute droplet list | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
  echo $ipv4
  echo "ssh in 20"
  sleep 1
  echo "COPY PASTA:"
  echo $copy_pasta
  sleep 15
  rm -f hulk-o-mania/fp.pub || echo "cleanup [-]"
  echo "cleanup [+]"
  #scp -r -i $d_keyfile ../kittens root@$ipv4
  ssh -vi $d_keyfile root@$ipv4
}


root_check
doctl_check
gen_fingerprint
home
while true
do
  show_menus
  opts
done
