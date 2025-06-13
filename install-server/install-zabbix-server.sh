#!/usr/bin/env bash

# Atualização e limpeza
sudo apt update -y && sudo apt upgrade -y
clear

echo ""
echo "Instalação do Zabbix Server"
echo "==========================="
echo ""

# Zabbix version
function version_zabbix() {
    echo """
Escolha a Versão do Zabbix:

1 - Zabbix 7.0 LTS
2 - Zabbix 6.0 LTS
"""
    read -p "Digite o número da versão desejada: " version

    case $version in
        1) zabbix_version="7.0" ;;
        2) zabbix_version="6.0" ;;
        *) echo "Opção inválida. Usando versão 7.0 por padrão."; zabbix_version="7.0" ;;
    esac
}

# Sistema Operacional
function distribuicao_so() {
    echo """
Escolha a Distribuição do SO:

1 - Ubuntu
2 - Debian
"""
    read -p "Digite o número da distribuição: " distrib

    case $distrib in
        1) distro="ubuntu" ;;
        2) distro="debian" ;;
        *) echo "Opção inválida. Por hora só Ubuntu e Debian."; exit 1 ;;
    esac
}

# Versão do sistema operacional
function version_so() {
    echo ""
    echo "Escolha a versão do $distro:"

    if [ "$distro" == "ubuntu" ]; then
        echo """
1 - 22.04 (Jammy)
2 - 20.04 (Focal)
"""
        read -p "Digite a versão: " so_version
        case $so_version in
            1) so_codename="jammy" ;;
            2) so_codename="focal" ;;
            *) echo "Versão inválida."; exit 1 ;;
        esac

    elif [ "$distro" == "debian" ]; then
        echo """
1 - 12 (Bookworm)
2 - 11 (Bullseye)
"""
        read -p "Digite a versão: " so_version
        case $so_version in
            1) so_codename="bookworm" ;;
            2) so_codename="bullseye" ;;
            *) echo "Versão inválida."; exit 1 ;;
        esac
    fi
}

# Componentes do Zabbix
function zabbix_components() {
    echo """
Escolha os componentes do Zabbix:

1 - Server, Frontend, Agent
2 - Server, Frontend, Agent 2
3 - Proxy
4 - Agent
5 - Agent 2
6 - Java Gateway
7 - Web Service
"""
    read -p "Digite o número do componente: " component_option

    case $component_option in
        1) zabbix_component="server frontend agent" ;;
        2) zabbix_component="server frontend agent2" ;;
        3) zabbix_component="proxy" ;;
        4) zabbix_component="agent" ;;
        5) zabbix_component="agent2" ;;
        6) zabbix_component="java-gateway" ;;
        7) zabbix_component="web-service" ;;
        *) echo "Componente inválido."; exit 1 ;;
    esac
}

# Banco de dados
function database_choice() {
    echo """
Escolha o banco de dados:

1 - MySQL/MariaDB
2 - PostgreSQL
"""
    read -p "Digite o número do banco desejado: " db_choice

    case $db_choice in
        1) db_type="mysql" ;;
        2) db_type="postgresql" ;;
        *) echo "Banco inválido."; exit 1 ;;
    esac
}

# Webserver
function webserver_choice() {
    echo """
Escolha o servidor Web:

1 - Apache
2 - Nginx
"""
    read -p "Digite o número do webserver: " web_choice

    case $web_choice in
        1) webserver="apache" ;;
        2) webserver="nginx" ;;
        *) echo "Servidor inválido."; exit 1 ;;
    esac
}

# Execução das funções
version_zabbix
distribuicao_so
version_so
zabbix_components
database_choice
webserver_choice

# Resumo
clear
echo "==============================="
echo "Resumo da Configuração:"
echo "==============================="
echo "Zabbix Version : $zabbix_version"
echo "Distribuição   : $distro"
echo "Versão do SO   : $so_codename"
echo "Componentes    : $zabbix_component"
echo "Banco de Dados : $db_type"
echo "Web Server     : $webserver"
echo "==============================="

# Aqui poderia começar a instalar o repositório e pacotes com base nessas opções
# Exemplo:
# echo "Baixando repositório do Zabbix..."
# wget https://repo.zabbix.com/zabbix/$zabbix_version/$distro/pool/main/z/zabbix-release/zabbix-release_$zabbix_version-1+$so_codename_all.deb
