#!/bin/bash
d_keyfile="0000000"
d_name='monkies'
d_image='ubuntu-16-04-x64'
d_size='512mb'
d_reg='sfo1'
d_key='fb:86:91:f8:a8:d2:76:39:dd:bb:61:3d:a4:13:97:fa'
clear
echo ""
doctl compute droplet create $d_name --region $d_reg --image $d_image	--size $d_size --ssh-keys $d_key
echo ""
echo "Did you see that bitch take a camera phone photo of me!?"
sleep 3
echo "Hold up nigga this is not. a. drill."
sleep 3
echo "..."
sleep 3
echo "..."
sleep 3
echo "Wait for it"
sleep 3
echo "Wait for it"
sleep 1
echo "...waaait for it..."
sleep 7
echo "Maul IT!!!!"
sleep 2
clear
echo ""
echo "PLADOW!"
sleep 2
echo "Delicious fat bitches IP:"
ipv4=$(doctl compute droplet list | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
echo $ipv4
echo ""
echo "ssh in 20"
echo ""
sleep 1
echo "COPY PASTA:"
echo "git clone https://github.com/archae0pteryx/kittens.git && cd kittens && ./kittens.sh"
sleep 15
#scp -r -i $d_keyfile ../kittens root@$ipv4
ssh -vi $d_keyfile root@$ipv4
