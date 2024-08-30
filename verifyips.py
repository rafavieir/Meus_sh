import requests
import time

# Seu token da API do AbuseIPDB
api_key = '58cf7731af0c8e01dd666e487a38ba7d244baac51e8215da354ba8864b753dccfbb1d0a1d070f4c5'

# URL da API
url = 'https://api.abuseipdb.com/api/v2/check'

# Ler os IPs do arquivo ips.txt
with open('ips.txt', 'r') as file:
    ips = file.read().splitlines()

# Função para verificar se o IP é malicioso
def verificar_ip(ip):
    params = {
        'ipAddress': ip,
        'maxAgeInDays': '90'  # Verificar relatórios dos últimos 90 dias
    }
    headers = {
        'Accept': 'application/json',
        'Key': api_key
    }

    response = requests.get(url, headers=headers, params=params)
    data = response.json()

    if 'data' in data:
        return data['data']
    else:
        return None

# Verificar cada IP
resultados = []
for ip in ips:
    try:
        resultado = verificar_ip(ip)
        if resultado:
            resultados.append(resultado)
            print(f"IP: {resultado['ipAddress']}, Score: {resultado['abuseConfidenceScore']}, "
                  f"Total Reports: {resultado['totalReports']}, Malicious: {'Yes' if resultado['abuseConfidenceScore'] > 0 else 'No'}")
        time.sleep(1)  # Evitar exceder o limite de requisições
    except Exception as e:
        print(f"Erro ao verificar IP {ip}: {str(e)}")

# Salvar os resultados em um arquivo
with open('ips_verificados.txt', 'w') as file:
    for resultado in resultados:
        file.write(f"IP: {resultado['ipAddress']}, Score: {resultado['abuseConfidenceScore']}, "
                   f"Total Reports: {resultado['totalReports']}, Malicious: {'Yes' if resultado['abuseConfidenceScore'] > 0 else 'No'}\n")

print("Verificação concluída e resultados salvos em 'ips_verificados.txt'.")
