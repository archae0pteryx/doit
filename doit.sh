#!/bin/bash
d_keyfile="/home/xenu/cry/pee/si_rsa"
d_name='database'
d_image='ubuntu-16-04-x64'
d_size='512mb'
d_reg='sfo1'
d_key='54:f1:11:f9:9e:b6:30:8f:96:d2:20:8d:5b:cf:25'
#curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer " -d '{"name":"","public_key":""}' "https://api.digitalocean.com/v2/account/keys"
doctl compute droplet create $d_name --region $d_reg --image $d_image	--size $d_size --ssh-keys $d_key
echo ""
echo "Give DO a min"
sleep 3
echo "..."
sleep 4
echo "0_o"
sleep 5
echo "..."
sleep 6
echo "Droplet IP: "
ipv4=$(doctl compute droplet list | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
echo $ipv4
echo "Copy/Pasta:"
echo 'git clone https://github.com/archae0pteryx/kittens.git && cd kittens && ./kittens.sh'
echo "trying ssh in 20s"
sleep 20
#scp -r -i $d_keyfile ../kittens root@$ipv4
ssh -vi $d_keyfile root@$ipv4
