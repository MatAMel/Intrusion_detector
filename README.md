# Intrusion Detector

Shell script which listens to a user defined port and waits for connection attempts.  
It runs a "nmap -A" scan on the ip which tries to connect.  
The output of the nmap command is printed to a pdf file.

## Dependecies

nmap  
cupsfilter

Fedora Install
```bash
sudo dnf install nmap
sudo dnf install cupsfilter
```

Debian Install
```bash
sudo apt install nmap
sudo apt install cupsfilter
```

## Usage
Script requires root privileges and a port as the first and only argument.  
For example port 22:
```bash
sudo ./intrusion_detector 22
```
To run the script in the background:

```bash
sudo nohup ./intrusion_detector.sh 22 &
```
