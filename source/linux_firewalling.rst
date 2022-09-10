Linux firewalling
=================

.. contents:: Page content
  :local:
  :backlinks: entry

.. highlight:: shell

.. index::
  single: Linux firewalling


Introduction
------------

.. index::
  single: nftables

This page is where I keep track of the few things I know about Linux
firewalling and port scanning with `nftables
<https://en.wikipedia.org/wiki/Nftables>`_, `Nmap <https://nmap.org>`_, `ss
<https://linuxhint.com/ss-command-linux>`_ and `Fail2ban
<https://en.wikipedia.org/wiki/Fail2ban>`_.

Use what you find on this page at your own risk. I'm not a network security
specialist so the firewall configuration provided on this page may not be the
best one. And your needs may be different than mine.


Disabling iptables
------------------

.. index::
  single: iptables
  pair: apt-get commands; remove

`iptables <https://en.wikipedia.org/wiki/Iptables>`_ is the predecessor of
nftables, and used to be the default network filtering framework in `Debian
GNU/Linux <https://www.debian.org>`_. `Starting with Debian 10 (Buster), the
default network filtering framework is nftables
<https://www.debian.org/releases/buster/amd64/release-nojjtes/ch-whats-new.en.html#nftables>`_.

if iptables is installed on your system, you can list the rules (**as root**)
with ``iptables -L`` (for the IPv4 protocol) and ``ip6tables -L`` (for the IPv6
protocol). Here is the output you get when iptables is not configured:

| Chain INPUT (policy ACCEPT)
| target     prot opt source               destination
|
| Chain FORWARD (policy ACCEPT)
| target     prot opt source               destination
|
| Chain OUTPUT (policy ACCEPT)
| target     prot opt source               destination

Alternatively, you can use ``iptables -S`` and ``ip6tables -S`` (**as root**).
When iptables is not configured, you get:

| -P INPUT ACCEPT
| -P FORWARD ACCEPT
| -P OUTPUT ACCEPT

You can flush the iptables rules (**as root**) with::

  iptables -F
  ip6tables -F

You may also want to uninstall iptables. You can do so (**as root**) with::

  apt-get remove iptables


Finding the open ports on the local network
-------------------------------------------

.. index::
  single: nmap
  single: ss
  single: awk

I use `Nmap <https://nmap.org>`_ to scan for open ports on hosts of my local
network. On a `Debian GNU/Linux <https://www.debian.org>`_ system, you can
install it with::

  apt-get install nmap

by default, Nmap scans the 1000 most popular TCP ports (``-vv`` is for incresed
verbosity)::

  nmap -vv host_name

