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
