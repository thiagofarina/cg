# Universidade do Estado do Rio de Janeiro (UERJ)
# Instituto de Matematica e Estatistica (IME)
# Disciplina: Computacao Grafica
# Docente: Guilherme Abelha
# Discente: Gustavo da Silva Rodrigues
#
# Objetivo: Gerar uma imagem de saida cisalhada verticalmente, a partir de uma
# image de entrada normal. Para que o programa funcione, ha de se passar 2
# parametros: os valores da matriz da imagem de entrada e o parametro para o
# cisalhamento.

function CisalhamentoImage = CisalhamentoImage(entrada, cis)
  LinhasEntrada = rows(entrada);
  ColunasEntrada = columns(entrada);
  VetorEntrada = [LinhasEntrada, ColunasEntrada, 1];

  # Criacao da Matriz Inversa.
  MatrizTransMenos1 = [1, 0, -1; 0, 1, -1; 0, 0, 1];

  # Criacao da matriz que voltara a matriz aos pontos originais apos o
  # cisalhamento.
  MatrizTransMais1 = [1, 0, 1; 0, 1, 1; 0, 0, 1];

  # Criacao da Matriz de Cisalhamento.
  MatrizCis = [1, cis, 0; 0, 1, 0; 0, 0, 1];
  VetorSaida = VetorEntrada * MatrizTransMais1 * MatrizCis * MatrizTransMenos1;

  saida = zeros(VetorSaida(2), ColunasEntrada);
  LinhasSaida = rows(saida);
  ColunasSaida = columns(saida);

  # Neste momento eh realizado o calculo dos novos pontos para gerar a imagem
  # de saida.
  for y = 1: ColunasSaida
    for x = 1: LinhasSaida
      VetorSaida = [y, x, 1];
      VetorEntrada = VetorSaida * inv(MatrizTransMais1 * MatrizCis * MatrizTransMenos1);
      if (VetorEntrada(1) <= 0) || (VetorEntrada(2) <= 0)
        saida(x, y) = 0;
      else
        saida(x, y) = entrada(round(VetorEntrada(2)), round(VetorEntrada(1)));
      endif
    endfor
  endfor

  imwrite(uint8(saida), "teste.jpg");
endfunction