| Starting Nmap 7.80 ( https://nmap.org ) at 2022-06-12 13:56 CEST
| Initiating Ping Scan at 13:56
| Scanning host_name (XXX.XXX.XXX.XXX) [4 ports]
| Completed Ping Scan at 13:56, 0.04s elapsed (1 total hosts)
| Initiating SYN Stealth Scan at 13:56
| Scanning host_name (XXX.XXX.XXX.XXX) [1000 ports]
| Discovered open port 3389/tcp on XXX.XXX.XXX.XXX
| Discovered open port 22/tcp on XXX.XXX.XXX.XXX
| Completed SYN Stealth Scan at 13:56, 1.38s elapsed (1000 total ports)
| Nmap scan report for host_name (XXX.XXX.XXX.XXX)
| Host is up, received echo-reply ttl 55 (0.019s latency).
| Scanned at 2022-06-12 13:56:11 CEST for 1s
| Not shown: 997 closed ports
| Reason: 997 resets
| PORT     STATE    SERVICE       REASON
| 22/tcp   open     ssh           syn-ack ttl 55
| 25/tcp   filtered smtp          no-response
| 3389/tcp open     ms-wbt-server syn-ack ttl 55
| MAC Address: XX:XX:XX:XX:XX:XX
|
| Read data files from: /usr/bin/../share/nmap
| Nmap done: 1 IP address (1 host up) scanned in 1.53 seconds
|            Raw packets sent: 1005 (44.196KB) | Rcvd: 1000 (39.996KB)

``-F`` option is for a fast scan (only the most popular ports are scanned)::

  nmap -vv -F host_name

| Starting Nmap 7.80 ( https://nmap.org ) at 2022-06-06 07:32 CEST
| Initiating ARP Ping Scan at 13:57
| Scanning host_name (XXX.XXX.XXX.XXX) [1 port]
| Completed ARP Ping Scan at 13:57, 0.11s elapsed (1 total hosts)
| Initiating SYN Stealth Scan at 13:57
| Scanning host_name (XXX.XXX.XXX.XXX) [100 ports]
| Discovered open port 22/tcp on XXX.XXX.XXX.XXX
| Completed SYN Stealth Scan at 13:57, 2.42s elapsed (100 total ports)
| Nmap scan report for host_name (XXX.XXX.XXX.XXX)
| Host is up, received arp-response (0.054s latency).
| rDNS record for XXX.XXX.XXX.XXX: host_name.localdomain
| Scanned at 2022-06-12 13:57:31 CEST for 2s
| Not shown: 97 closed ports
| Reason: 97 resets
| PORT     STATE    SERVICE       REASON
| 22/tcp   open     ssh           syn-ack ttl 64
| 25/tcp   filtered smtp          no-response
| 3389/tcp open     ms-wbt-server syn-ack ttl 55
| MAC Address: XX:XX:XX:XX:XX:XX
|
| Read data files from: /usr/bin/../share/nmap
| Nmap done: 1 IP address (1 host up) scanned in 0.22 seconds

``-p`` option is to specify a single port (or a port range, e.g. ``p22-25``)::

  nmap -p3142 host_name

| Starting Nmap 7.80 ( https://nmap.org ) at 2022-06-06 07:33 CEST
| Nmap scan report for host_name (XXX.XXX.XXX.XXX)
| Host is up (0.0015s latency).
| rDNS record for XXX.XXX.XXX.XXX: host_name.localdomain
|
| PORT     STATE SERVICE
| 3142/tcp open  apt-cacher
| MAC Address: XX:XX:XX:XX:XX:XX
|
| Nmap done: 1 IP address (1 host up) scanned in 0.20 seconds

``-sU`` is for a UDP scan, ``--top-ports`` is to scan only the most common
ports (here the 100 most common ports). Note that **UDP scan requires root
privileges**::

  nmap -vv -sU -top-ports 100 host_name

| Starting Nmap 7.80 ( https://nmap.org ) at 2022-06-12 13:58 CEST
| Initiating ARP Ping Scan at 13:58
| Scanning host_name (XXX.XXX.XXX.XXX) [1 port]
| Completed ARP Ping Scan at 13:58, 0.13s elapsed (1 total hosts)
| Initiating UDP Scan at 13:58
| Scanning host_name (XXX.XXX.XXX.XXX) [100 ports]
| Increasing send delay for XXX.XXX.XXX.XXX from 0 to 50 due to max_successful_tryno increase to 4
| Increasing send delay for XXX.XXX.XXX.XXX from 50 to 100 due to max_successful_tryno increase to 5
| Increasing send delay for XXX.XXX.XXX.XXX from 100 to 200 due to max_successful_tryno increase to 6
| Increasing send delay for XXX.XXX.XXX.XXX from 200 to 400 due to max_successful_tryno increase to 7
| Increasing send delay for XXX.XXX.XXX.XXX from 400 to 800 due to max_successful_tryno increase to 8
| Discovered open port 5353/udp on XXX.XXX.XXX.XXX
| UDP Scan Timing: About 41.20% done; ETC: 13:59 (0:00:44 remaining)
| Completed UDP Scan at 14:00, 104.42s elapsed (100 total ports)
| Nmap scan report for host_name (XXX.XXX.XXX.XXX)
| Host is up, received arp-response (0.13s latency).
| rDNS record for XXX.XXX.XXX.XXX: host_name.localdomain
| Scanned at 2022-06-12 13:58:35 CEST for 105s
| Not shown: 98 closed ports
| Reason: 98 port-unreaches
| PORT     STATE         SERVICE  REASON
| 68/udp   open|filtered dhcpc    no-response
| 5353/udp open          zeroconf udp-response ttl 255
| MAC Address: XX:XX:XX:XX:XX:XX
|
| Read data files from: /usr/bin/../share/nmap
| Nmap done: 1 IP address (1 host up) scanned in 104.64 seconds
|            Raw packets sent: 201 (7.040KB) | Rcvd: 111 (6.956KB)

Using the command ``ss``, you can see which process or service uses a specific
port. On a `Debian GNU/Linux <https://www.debian.org>`_ system, you can
install it with::

  apt-get install iproute2

For example, to see which services uses the ports that Nmap has found opened,
you can do something like::

  ss -ane|awk "NR == 1 || /[0-9\]]:(22 |68 |3142 |5353 )/"

The output obtained on my Debian machines :download:`is available for download
(file ss_22_68_3142_5353)<download/ss_22_68_3142_5353>`.


Configuring nftables
--------------------


nftables configuration file
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: /etc/nftables.conf
  pair: systemctl commands; status
  pair: systemctl commands; start
  pair: systemctl commands; stop
  pair: systemctl commands; enable
  pair: systemctl commands; disable
  pair: systemctl commands; reload

The configuration file for nftables is the ``/etc/nftables.conf`` script. It's
not run if the nftables service is not active. You can check the nftables
service status with::

  systemctl status nftables

You can start and stop the service **as root** with::

  systemctl start nftables
  systemctl stop nftables

The service is started automatically when the machine boots only if it is
"enabled". You can enable the service **as root** with::

  systemctl enable nftables

or::

  systemctl enable nftables --now # Start and enable the service.

If ``/etc/nftables.conf`` has changed, you can take the change into account
**as root** with::

  systemctl reload nftables

You can disable the service **as root** with::

  systemctl disable nftables
  systemctl disable nftables --now # Stop and disable the service.


nft administration tool
~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: nft

``nft`` is the command line administration tool of the nftables framework that
make it possible to add, delete or change packet filtering rules with immediate
effect.

One way of managing nftables configuration is to configure it using ``nft`` and
then to use ``nft`` to output the rules (using command ``nft list ruleset``).
The output can be used as content for the ``/etc/nftables.conf`` script. Just
make sure to prepend the shebang and a flush command:

| #!/usr/sbin/nft -f
| flush ruleset

Note also that you can check the validity of the commands in the script
(without actually running them) with the ``--check`` option::

  nft --check --file /etc/nftables.conf


Example nftables configuration
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: nft
  pair: Linux firewalling; SSH
  pair: Linux firewalling; ICMP
  pair: Linux firewalling; RDP
  pair: Linux firewalling; DNS
  pair: Linux firewalling; HTTP
  pair: Linux firewalling; HTTPS
  pair: Linux firewalling; POP3-SSL
  pair: Linux firewalling; mDNS

Once again, use what you find here at your own risk!

All the ``nft`` commands below have to be run **as root**::

  # Remove all rules.
  nft flush ruleset

  # Add a table named "firewall" for IPv4 and IPv6.
  nft add table inet firewall

  # Add a chain named "fw_in" in table "firewall" with default policy "drop".
  # The chain is attached to the input hook.
  nft add chain inet firewall fw_in { \
    type filter hook input priority 0\; \
    policy drop\; \
  }

  # Similarly, add chains attached to the forward and output hooks.
  nft add chain inet firewall fw_fwd { \
    type filter hook forward priority 0\; \
    policy drop\; \
  }
  nft add chain inet firewall fw_out { \
    type filter hook output priority 0\; \
    policy drop\; \
  }

  # Drop invalid state connections.
  nft add rule inet firewall fw_in ct state invalid drop

  # Allow all incoming / outgoing established and related traffic.
  nft add rule inet firewall fw_in ct state established, related accept
  nft add rule inet firewall fw_out ct state established, related accept

  # Allow everything from and to loopback interface.
  nft add rule inet firewall fw_in iif lo accept
  nft add rule inet firewall fw_out oif lo accept

  # Allow some inbound and outbound ICMP types.
  nft add rule inet firewall fw_in icmp type {destination-unreachable, \
                                              echo-reply, \
                                              echo-request, \
                                              source-quench, \
                                              time-exceeded} accept
  nft add rule inet firewall fw_in icmpv6 type {destination-unreachable, \
                                                echo-reply, \
                                                echo-request, \
                                                nd-neighbor-solicit, \
                                                nd-router-advert, \
                                                nd-neighbor-advert, \
                                                packet-too-big, \
                                                parameter-problem, \
                                                time-exceeded } accept
  nft add rule inet firewall fw_out icmp type {destination-unreachable, \
                                               echo-reply, \
                                               echo-request, \
                                               source-quench, \
                                               time-exceeded} accept
  nft add rule inet firewall fw_out icmpv6 type {destination-unreachable, \
                                                 echo-reply, \
                                                 echo-request, \
                                                 nd-neighbor-solicit, \
                                                 nd-router-advert, \
                                                 nd-neighbor-advert, \
                                                 packet-too-big, \
                                                 parameter-problem, \
                                                 time-exceeded } accept

  # Allow incoming SSH connections.
  nft add rule inet firewall fw_in tcp dport ssh accept

  # Allow outgoing DNS queries.
  nft add rule inet firewall fw_out tcp dport 53 accept
  nft add rule inet firewall fw_out udp dport 53 accept

  # Allow outgoing NTP (Network Time Protocol) client requests.
  nft add rule inet firewall fw_out udp dport 123 accept

  # NOTE: If you just need SSH access to the machine and time synchronization,
  # you can stop here.

  # Allow outgoing SSH connections.
  nft add rule inet firewall fw_out tcp dport ssh accept

  # Allow RDP.
  nft add rule inet firewall fw_in tcp dport 3389 accept

  # Allow outgoing Web (http and https) queries.
  nft add rule inet firewall fw_out tcp dport http accept
  nft add rule inet firewall fw_out tcp dport https accept

  # Allow POP3-SSL client.
  nft add rule inet firewall fw_out tcp dport 995 accept

  # Allow mDNS.
  nft add rule inet firewall fw_in pkttype multicast udp dport 5353 accept
  nft add rule inet firewall fw_out udp sport 5353 accept


Allow outgoing Web queries to a set of specific servers
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

On a remote machine, I initially used the configuration above (stopping after
allowing incoming SSH connections), and then realized I couldn't upgrade the
system anymore (i.e. ``apt-get update`` and of course ``apt-get dist-upgrade``
didn't work any more) because nftables was blocking the DNS queries, and also
the Web queries to the Debian repositories.

Obviously, I allowed the outgoing DNS queries with the commands provided above,
defined a set of addresses for the servers used by the ``apt-get update`` and
``apt-get dist-upgrade`` commands, and allowed outgoing Web (http and https)
queries.

Note that the list of servers used depends on your APT configuration.

I used the following commands (**as root**) to create and populate the set of
addresses::

  # Create a set named "debian_sources" (in table "firewall") that can store
  # multiple individual IPv4 addresses.
  nft add set inet firewall debian_sources { type ipv4_addr \; }

  # Add some addresses to the set. Both numerical addresses and domain names
  # are valid.
  nft add element inet firewall debian_sources { XXX.XXX.XXX.XXX, \
                                                 YYY.YYY.YYY.YYY, \
                                                 ZZZ.ZZZ.ZZZ.ZZZ }

Finally I used the following commands (**as root**) to allow the Web queries
(http and https) to the servers in the set::

  nft add rule inet firewall fw_out \
      ip daddr @debian_sources tcp dport http accept
  nft add rule inet firewall fw_out \
      ip daddr @debian_sources tcp dport https accept


Deleting individual rules or sets
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To delete an nftables rule, you first have to find its handle (a numerical
value). To see the handles of the rules, use option ``-a`` in the ``nft list
ruleset`` command::

  nft -a list ruleset

Then delete the rule with a command like the following (example of deletion of
a rule in the "fw_out" chain of the "firewall" table)::

  nft delete rule inet firewall fw_out handle <handle_value>

To delete a set, use a command like (example of deletion of a set in the table
"firewall")::

  nft delete set inet firewall <set_name>


Deleting the whole ruleset
~~~~~~~~~~~~~~~~~~~~~~~~~~

To delete the whole nftables ruleset, do::

  nft flush ruleset


Note about DHCP
~~~~~~~~~~~~~~~

.. index::
  single: DHCP

If you have to configure nftables on a machine that is also a `DHCP
<https://en.wikipedia.org/wiki/Dynamic_Host_Configuration_Protocol>`_ server or
client, read the "Firewall rules" section in `the DHCP README file
<https://github.com/isc-projects/dhcp>`_.


Updating /etc/nftables.conf
~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. index::
  single: /etc/nftables.conf

Once you have configured nftables using ``nft`` commands, you may want to
update ``/etc/nftables.conf`` so that the configuration is preserved on next
start of nftables. You can do this using the following commands (**as root**)::

  printf '#!/usr/sbin/nft -f\n\nflush ruleset\n\n' > /etc/nftables.conf
  nft list ruleset >> /etc/nftables.conf


Installing and configuring Fail2ban
-----------------------------------

.. index::
  single: fail2ban
  single: fail2ban-client
  single: /etc/fail2ban/jail.local
  pair: systemctl commands; start
  pair: systemctl commands; enable

You can install `Fail2ban <https://en.wikipedia.org/wiki/Fail2ban>`_ on a
`Debian GNU/Linux <https://www.debian.org>`_ system with::

  apt-get install fail2ban

Assuming you have nftables running, and an SSH server listening on port 22,
creating (**as root**) file ``/etc/fail2ban/jail.local`` with the following
content and then starting Fail2ban (``systemctl start fail2ban``) should be
enough to have Fail2ban prevent brute force attacks on the SSH server.

| [DEFAULT]
| banaction = nftables
| banaction_allports = nftables[type=allports]
|
| [sshd]
| enabled = true
| port = ssh

Make sure you enable Fail2ban so that it starts automatically on next reboot::

  systemctl enable fail2ban

You can get some information about the state of Fail2ban using
``fail2ban-client``::

  fail2ban-client status
  fail2ban-client status sshd


Other resources
---------------

* `Paul Gorman's technical note about nftables
  <https://paulgorman.org/technical/linux-nftables.txt.html>`_
* `Fredrik Jonsson's blog post "Setting up a server firewall with nftables that
  support WireGuard VPN"
  <https://xdeb.org/post/2019/setting-up-a-server-firewall-with-nftables-that-support-wireguard-vpn>`_
* `Beginners guide to nftables traffic filtering
  <https://linux-audit.com/nftables-beginners-guide-to-traffic-filtering>`_
* `Nmap cheat sheet <https://www.stationx.net/nmap-cheat-sheet>`_
