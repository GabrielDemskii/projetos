programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Teclado --> t
	inclua biblioteca Graficos --> ui


	logico direita = falso, esquerda = falso, cima = falso, baixo = falso

	inteiro xCobra = 175, yCobra = 275, tamanhoCobra = 2
	inteiro pontuacao = 0
	inteiro xComida[19] = {500, 475, 450, 425, 400, 375, 350, 325, 300, 275, 250, 225, 200, 175, 150, 125, 100, 75, 50}, yComida[19] = {500, 475, 450, 425, 400, 375, 350, 325, 300, 275, 250, 225, 200, 175, 150, 125, 100, 75, 50}, xComidaPosicao = 425, yComidaPosicao = 275
	
	inteiro xCaudaCobra[600], yCaudaCobra[600]
	
	
	funcao inicio()
	{
		iniciarJanela()

		//Faz o jogo rodar.
		enquanto(verdadeiro){
			janela()
			
			direcionarCobra()
			
			atualizarPosicaoCobra()
			moverCobra()
			reiniciar()
			

			desenharComida()
			cabecaCobra()
			desenharCauda()


			sortearComida()			


			ui.renderizar()
			
			//Da um delay para cada repetição.
			u.aguarde(100)
		}
	}


	//Cria a janela que o jogo ira acontecer.
	funcao iniciarJanela(){
		//Inicia a janela.
		ui.iniciar_modo_grafico(verdadeiro)
		
		//Define a altura, largura da janela e seu titulo.
		ui.definir_dimensoes_janela(600, 600)
		ui.definir_titulo_janela("Jogo")
	}
	//Tudo que aparece na tela.
	funcao janela(){
		//Background.
		ui.definir_cor(ui.COR_VERDE)
		ui.limpar()


		//Configuração previa para texto.
		ui.definir_cor(ui.COR_PRETO)
		ui.definir_tamanho_texto(22.0)
		
		//Pontuação do usuario.
		ui.desenhar_texto(10, 10, "Pontuação: " + pontuacao)
		//Texto Avisando do Botão de Reiniciar.
		ui.desenhar_texto(10, 560, "Precione R para reiniciar")


		//Campo do Jogo.
		ui.definir_cor(ui.COR_BRANCO)
		ui.desenhar_retangulo(50, 50, 500, 500, falso, verdadeiro)
	}
	
	//Cria a Cabaça da cobra.
	funcao cabecaCobra(){
		ui.definir_cor(ui.COR_VERDE)
		ui.desenhar_retangulo(xCobra, yCobra, 25, 25, falso, verdadeiro)
	}
	
	//Cada uma verifica a tecla que esta sendo precionada e faz as outras não estarem mais sendo precionadas.
	funcao direcionarCobra(){
		//Cima
		se(t.tecla_pressionada(t.TECLA_W)){
			cima = verdadeiro
			baixo = falso
			esquerda = falso
			direita = falso
		}
		//Baixo
		se(t.tecla_pressionada(t.TECLA_S)){
			baixo = verdadeiro
			cima = falso
			esquerda = falso
			direita = falso
		}
		//Esquerda
		se(t.tecla_pressionada(t.TECLA_A)){
			esquerda = verdadeiro
			baixo = falso
			cima = falso
			direita = falso
		}
		//Direita
		se(t.tecla_pressionada(t.TECLA_D)){
			direita = verdadeiro
			baixo = falso
			esquerda = falso
			cima = falso
		}
	}

	funcao atualizarPosicaoCobra(){
		xCaudaCobra[0] = xCobra
		yCaudaCobra[0] = yCobra

		para(inteiro i = 599; i > 0; i--){
			xCaudaCobra[i] = xCaudaCobra[i - 1]
			yCaudaCobra[i] = yCaudaCobra[i - 1]
		}
	}
	funcao desenharCauda(){
		se(comerComida()){
			tamanhoCobra++
		}
		para(inteiro i = 0; i < tamanhoCobra; i++){
			ui.desenhar_retangulo(xCaudaCobra[i], yCaudaCobra[i], 25, 25, falso, verdadeiro)
		}
	}
	funcao logico cobraSeMordeu(){
		logico mordeu = falso
		para(inteiro i = 0; i < tamanhoCobra; i++){
			se(xCobra == xCaudaCobra[i] e yCobra == yCaudaCobra[i]){
				mordeu = verdadeiro
			}senao{
				mordeu = falso
			}
		}
		retorne mordeu
	}


	
	//Movimenta a Cabeça da Cobra
	funcao moverCobra(){
		//Movimento Horizontal
		se(direita){
			xCobra += 25
		}senao se(esquerda){
			xCobra -= 25
		}
		
		//Movimento Vertical
		se(cima){
			yCobra -= 25
		}senao se(baixo){
			yCobra += 25
		}
	}

	funcao logico comerComida(){
		se(xCobra == xComidaPosicao e yCobra == yComidaPosicao){
			pontuacao += 50 
			retorne verdadeiro
		}senao{
			retorne falso
		}
	}
	funcao sortearComida(){
		inteiro xIndice = u.sorteia(0, 18), yIndice = u.sorteia(0, 18)

		se(comerComida()){
			xComidaPosicao = xComida[xIndice]
			yComidaPosicao = yComida[yIndice]
		}
	}
	funcao desenharComida(){
		ui.definir_cor(ui.COR_VERMELHO)
		ui.desenhar_retangulo(xComidaPosicao, yComidaPosicao, 25, 25, falso, verdadeiro)
	}


	//Verifica se a cobra encostou em alguma lateral se sim então o jogo reiniciara com o alcilio da função reiniciar.
	//Também cria um botão para reiniciar.
	funcao logico cobraBater(){
		
		se(xCobra < 50 ou xCobra > 525 ou t.tecla_pressionada(t.TECLA_R)){
			retorne verdadeiro
		}
		
		senao se(yCobra < 50 ou yCobra > 525 ou t.tecla_pressionada(t.TECLA_R)){
			retorne verdadeiro
		}

		senao{
			retorne falso
		}
	}
	funcao reiniciar(){
		//Caso a cobra bater em alguma das paredes ela ira reiniciar.
		se(cobraBater() ou cobraSeMordeu()){
			//Reinicia a posição da cobra.
			xCobra = 175
			yCobra = 275

			tamanhoCobra = 2

			//Reinicia a posição da comida.
			xComidaPosicao = 425
			yComidaPosicao = 275
			
			//Deixa ela parada para quando o jogo começar.
			direita = falso
			baixo = falso
			esquerda = falso
			cima = falso

			//Reinicia a pontuação.
			pontuacao = 0
		}
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 850; 
 * @DOBRAMENTO-CODIGO = [48, 57, 79, 85, 148, 164, 172, 180, 188];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */