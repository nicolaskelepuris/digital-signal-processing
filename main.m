frequencias_inferiores = [697 770 852 941];
frequencias_superiores = [1209 1336 1477 1633];
teclas = ["1" "2" "3" "A"; "4" "5" "6" "B"; "7" "8" "9" "C"; "asterisco" "0" "jogo_da_velha" "D";];
duracao = 0.2;
gerar_arquivos_audio(duracao, frequencias_inferiores, frequencias_superiores, teclas)
ler_e_discar_telefone()

falhas = testar_identificacao_teclas(teclas, duracao, frequencias_inferiores, frequencias_superiores);
falhas

function falhas = testar_identificacao_teclas(teclas, duracao, frequencias_inferiores, frequencias_superiores)
    falhas = [];
    for linha = 1:1:size(teclas, 1)
        for coluna = 1:1:size(teclas, 2)
            tecla = teclas(linha, coluna);
            identificada = identificar_tecla(criar_nome_arquivo(tecla), duracao, frequencias_inferiores, frequencias_superiores, teclas);
            if (tecla ~= identificada)
                falhas = [falhas tecla];
            end
        end
    end
end
