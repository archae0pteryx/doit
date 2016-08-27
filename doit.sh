#!/bin/bash
d_keyfile="~/Code/Repos/kittens/0000000"
d_name='monkies'
d_image='ubuntu-16-04-x64'
d_size='512mb'
d_reg='sfo1'
d_key='fb:86:91:f8:a8:d2:76:39:dd:bb:61:3d:a4:13:97:fa'

doctl compute droplet create $d_name --region $d_reg --image $d_image	--size $d_size --ssh-keys $d_key
echo ""
echo "Give the monkies a min to squabble..."
sleep 3
echo "..."
sleep 4
echo "0_o"
sleep 7
echo "Wait for it"
sleep 3
echo "POW!"
ipv4=$(doctl compute droplet list | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}')
echo $ipv4
echo ""
echo "trying ssh in 10s"
sleep 10
ssh -vi $d_keyfile root@$ipv4
