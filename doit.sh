#!/bin/bash
copy_pasta="git clone https://github.com/archae0pteryx/kittens.git && cd kittens && ./kittens.sh"
0_o="wat?"
# Keys and Such
priv_do_keyfile="key" # usually your ~/.ssh/id_rsa
pub_do_keyfile="key.pub"

# "D" For Droplet.
d_arch="x64"
d_key="54:f1:11:f9:9e:b6:30:8f:96:d2:20:8d:5b:cf:25:db"
d_name='dbase'
d_image='ubuntu-16-04-x64'
d_size='512mb'
d_reg='sfo1'

# FIXME!
# gen_fingerprint () {
#   ssh-keygen -E md5 -lf $pub_do_keyfile > hulk-o-mania/fp.pub
#   echo "Fingerprint [+]"
#   cat ./hulk-o-mania/fp.pub
#   sleep 1
# }

root_check () {
	if [[ "$EUID" -ne 0 ]]; then
		echo "Root dagnabbit. Root!"
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
	else
		echo "Please install doctl!"
		read -r -p "would you like me to do that? (OSX only) (y/N) " choice
			case $choice in
				"y") brew install doctl
			esac
	fi
  echo "doctl [+]"
  sleep 1
}

setup () {
  echo "Not built yet."
	#Placeholder for final function execution.
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

set_image () {
	clear
	echo "(u)buntu 16"
	echo "(d)ebian 8"
	echo "(c)entOS 7"
	echo "(f)edora 23"
	echo "(b)freeBSD 10.3"
	echo "(o)ne click installs"
	echo "(m)anual entry"
	echo "(h)ome"
	echo ""
	read -r -p "Select base OS: " choice
	case $choice in
		"u") d_image="ubuntu-16-04-" && set_arch;;
		"d") d_image="debian-8-" && set_arch ;;
		"c") d_image="centos-7-0-" && set_arch ;;
		"f") d_image="fedora-23-" && set_arch ;;
		"b") d_image="freebsd-10-3-" && set_arch ;;
		"o") oneclick ;;
		"h") home ;;
		"m") read -r -p "Which image? " d_image && set_arch ;;
	esac
}

set_arch () {
	read -r -p "Please Select Architecture" choice
	echo "1. AMD_64"
	echo "2. i386"
	echo ""
	echo "(b)ack"
	case $choice in
	  "1") d_arch="x64" && set_name;;
	  "2") d_arch="x32" && set_name;;
    "b") home ;;
		*) echo -e "${RED}Please Choose a valid option${STD}" && sleep 2
	esac
}
set_name () {
	read -r -p "Droplet Name: " d_name && set_mem
}
set_mem () {
	return
}
show_menus() {
  echo "(D)oit"
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
  doctl compute droplet create $d_name --region $d_reg --image $d_image	--size $d_size --ssh-keys $d_key
  echo "Please wait..."
  sleep 13
  echo "Droplets IP:"
#FIXME For multiple Droplets Pulls All IP! No Bueno.
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
home
while true
do
  show_menus
  opts
done
