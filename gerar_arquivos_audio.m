function gerar_arquivos_audio(duracao, frequencias_inferiores, frequencias_superiores, teclas)
    for linha = 1:1:size(teclas, 1)
        for coluna = 1:1:size(teclas, 2)
            frequencia_inferior = frequencias_inferiores(linha);
            frequencia_superior = frequencias_superiores(coluna);
            tecla = teclas(linha, coluna);
            gerar_audio_tecla(duracao, frequencia_inferior, frequencia_superior, tecla);
        end
    end
end

function gerar_audio_tecla(duracao, frequencia_inferior, frequencia_superior, tecla)
    frequencia_amostragem = 8000; % Hz
    
    sinal_inferior = gerar_sinal(frequencia_inferior, duracao, frequencia_amostragem);
    sinal_superior = gerar_sinal(frequencia_superior, duracao, frequencia_amostragem);
    soma = sinal_inferior + sinal_superior;
    
    audiowrite(criar_nome_arquivo(tecla), soma, frequencia_amostragem);
end

function sinal = gerar_sinal(frequencia, duracao, frequencia_amostragem)
    tempo_captura_sinal = 0 : (1 / frequencia_amostragem) : duracao;
    sinal = sin(2 * pi * (tempo_captura_sinal * frequencia));
end
