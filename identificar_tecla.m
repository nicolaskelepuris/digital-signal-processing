function tecla = identificar_tecla(nome_arquivo, duracao, frequencias_inferiores, frequencias_superiores, teclas)
    [b,a] = criar_filtro_butterworth();
    [fft_sinal_entrada, f, N] = filtrar(b, a, nome_arquivo, duracao);    
    [index_frequencia_inferior, index_frequencia_superior] = encontrar_indexes_frequencias(fft_sinal_entrada, f, N, frequencias_inferiores, frequencias_superiores);
    
    tecla = teclas(index_frequencia_inferior, index_frequencia_superior);
end

function [b, a] = criar_filtro_butterworth()
    polos = 4;
    frequencia_de_corte = 2500/5000;
    passa_baixas = 'low';
    analogico = 's';
    [b, a] = butter(polos,frequencia_de_corte,passa_baixas,analogico);
end

function [index_frequencia_inferior, index_frequencia_superior] = encontrar_indexes_frequencias(fft_sinal_entrada, f, N, frequencias_inferiores, frequencias_superiores)
    [~, indexes] = maxk(fft_sinal_entrada(1:N/2), 2);
    frequencias = f(1:N/2);
    maiores_frequencias = [frequencias(indexes(1)) frequencias(indexes(2))];
    maior_frequencia = max(maiores_frequencias);
    segunda_maior_frequencia = min(maiores_frequencias);
    index_frequencia_inferior = frequencias_inferiores >= segunda_maior_frequencia * 0.95 & frequencias_inferiores <= segunda_maior_frequencia * 1.05;
    index_frequencia_superior = frequencias_superiores >= maior_frequencia * 0.95 & frequencias_superiores <= maior_frequencia * 1.05;
end

function [fft_sinal_entrada, f, N] = filtrar(b, a, nome_arquivo, duracao)
    w = 0:pi/1000:pi; %determina um eixo para freq
    h = freqs(b,a,w); %calcula a resposta em freq do filtro
    subplot(2,1,1); plot(w/pi,abs(h)); hold on; title('resposta dominio frequencia analogico');

    T = 1;
    [bz, az] = bilinear(b,a,T);
    hz = freqz(bz,az,w);
    subplot(2,1,2); plot(w/pi,abs(hz)); hold on; title('resposta dominio frequencia digital');

    [entrada_discretizada,Fs] = audioread(nome_arquivo);
    sinal_filtrado = filter(b, a, entrada_discretizada);

    t = 0:(1/Fs):duracao;
    N = max(t)/(1/Fs);
    n = 0:N;
    fft_sinal_entrada = abs(fft(entrada_discretizada)/N);
    fft_sinal_filtrado = abs(fft(sinal_filtrado)/N);
    f_resol = Fs/N;
    f = n.*f_resol;
    subplot(1,2,1); plot(entrada_discretizada); hold on; plot(sinal_filtrado,'r');
    subplot(1,2,2); plot(f(1:N/2), fft_sinal_entrada(1:N/2)); hold on;
    plot(f(1:N/2),fft_sinal_filtrado(1:N/2),'r');
end
