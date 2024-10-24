#!/bin/bash

#Precisa de um tree.txt com a estrutura do projeto a ser criado


# Verifica se o arquivo tree.txt existe
if [ ! -f "tree.txt" ]; then
    echo "Arquivo tree.txt não encontrado!"
    exit 1
fi

# Arquivo que contém a árvore de diretórios e arquivos
FILE="tree.txt"
created_paths=""

# Função para criar diretórios e arquivos
create_structure() {
    local current_dir=""
    local previous_indent=0
    local base_dir_stack=()

    while IFS= read -r line || [ -n "$line" ]; do
        # Remove comentários no final da linha e espaços no início/fim
        clean_line=$(echo "$line" | sed 's/#.*//; s/^[ \t]*//; s/[ \t]*$//')

        # Ignora linhas vazias
        [ -z "$clean_line" ] && continue

        # Contar o nível de indentação (considera 4 espaços como um nível)
        current_indent=$(echo "$line" | grep -o '^\s*' | wc -c)
        current_indent=$((current_indent / 4))  # Assume 4 espaços por nível de indentação

        # Se o nível de indentação for menor, subir no stack de diretórios
        while [ "$previous_indent" -gt "$current_indent" ]; do
            base_dir_stack=("${base_dir_stack[@]:0:${#base_dir_stack[@]}-1}")
            previous_indent=$((previous_indent - 1))
        done

        # Atualizar diretório base
        current_dir=$(IFS=/; echo "${base_dir_stack[*]}")

        # Verificar se é um diretório ou um arquivo
        if [[ "$clean_line" == */ ]]; then
            # Diretório
            dir_name="${clean_line%/}"  # Remove a barra no final para pegar o nome do diretório
            dir_name=$(echo "$dir_name" | sed 's/[^a-zA-Z0-9._-]//g')  # Mantém apenas letras, números, ponto, underscore e hífen
            new_dir="$current_dir/$dir_name"
            mkdir -p "$new_dir"
            echo "Diretório criado: $new_dir"
            created_paths="$created_paths$new_dir/\n"
            base_dir_stack+=("$dir_name")
        else
            # Arquivo
            file_name=$(echo "$clean_line" | sed 's/[^a-zA-Z0-9._-]//g')  # Mantém apenas letras, números, ponto, underscore e hífen
            new_file="$current_dir/$file_name"
            touch "$new_file"
            echo "Arquivo criado: $new_file"
            created_paths="$created_paths$new_file\n"
        fi

        # Atualizar o nível de indentação anterior
        previous_indent=$current_indent
    done < "$FILE"
}

# Executa a função
create_structure

# Exibe a lista de todos os arquivos e diretórios criados
echo -e "\nResumo dos arquivos e diretórios criados:"
echo -e "$created_paths"
