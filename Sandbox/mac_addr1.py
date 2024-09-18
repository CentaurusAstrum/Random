import socket
from scapy.all import ARP, Ether, srp

def get_my_ip(target_ip):
    """Ermittelt die lokale IP-Adresse, die verwendet wird, um das angegebene Ziel zu erreichen."""
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect((target_ip, 80))
    ip = s.getsockname()[0]
    s.close()
    return ip

def scan(ip_range):
    """Führt einen Netzwerkscan im angegebenen IP-Bereich durch, indem ARP-Requests gesendet werden."""
    arp_request = ARP(pdst=ip_range)
    broadcast = Ether(dst="ff:ff:ff:ff:ff:ff")
    arp_request_broadcast = broadcast / arp_request
    answered_list = srp(arp_request_broadcast, timeout=1, verbose=False)[0]

    clients_list = []
    for element in answered_list:
        clients_list.append({
            "ip": element[1].psrc,
            "mac": element[1].hwsrc
        })
    return clients_list
def find_mac(clients, search_mac):
    for client in clients:
        if client['mac'].lower() == search_mac.lower():
            return client['ip']
    return "MAC-Adresse nicht gefunden."

def create_ip_ranges(base_ip):
    """Erzeugt eine Liste von IP-Bereichen basierend auf der ermittelten Basis-IP-Adresse."""
    base_parts = base_ip.split('.')
    base_third_octet = int(base_parts[2])
    return [f"{base_parts[0]}.{base_parts[1]}.{octet}.1/24" for octet in range(base_third_octet - 1, base_third_octet + 2)]

if __name__ == "__main__":
    my_ip = get_my_ip("8.8.8.8")  # Google's DNS server as target
    ip_ranges = create_ip_ranges(my_ip)  # Automatisch angepasste IP-Bereiche

    all_clients = []  # Gesamtliste aller gefundenen Clients
    for ip_range in ip_ranges:
        print(f"Scanning {ip_range}...")
        clients = scan(ip_range)
        all_clients.extend(clients)  # Füge gefundene Clients zur Gesamtliste hinzu
        for client in clients:
            print(f"IP: {client['ip']} - MAC: {client['mac']}")

    search_mac = "7c:d9:5c:b1:91:31"
    found_ip = find_mac(all_clients, search_mac)  # Suche in der Gesamtliste aller Clients

    if found_ip != "MAC-Adresse nicht gefunden.":
        print(f"Die IP-Adresse der MAC {search_mac} ist {found_ip}.")
    else:
        print("MAC-Adresse nicht gefunden.")

    # Verbindungsnachricht hinzufügen
    if found_ip and found_ip != "MAC-Adresse nicht gefunden.":
        print(f'Connecting to Mendel at: {found_ip} ...')
    else:
        print('Connection to Mendel not possible, IP not found.')
