# README 

Execução
=====================

## Como rodar no Mac OS (testado no MacOS 10.13.3)
 
 > ./run.sh

## Como rodar no Linux (testado no Ubuntu 16.0.4 LTS)

 > Baixe o pacote do Swift no próprio site do [Swift.org], na extensão .tar.gz.
 > Descompacte o arquivo baixado.
 > Pegue o caminho absoluto do arquivo utilizando o comando **pwd**, e copie-o.
 > Copie o comando **export PATH=/caminho/copiado/:$PATH**, onde **/caminho/copiado/** é o caminho que foi copiado no comando pwd.
 > Vamos editar a lista de comandos executados na inicialização do terminal, executando o comando **nano .bashrc**.
 > Ao final do arquivo, cole o comando **export** copiado no passo anterior.
 > Reinicie o terminal.
 > Teste com o comando **swift -version**.
 > Execute **./run.sh** na pasta raiz do projeto do compilador.
 
Programas 
=====================

Na classe main.swift, existe uma variável testCase. Existem 3 casos de teste.

## testeCase = 1

Programa de exemplo do livro

~~~~
	// programa 1
 	{
        int i; int j; float v; float x; float[100] a;
        while( true ) {

            do i = i+1; while( a[i] < v);
            do j = j-1; while( a[j] > v);
            if( i >= j ) break;

            x = a[i]; a[i] = a[j]; a[j] = x;
        }
    }

    // output 
	L1:
	L3:
		i = i + 1
	L5:
		t1 = i * 8
		t2 = a [t1]
		if t2 < v goto L3
	L4:
		j = j - 1
	L7:
		t3 = j * 8
		t4 = a [t3]
		if t4 > v goto L4
	L6:
		iffalse i >= j goto L8
	L9:
		goto L2
	L8:
		t5 = i * 8
		x = a [t5]
	L10:
		t6 = i * 8
		t7 = j * 8
		t8 = a [t7]
		a[t6] = t8
	L11:
		t9 = j * 8
		a[t9] = x
		goto L1
	L2:

~~~~

## testeCase = 2

Exercitando if/else if/else e precedência
 de operadores

~~~~
	// programa 2
	{
        int a; int b; int c;
        a = 10;
        if (a > 10) {
            b = a * c + 5;
        } else if (a < 10) {
            b = a + c * c + a;
        } else {
            b = a - c;
        }
    }

    // output
	L1:
		a = 10
	L3:
		iffalse a > 10 goto L5
	L4:
		t1 = a * c
		b = t1 + 5
		goto L2
	L5:
		iffalse a < 10 goto L7
	L6:
		t2 = c * c
		t3 = a + t2
		b = t3 + a
		goto L2
	L7:
		b = a - c
	L2:

~~~~

## testeCase = 3

Testando acesso a matriz

~~~~
{
        int[10] bar;
        int foo;

        foo = 0;
        while ( foo < 10 ) {
            bar[foo] = foo * 2;
            foo = foo + 1;
        }
    }

L1:
	foo = 0
L3:
	iffalse foo < 10 goto L2
L4:
	t1 = foo * 4
	t2 = foo * 2
	bar[t1] = t2
L5:
	foo = foo + 1
	goto L3
L2: