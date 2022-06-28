gerar_arquivos_audio()
ler_e_discar_telefone()

function gerar_arquivos_audio()
    frequencias_inferiores = [697 770 852 941];
    frequencias_superiores = [1209 1336 1477 1633];
    teclas = ["1" "2" "3" "A"; "4" "5" "6" "B"; "7" "8" "9" "C"; "asterisco" "0" "jogo_da_velha" "D";];
    for linha = 1:1:size(teclas, 1)
        for coluna = 1:1:size(teclas, 2)
            frequencia_inferior = frequencias_inferiores(linha);
            frequencia_superior = frequencias_superiores(coluna);
            tecla = teclas(linha, coluna);
            gerar_audio_tecla(frequencia_inferior, frequencia_superior, tecla);
        end
    end
end

function gerar_audio_tecla(frequencia_inferior, frequencia_superior, tecla)
    duracao = 0.2; % segundos
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

function nome_arquivo = criar_nome_arquivo(tecla)
    nome_arquivo = "tecla_" + tecla + ".wav";
end

function ler_e_discar_telefone()
    telefone = input("Informe o numero de telefone que deseja discar: ", "s");
    discar(telefone)
end

function discar(telefone)
    for numero = telefone
        executar_som(char_to_tecla(numero));
        pause(0.3);
    end
end

function executar_som(tecla)
    [y,Fs] = audioread(criar_nome_arquivo(tecla));
    sound(y,Fs);
end

function tecla = char_to_tecla(character)
    tecla = convertCharsToStrings(character);
    if (tecla == "*")
        tecla = "asterisco";
    end
    if (tecla == "#")
        tecla = "jogo_da_velha";
    end
end