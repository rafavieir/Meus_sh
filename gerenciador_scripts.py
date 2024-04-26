import os

def main():
    print("Configurador de rede.")
    print("Qual sistema você deseja configurar?")
    
    def listar_pastas(caminho):
        try:
            pastas = [pasta for pasta in os.listdir(caminho) if os.path.isdir(os.path.join(caminho, pasta))]
            
            for indice, pasta in enumerate(pastas, start=1):
                diretorio = "{} {}".format(indice, pasta)
                print(diretorio)        
            return pastas
        except OSError as e:
            print(f"Erro ao acessar o diretório: {e}")
            return []
        
    diretorio = "."
    pastas = listar_pastas(diretorio)
    
    choice = input("Digite o numero correspondente ao sistema: ")
    
    try:
        indice_escolhido = int(choice)
        if 1 <= indice_escolhido <= len(pastas):
            pasta_escolhida = pastas[indice_escolhido - 1]
            arquivo_conf = f"{pasta_escolhida}.py"
            print(f"Você escolheu a pasta: {pasta_escolhida}")
            print(f"Executando o arquivo: {arquivo_conf}")
            execute_arquivo(os.path.join(os.path.dirname(__file__), pasta_escolhida, arquivo_conf))
        else:
            print("Escolha inválida.")
    except ValueError:
        print("Por favor, insira um número válido.")

def execute_arquivo(caminho):
    if os.path.exists(caminho):
        os.system("clear")
        print(f"Executando arquivo {caminho}...")
        os.system("python3 " + caminho)
    else:
        print(f"Arquivo {caminho} não encontrado.")

if __name__ == "__main__":
    main()
