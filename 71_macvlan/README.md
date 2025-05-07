# README

Demonstrate configuring macvlan for a docker container.

networks: 

IPAM is IP address management 

https://docs.docker.com/engine/reference/commandline/network_create/ 

https://runnable.com/docker/docker-compose-networking 

 

 

vxlan - Overlay network  

link up multiple docker daemons 

 

https://blog.revolve.team/2017/04/25/deep-dive-into-docker-overlay-networks-part-1/ 

 

MacVLAN 

Allows you to have unique mac addresses on network 

https://docs.docker.com/network/network-tutorial-macvlan/ 

 

ip route 

then look at the default ip address 

 

docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.254 -o parent=wlx1cbfcec13467 my-macvlan-net 

 

docker run --rm -dit --network my-macvlan-net --name my-macvlan-alpine alpine:latest ash 

 

docker exec my-macvlan-alpine ip addr show eth0 
 

 

docker exec my-macvlan-alpine ip route 

 

docker container stop my-macvlan-alpine 
 

docker network rm my-macvlan-net 

 

https://stackoverflow.com/questions/54540781/docker-network-create-error-numerical-result-out-of-range 

Network has to be less than 15 characters 

docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.254 -o parent=wlx1cbfcec13467.10 my-macvlan-trunked-net 

 

 

docker network create -d macvlan --subnet=192.168.1.0/24 --gateway=192.168.1.254 -o parent=wlp3s0.10 my-macvlan-trunked-net 

 

docker run --rm -dit --network my-macvlan-trunked-net --name my-macvlan-alpine alpine:latest ash 

 

docker exec my-macvlan-alpine ip addr show  
 

 

docker exec my-macvlan-alpine ip route 

 

docker container stop my-macvlan-alpine 
 

docker network rm my-macvlan-net 

 

 

 

 

 

tutorial  - use macvlan to host pihole?macvlan  

https://jfoo.xyz/docker-containers-on-your-vlan/ 

 

compose file 

https://brandonrozek.com/blog/dockermacvlan/ 

 

 

https://gdevillele.github.io/engine/userguide/networking/get-started-macvlan/ 

 

 

 

IPVLan 

https://docs.docker.com/network/ipvlan/ 

 

 

https://www.reddit.com/r/docker/comments/amle59/docker_macvlan_setup_ubuntu_no_ip_address_on/?utm_source=share&utm_medium=ios_app&utm_name=iossmf 

 

 

https://github.com/Shopify/docker/blob/master/experimental/vlan-networks.md 

 

 

Explanation of different network stuff on linux 

https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking 

 

ip link  


## Resources

https://brandonrozek.com/blog/dockermacvlan/
