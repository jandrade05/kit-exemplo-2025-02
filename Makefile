# Formato geral de um Makefile
#
# alvo: pre-requisito1 pre-requisito2
#	comandos que usam os pre-requisitos para gerar o alvo 

all: paper/paper.pdf resultados/numero_de_dados.txt 
	# nenhum comando, all é alvo fictício 

clean: 
	rm -r -f -v resultados dados figuras paper/paper.pdf 
	
paper/paper.pdf: paper/paper.tex figuras/variacao_temperatura.png
	tectonic -X compile paper/paper.tex 
	
resultados/numero_de_dados.txt: dados/temperature-data.zip
	mkdir -p resultados 
	ls dados/temperatura/*.csv | wc -l > resultados/numero_de_dados.txt 
	
dados/temperature-data.zip: code/baixa_dados.py
	python code/baixa_dados.py dados 
	
resultados/variacao_temperatura.csv: dados/temperature-data.zip code/variacao-temperatura-todos.sh
	mkdir -p resultados
	bash code/variacao-temperatura-todos.sh > resultados/variacao_temperatura.csv 
	
figuras/variacao_temperatura.png: code/plota_dados.py resultados/variacao_temperatura.csv
	mkdir -p figuras
	python code/plota_dados.py resultados/variacao_temperatura.csv figuras/variacao_temperatura.png