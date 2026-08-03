-- ============ CONSTÂNCIA NA PALAVRA — seed dos planos novos (rodada 03/08) ============
-- Texto bíblico: João Ferreira de Almeida — DOMÍNIO PÚBLICO.
-- Fonte: bibliajfa.com.br, capturado nesta sessão via WebSearch + WebFetch (transcrição
-- verbatim, cada capítulo buscado 2x independentemente pra confirmar estabilidade byte-a-byte).
-- Método: 4 subagentes em paralelo, um por trecho do texto, cada um instruído a corrigir
-- manualmente o artefato de encoding conhecido ("à" -> "?") comparando contra o contexto
-- gramatical, e a não usar nenhum arquivo que não tivesse fetchado ele mesmo (ver nota abaixo).
-- Nota de proveniência: o subagente do Marcos 1-8 encontrou dois arquivos não solicitados
-- (ch9_raw.txt, ch10_raw.txt) na sua própria pasta de rascunho /tmp/marcos durante o trabalho.
-- Não usou o conteúdo deles. Na auditoria desta migration ficou claro que a causa foi mundana,
-- não maliciosa: o subagente do Marcos 9-16 rodou em paralelo e por coincidência usou a MESMA
-- pasta /tmp/marcos como rascunho, então os dois conjuntos de arquivos se misturaram. Registrado
-- aqui por transparência (cultura de honestidade radical do projeto), não porque tenha afetado
-- o resultado — o texto de Marcos 9-16 usado abaixo vem do próprio subagente responsável por
-- esse trecho, com a mesma verificação dupla dos demais.
-- Dois planos novos: Mulheres da Bíblia em 15 dias (curadoria temática, AT + NT) e
-- Evangelho de Marcos em 16 dias (um capítulo por dia, plano de porta de entrada).
-- Idempotente: on conflict atualiza. Escrita via service role (migration).

insert into reading_plans (id, slug, titulo, descricao, total_dias, ordem, ativo) values
  ('33333333-3333-4333-8333-333333333333', 'mulheres-da-biblia-15-dias', 'Mulheres da Bíblia em 15 dias', 'Uma mulher da Bíblia por dia — histórias reais de fé, coragem e recomeço pra você se ver nelas.', 15, 3, true),
  ('44444444-4444-4444-8444-444444444444', 'marcos-16-dias', 'Evangelho de Marcos em 16 dias', 'Um capítulo do Evangelho de Marcos por dia — o Jesus que age, o evangelho mais direto e rápido dos quatro.', 16, 4, true)
on conflict (slug) do update set titulo = excluded.titulo, descricao = excluded.descricao, total_dias = excluded.total_dias, ordem = excluded.ordem, ativo = excluded.ativo;

insert into reading_plan_days (plan_id, dia, referencia, texto) values
  ('33333333-3333-4333-8333-333333333333', 1, 'Gênesis 3', '1 Ora, a serpente era o mais astuto de todos os animais do campo, que o Senhor Deus tinha feito. E esta disse à mulher: É assim que Deus disse: Não comereis de toda árvore do jardim?
2 Respondeu a mulher à serpente: Do fruto das árvores do jardim podemos comer,
3 mas do fruto da árvore que está no meio do jardim, disse Deus: Não comereis dele, nem nele tocareis, para que não morrais.
4 Disse a serpente à mulher: Certamente não morrereis.
5 Porque Deus sabe que no dia em que comerdes desse fruto, vossos olhos se abrirão, e sereis como Deus, conhecendo o bem e o mal.
6 Então, vendo a mulher que aquela árvore era boa para se comer, e agradável aos olhos, e árvore desejável para dar entendimento, tomou do seu fruto, comeu, e deu a seu marido, e ele também comeu.
7 Então foram abertos os olhos de ambos, e conheceram que estavam nus; pelo que coseram folhas de figueira, e fizeram para si aventais.
8 E, ouvindo a voz do Senhor Deus, que passeava no jardim à tardinha, esconderam-se o homem e sua mulher da presença do Senhor Deus, entre as árvores do jardim.
9 Mas chamou o Senhor Deus ao homem, e perguntou-lhe: Onde estás?
10 Respondeu-lhe o homem: Ouvi a tua voz no jardim e tive medo, porque estava nu; e escondi-me.
11 Deus perguntou-lhe mais: Quem te mostrou que estavas nu? Comeste da árvore de que te ordenei que não comesses?
12 Ao que respondeu o homem: A mulher que me deste por companheira deu-me da árvore, e eu comi.
13 Perguntou o Senhor Deus à mulher: Que é isto que fizeste? Respondeu a mulher: A serpente enganou-me, e eu comi.
14 Então o Senhor Deus disse à serpente: Porquanto fizeste isso, maldita serás tu dentre todos os animais domésticos, e dentre todos os animais do campo; sobre o teu ventre andarás, e pó comerás todos os dias da tua vida.
15 Porei inimizade entre ti e a mulher, e entre a tua descendência e a sua descendência; esta te ferirá a cabeça, e tu lhe ferirás o calcanhar.
16 E à mulher disse: Multiplicarei grandemente a dor da tua concepção; em dor darás à luz filhos; e o teu desejo será para o teu marido, e ele te dominará.
17 E ao homem disse: Porquanto deste ouvidos à voz de tua mulher, e comeste da árvore de que te ordenei dizendo: Não comerás dela; maldita é a terra por tua causa; em fadiga comerás dela todos os dias da tua vida.
18 Ela te produzirá espinhos e abrolhos; e comerás das ervas do campo.
19 Do suor do teu rosto comerás o teu pão, até que tornes à terra, porque dela foste tomado; porquanto és pó, e ao pó tornarás.
20 Chamou Adão à sua mulher Eva, porque era a mãe de todos os viventes.
21 E o Senhor Deus fez túnicas de peles para Adão e sua mulher, e os vestiu.
22 Então disse o Senhor Deus: Eis que o homem se tem tornado como um de nós, conhecendo o bem e o mal. Ora, não suceda que estenda a sua mão, e tome também da árvore da vida, e coma e viva eternamente.
23 O Senhor Deus, pois, o lançou fora do jardim do Éden para lavrar a terra, de que fora tomado.
24 E havendo lançado fora o homem, pôs ao oriente do jardim do Éden os querubins, e uma espada flamejante que se envolvia por todos os lados, para guardar o caminho da árvore da vida.'),
  ('33333333-3333-4333-8333-333333333333', 2, 'Gênesis 18', '1 Depois apareceu o Senhor a Abraão junto aos carvalhos de Manre, estando ele sentado à porta da tenda, no maior calor do dia.
2 Levantando Abraão os olhos, olhou e eis três homens de pé em frente dele. Quando os viu, correu da porta da tenda ao seu encontro, e prostrou-se em terra,
3 e disse: Meu Senhor, se agora tenho achado graça aos teus olhos, rogo-te que não passes de teu servo.
4 Eia, traga-se um pouco d''água, e lavai os pés e recostai-vos debaixo da árvore;
5 e trarei um bocado de pão; refazei as vossas forças, e depois passareis adiante; porquanto por isso chegastes ate o vosso servo. Responderam-lhe: Faze assim como disseste.
6 Abraão, pois, apressou-se em ir ter com Sara na tenda, e disse-lhe: Amassa depressa três medidas de flor de farinha e faze bolos.
7 Em seguida correu ao gado, apanhou um bezerro tenro e bom e deu-o ao criado, que se apressou em prepará-lo.
8 Então tomou queijo fresco, e leite, e o bezerro que mandara preparar, e pôs tudo diante deles, ficando em pé ao lado deles debaixo da árvore, enquanto comiam.
9 Perguntaram-lhe eles: Onde está Sara, tua mulher? Ele respondeu: Está ali na tenda.
10 E um deles lhe disse: certamente tornarei a ti no ano vindouro; e eis que Sara tua mulher terá um filho. E Sara estava escutando à porta da tenda, que estava atrás dele.
11 Ora, Abraão e Sara eram já velhos, e avançados em idade; e a Sara havia cessado o incômodo das mulheres.
12 Sara então riu-se consigo, dizendo: Terei ainda deleite depois de haver envelhecido, sendo também o meu senhor já velho?
13 Perguntou o Senhor a Abraão: Por que se riu Sara, dizendo: É verdade que eu, que sou velha, darei à luz um filho?
14 Há, porventura, alguma coisa difícil ao Senhor? Ao tempo determinado, no ano vindouro, tornarei a ti, e Sara terá um filho.
15 Então Sara negou, dizendo: Não me ri; porquanto ela teve medo. Ao que ele respondeu: Não é assim; porque te riste.
16 E levantaram-se aqueles homens dali e olharam para a banda de Sodoma; e Abraão ia com eles, para os encaminhar.
17 E disse o Senhor: Ocultarei eu a Abraão o que faço,
18 visto que Abraão certamente virá a ser uma grande e poderosa nação, e por meio dele serão benditas todas as nações da terra?
19 Porque eu o tenho escolhido, a fim de que ele ordene a seus filhos e a sua casa depois dele, para que guardem o caminho do Senhor, para praticarem retidão e justiça; a fim de que o Senhor faça vir sobre Abraão o que a respeito dele tem falado.
20 Disse mais o Senhor: Porquanto o clamor de Sodoma e Gomorra se tem multiplicado, e porquanto o seu pecado se tem agravado muito,
21 descerei agora, e verei se em tudo têm praticado segundo o seu clamor, que a mim tem chegado; e se não, sabê-lo-ei.
22 Então os homens, virando os seus rostos dali, foram-se em direção a Sodoma; mas Abraão ficou ainda em pé diante do Senhor.
23 E chegando-se Abraão, disse: Destruirás também o justo com o ímpio?
24 Se porventura houver cinqüenta justos na cidade, destruirás e não pouparás o lugar por causa dos cinqüenta justos que ali estão?
25 Longe de ti que faças tal coisa, que mates o justo com o ímpio, de modo que o justo seja como o ímpio; esteja isto longe de ti. Não fará justiça o juiz de toda a terra?
26 Então disse o Senhor: Se eu achar em Sodoma cinqüenta justos dentro da cidade, pouparei o lugar todo por causa deles.
27 Tornou-lhe Abraão, dizendo: Eis que agora me atrevi a falar ao Senhor, ainda que sou pó e cinza.
28 Se porventura de cinqüenta justos faltarem cinco, destruirás toda a cidade por causa dos cinco? Respondeu ele: Não a destruirei, se eu achar ali quarenta e cinco.
29 Continuou Abraão ainda a falar-lhe, e disse: Se porventura se acharem ali quarenta? Mais uma vez assentiu: Por causa dos quarenta não o farei.
30 Disse Abraão: Ora, não se ire o Senhor, se eu ainda falar. Se porventura se acharem ali trinta? De novo assentiu: Não o farei, se achar ali trinta.
31 Tornou Abraão: Eis que outra vez me a atrevi a falar ao Senhor. Se porventura se acharem ali vinte? Respondeu-lhe: Por causa dos vinte não a destruirei.
32 Disse ainda Abraão: Ora, não se ire o Senhor, pois só mais esta vez falarei. Se porventura se acharem ali dez? Ainda assentiu o Senhor: Por causa dos dez não a destruirei.
33 E foi-se o Senhor, logo que acabou de falar com Abraão; e Abraão voltou para o seu lugar.'),
  ('33333333-3333-4333-8333-333333333333', 3, 'Gênesis 21', '1 O Senhor visitou a Sara, como tinha dito, e lhe fez como havia prometido.
2 Sara concebeu, e deu a Abraão um filho na sua velhice, ao tempo determinado, de que Deus lhe falara;
3 e, Abraão pôs no filho que lhe nascera, que Sara lhe dera, o nome de Isaque.
4 E Abraão circuncidou a seu filho Isaque, quando tinha oito dias, conforme Deus lhe ordenara.
5 Ora, Abraão tinha cem anos, quando lhe nasceu Isaque, seu filho.
6 Pelo que disse Sara: Deus preparou riso para mim; todo aquele que o ouvir, se rirá comigo.
7 E acrescentou: Quem diria a Abraão que Sara havia de amamentar filhos? no entanto lhe dei um filho na sua velhice.
8 cresceu o menino, e foi desmamado; e Abraão fez um grande banquete no dia em que Isaque foi desmamado.
9 E viu Sara que o filho de Agar, a egípcia, o qual tinha dado a Abraão, zombava.
10 Pelo que disse a Abraão: Deita fora esta serva e o seu filho; porque o filho desta serva não será herdeiro com meu filho, com Isaque.
11 Pareceu isto bem duro aos olhos de Abraão, por causa de seu filho.
12 Deus, porém, disse a Abraão: Não pareça isso duro aos teus olhos por causa do moço e por causa da tua serva; em tudo o que Sara te diz, ouve a sua voz; porque em Isaque será chamada a tua descendência.
13 Mas também do filho desta serva farei uma nação, porquanto ele é da tua linhagem.
14 Então se levantou Abraão de manhã cedo e, tomando pão e um odre de água, os deu a Agar, pondo-os sobre o ombro dela; também lhe deu o menino e despediu-a; e ela partiu e foi andando errante pelo deserto de Beer-Seba.
15 E consumida a água do odre, Agar deitou o menino debaixo de um dos arbustos,
16 e foi assentar-se em frente dele, a boa distância, como a de um tiro de arco; porque dizia: Que não veja eu morrer o menino. Assim sentada em frente dele, levantou a sua voz e chorou.
17 Mas Deus ouviu a voz do menino; e o anjo de Deus, bradando a Agar desde o céu, disse-lhe: Que tens, Agar? não temas, porque Deus ouviu a voz do menino desde o lugar onde está.
18 Ergue-te, levanta o menino e toma-o pela mão, porque dele farei uma grande nação.
19 E abriu-lhe Deus os olhos, e ela viu um poço; e foi encher de água o odre e deu de beber ao menino.
20 Deus estava com o menino, que cresceu e, morando no deserto, tornou-se flecheiro.
21 Ele habitou no deserto de Parã; e sua mãe tomou-lhe uma mulher da terra do Egito.
22 Naquele mesmo tempo Abimeleque, com Ficol, o chefe do seu exército, falou a Abraão, dizendo: Deus é contigo em tudo o que fazes;
23 agora pois, jura-me aqui por Deus que não te haverás falsamente comigo, nem com meu filho, nem com o filho do meu filho; mas segundo a beneficência que te fiz, me farás a mim, e à terra onde peregrinaste.
24 Respondeu Abraão: Eu jurarei.
25 Abraão, porém, repreendeu a Abimeleque, por causa de um poço de água, que os servos de Abimeleque haviam tomado à força.
26 Respondeu-lhe Abimeleque: Não sei quem fez isso; nem tu me fizeste saber, nem tampouco ouvi eu falar nisso, senão hoje.
27 Tomou, pois, Abraão ovelhas e bois, e os deu a Abimeleque; assim fizeram entre, si um pacto.
28 Pôs Abraão, porém, à parte sete cordeiras do rebanho.
29 E perguntou Abimeleque a Abraão: Que significam estas sete cordeiras que puseste à parte?
30 Respondeu Abraão: Estas sete cordeiras receberás da minha mão para que me sirvam de testemunho de que eu cavei este poço.
31 Pelo que chamou aquele lugar Beer-Seba, porque ali os dois juraram.
32 Assim fizeram uma pacto em Beer-Seba. Depois se levantou Abimeleque e Ficol, o chefe do seu exército, e tornaram para a terra dos filisteus.
33 Abraão plantou uma tamargueira em Beer-Seba, e invocou ali o nome do Senhor, o Deus eterno.
34 E peregrinou Abraão na terra dos filisteus muitos dias.'),
  ('33333333-3333-4333-8333-333333333333', 4, 'Gênesis 24', '1 Ora, Abraão era já velho e de idade avançada; e em tudo o Senhor o havia abençoado.
2 E disse Abraão ao seu servo, o mais antigo da casa, que tinha o governo sobre tudo o que possuía: Põe a tua mão debaixo da minha coxa,
3 para que eu te faça jurar pelo Senhor, Deus do céu e da terra, que não tomarás para meu filho mulher dentre as filhas dos cananeus, no meio dos quais eu habito;
4 mas que irás à minha terra e à minha parentela, e dali tomarás mulher para meu filho Isaque.
5 Perguntou-lhe o servo: Se porventura a mulher não quiser seguir-me a esta terra, farei, então, tornar teu filho à terra donde saíste?
6 Respondeu-lhe Abraão: Guarda-te de fazeres tornar para lá meu filho.
7 O Senhor, Deus do céu, que me tirou da casa de meu pai e da terra da minha parentela, e que me falou, e que me jurou, dizendo: à tua semente darei esta terra; ele enviará o seu anjo diante de si, para que tomes de lá mulher para meu filho.
8 Se a mulher, porém, não quiser seguir-te, serás livre deste meu juramento; somente não farás meu filho tornar para lá.
9 Então pôs o servo a sua mão debaixo da coxa de Abraão seu senhor, e jurou-lhe sobre este negócio.
10 Tomou, pois, o servo dez dos camelos do seu senhor, porquanto todos os bens de seu senhor estavam em sua mão; e, partindo, foi para a Mesopotâmia, à cidade de Naor.
11 Fez ajoelhar os camelos fora da cidade, junto ao poço de água, pela tarde, à hora em que as mulheres saíam a tirar água.
12 E disse: Ó Senhor, Deus de meu senhor Abraão, dá-me hoje, peço-te, bom êxito, e usa de benevolência para com o meu senhor Abraão.
13 Eis que eu estou em pé junto à fonte, e as filhas dos homens desta cidade vêm saindo para tirar água;
14 faze, pois, que a donzela a quem eu disser: Abaixa o teu cântaro, peço-te, para que eu beba; e ela responder: Bebe, e também darei de beber aos teus camelos; seja aquela que designaste para o teu servo Isaque. Assim conhecerei que usaste de benevolência para com o meu senhor.
15 Antes que ele acabasse de falar, eis que Rebeca, filha de Betuel, filho de Milca, mulher de Naor, irmão de Abraão, saía com o seu cântaro sobre o ombro.
16 A donzela era muito formosa à vista, virgem, a quem varão não havia conhecido; ela desceu à fonte, encheu o seu cântaro e subiu.
17 Então o servo correu-lhe ao encontro, e disse: Deixa-me beber, peço-te, um pouco de água do teu cântaro.
18 Respondeu ela: Bebe, meu senhor. Então com presteza abaixou o seu cântaro sobre a mão e deu-lhe de beber.
19 E quando acabou de lhe dar de beber, disse: Tirarei também água para os teus camelos, até que acabem de beber.
20 Também com presteza despejou o seu cântaro no bebedouro e, correndo outra vez ao poço, tirou água para todos os camelos dele.
21 E o homem a contemplava atentamente, em silêncio, para saber se o Senhor havia tornado próspera a sua jornada, ou não.
22 Depois que os camelos acabaram de beber, tomou o homem um pendente de ouro, de meio siclo de peso, e duas pulseiras para as mãos dela, do peso de dez siclos de ouro;
23 e perguntou: De quem és filha? dize-mo, peço-te. Há lugar em casa de teu pai para nós pousarmos?
24 Ela lhe respondeu: Eu sou filha de Betuel, filho de Milca, o qual ela deu a Naor.
25 Disse-lhe mais: Temos palha e forragem bastante, e lugar para pousar.
26 Então inclinou-se o homem e adorou ao Senhor;
27 e disse: Bendito seja o Senhor Deus de meu senhor Abraão, que não retirou do meu senhor a sua benevolência e a sua verdade; quanto a mim, o Senhor me guiou no caminho à casa dos irmãos de meu senhor.
28 A donzela correu, e relatou estas coisas aos da casa de sua mãe.
29 Ora, Rebeca tinha um irmão, cujo nome era Labão, o qual saiu correndo ao encontro daquele homem até a fonte;
30 porquanto tinha visto o pendente, e as pulseiras sobre as mãos de sua irmã, e ouvido as palavras de sua irmã Rebeca, que dizia: Assim me falou aquele homem; e foi ter com o homem, que estava em pé junto aos camelos ao lado da fonte.
31 E disse: Entra, bendito do Senhor; por que estás aqui fora? pois eu já preparei a casa, e lugar para os camelos.
32 Então veio o homem à casa, e desarreou os camelos; deram palha e forragem para os camelos e água para lavar os pés dele e dos homens que estavam com ele.
33 Depois puseram comida diante dele. Ele, porém, disse: Não comerei, até que tenha exposto a minha incumbência. Respondeu-lhe Labão: Fala.
34 Então disse: Eu sou o servo de Abraão.
35 O Senhor tem abençoado muito ao meu senhor, o qual se tem engrandecido; deu-lhe rebanhos e gado, prata e ouro, escravos e escravas, camelos e jumentos.
36 E Sara, a mulher do meu senhor, mesmo depois, de velha deu um filho a meu senhor; e o pai lhe deu todos os seus bens.
37 Ora, o meu senhor me fez jurar, dizendo: Não tomarás mulher para meu filho das filhas dos cananeus, em cuja terra habito;
38 irás, porém, à casa de meu pai, e à minha parentela, e tomarás mulher para meu filho.
39 Então respondi ao meu senhor: Porventura não me seguirá a mulher.
40 Ao que ele me disse: O Senhor, em cuja presença tenho andado, enviará o seu anjo contigo, e prosperará o teu caminho; e da minha parentela e da casa de meu pai tomarás mulher para meu filho;
41 então serás livre do meu juramento, quando chegares à minha parentela; e se não te derem, livre serás do meu juramento.
42 E hoje cheguei à fonte, e disse: Senhor, Deus de meu senhor Abraão, se é que agora prosperas o meu caminho, o qual venho seguindo,
43 eis que estou junto à fonte; faze, pois, que a donzela que sair para tirar água, a quem eu disser: Dá-me, peço-te, de beber um pouco de água do teu cântaro,
44 e ela me responder: Bebe tu, e também tirarei água para os teus camelos; seja a mulher que o Senhor designou para o filho de meu senhor.
45 Ora, antes que eu acabasse de falar no meu coração, eis que Rebeca saía com o seu cântaro sobre o ombro, desceu à fonte e tirou água; e eu lhe disse: Dá-me de beber, peço-te.
46 E ela, com presteza, abaixou o seu cântaro do ombro, e disse: Bebe, e também darei de beber aos teus camelos; assim bebi, e ela deu também de beber aos camelos.
47 Então lhe perguntei: De quem és filha? E ela disse: Filha de Betuel, filho de Naor, que Milca lhe deu. Então eu lhe pus o pendente no nariz e as pulseiras sobre as mãos;
48 e, inclinando-me, adorei e bendisse ao Senhor, Deus do meu senhor Abraão, que me havia conduzido pelo caminho direito para tomar para seu filho a filha do irmão do meu senhor.
49 Agora, pois, se vós haveis de usar de benevolência e de verdade para com o meu senhor, declarai-mo; e se não, também me declarai, para que eu vá ou para a direita ou para a esquerda.
50 Então responderam Labão e Betuel: Do Senhor procede este negócio; nós não podemos falar-te mal ou bem.
51 Eis que Rebeca está diante de ti, toma-a e vai-te; seja ela a mulher do filho de teu senhor, como tem dito o Senhor.
52 Quando o servo de Abraão ouviu as palavras deles, prostrou-se em terra diante do Senhor:
53 e tirou o servo jóias de prata, e jóias de ouro, e vestidos, e deu-os a Rebeca; também deu coisas preciosas a seu irmão e a sua mãe.
54 Então comeram e beberam, ele e os homens que com ele estavam, e passaram a noite. Quando se levantaram de manhã, disse o servo: Deixai-me ir a meu senhor.
55 Disseram o irmão e a mãe da donzela: Fique ela conosco alguns dias, pelo menos dez dias; e depois irá.
56 Ele, porém, lhes respondeu: Não me detenhas, visto que o Senhor me tem prosperado o caminho; deixai-me partir, para que eu volte a meu senhor.
57 Disseram-lhe: chamaremos a donzela, e perguntaremos a ela mesma.
58 Chamaram, pois, a Rebeca, e lhe perguntaram: Irás tu com este homem; Respondeu ela: Irei.
59 Então despediram a Rebeca, sua irmã, e à sua ama e ao servo de Abraão e a seus homens;
60 e abençoaram a Rebeca, e disseram-lhe: Irmã nossa, sê tu a mãe de milhares de miríades, e possua a tua descendência a porta de seus aborrecedores!
61 Assim Rebeca se levantou com as suas moças e, montando nos camelos, seguiram o homem; e o servo, tomando a Rebeca, partiu.
62 Ora, Isaque tinha vindo do caminho de Beer-Laai-Rói; pois habitava na terra do Negebe.
63 Saíra Isaque ao campo à tarde, para meditar; e levantando os olhos, viu, e eis que vinham camelos.
64 Rebeca também levantou os olhos e, vendo a Isaque, saltou do camelo
65 e perguntou ao servo: Quem é aquele homem que vem pelo campo ao nosso encontro? respondeu o servo: É meu senhor. Então ela tomou o véu e se cobriu.
66 Depois o servo contou a Isaque tudo o que fizera.
67 Isaque, pois, trouxe Rebeca para a tenda de Sara, sua mãe; tomou-a e ela lhe foi por mulher; e ele a amou. Assim Isaque foi consolado depois da morte de sua mãe.'),
  ('33333333-3333-4333-8333-333333333333', 5, 'Gênesis 29', '1 Então pôs-se Jacó a caminho e chegou à terra dos filhos do Oriente.
2 E olhando, viu ali um poço no campo, e três rebanhos de ovelhas deitadas junto dele; pois desse poço se dava de beber aos rebanhos; e havia uma grande pedra sobre a boca do poço.
3 Ajuntavam-se ali todos os rebanhos; os pastores removiam a pedra da boca do poço, davam de beber às ovelhas e tornavam a pôr a pedra no seu lugar sobre a boca do poço.
4 Perguntou-lhes Jacó: Meus irmãos, donde sois? Responderam eles: Somos de Harã.
5 Perguntou-lhes mais: Conheceis a Labão, filho de Naor? Responderam: Conhecemos.
6 Perguntou-lhes ainda: vai ele bem? Responderam: Vai bem; e eis ali Raquel, sua filha, que vem chegando com as ovelhas.
7 Disse ele: Eis que ainda vai alto o dia; não é hora de se ajuntar o gado; dai de beber às ovelhas, e ide apascentá-las.
8 Responderam: Não podemos, até que todos os rebanhos se ajuntem, e seja removida a pedra da boca do poço; assim é que damos de beber às ovelhas.
9 Enquanto Jacó ainda lhes falava, chegou Raquel com as ovelhas de seu pai; porquanto era ela quem as apascentava.
10 Quando Jacó viu a Raquel, filha de Labão, irmão de sua mãe, e as ovelhas de Labão, irmão de sua mãe, chegou-se, revolveu a pedra da boca do poço e deu de beber às ovelhas de Labão, irmão de sua mãe.
11 Então Jacó beijou a Raquel e, levantando a voz, chorou.
12 E Jacó anunciou a Raquel que ele era irmão de seu pai, e que era filho de Rebeca. Raquel, pois foi correndo para anunciá-lo a seu pai.
13 Quando Labão ouviu essas novas de Jacó, filho de sua irmã, correu-lhe ao encontro, abraçou-o, beijou-o e o levou à sua casa. E Jacó relatou a Labão todas essas coisas.
14 Disse-lhe Labão: Verdadeiramente tu és meu osso e minha carne. E Jacó ficou com ele um mês inteiro.
15 Depois perguntou Labão a Jacó: Por seres meu irmão hás de servir-me de graça? Declara-me, qual será o teu salário?
16 Ora, Labão tinha duas filhas; o nome da mais velha era Lia e o da mais moça Raquel.
17 Lia tinha os olhos enfermos, enquanto que Raquel era formosa de porte e de semblante.
18 Jacó, porquanto amava a Raquel, disse: Sete anos te servirei para ter a Raquel, tua filha mais moça.
19 Respondeu Labão: Melhor é que eu a dê a ti do que a outro; fica comigo.
20 Assim serviu Jacó sete anos por causa de Raquel; e estes lhe pareciam como poucos dias, pelo muito que a amava.
21 Então Jacó disse a Labão: Dá-me minha mulher, porque o tempo já está cumprido; para que eu a tome por mulher.
22 Reuniu, pois, Labão todos os homens do lugar, e fez um banquete.
23 À tarde tomou a Lia, sua filha e a trouxe a Jacó, que esteve com ela.
24 E Labão deu sua serva Zilpa por serva a Lia, sua filha.
25 Quando amanheceu, eis que era Lia; pelo que perguntou Jacó a Labão: Que é isto que me fizeste? Porventura não te servi em troca de Raquel? Por que, então, me enganaste?
26 Respondeu Labão: Não se faz assim em nossa terra; não se dá a menor antes da primogênita.
27 Cumpre a semana desta; então te daremos também a outra, pelo trabalho de outros sete anos que ainda me servirás.
28 Assim fez Jacó, e cumpriu a semana de Lia; depois Labão lhe deu por mulher sua filha Raquel.
29 E Labão deu sua serva Bila por serva a Raquel, sua filha.
30 Então Jacó esteve também com Raquel; e amou a Raquel muito mais do que a Lia; e serviu com Labão ainda outros sete anos.
31 Viu, pois, o Senhor que Lia era desprezada e tornou-lhe fecunda a madre; Raquel, porém, era estéril.
32 E Lia concebeu e deu à luz um filho, a quem chamou Rúben; pois disse: Porque o Senhor atendeu à minha aflição; agora me amará meu marido.
33 Concebeu outra vez, e deu à luz um filho; e disse: Porquanto o Senhor ouviu que eu era desprezada, deu-me também este. E lhe chamou Simeão.
34 Concebeu ainda outra vez e deu à luz um filho e disse: Agora esta vez se unirá meu marido a mim, porque três filhos lhe tenho dado. Portanto lhe chamou Levi.
35 De novo concebeu e deu à luz um filho; e disse: Esta vez louvarei ao Senhor. Por isso lhe chamou Judá. E cessou de ter filhos.'),
('33333333-3333-4333-8333-333333333333', 6, 'Êxodo 15', '1 Então cantaram Moisés e os filhos de Israel este cântico ao Senhor, dizendo: Cantarei ao Senhor, porque gloriosamente triunfou; lançou no mar o cavalo e o seu cavaleiro.
2 O Senhor é a minha força, e o meu cântico; ele se tem tornado a minha salvação; é ele o meu Deus, portanto o louvarei; é o Deus de meu pai, por isso o exaltarei.
3 O Senhor é homem de guerra; Jeová é o seu nome.
4 Lançou no mar os carros de Faraó e o seu exército; os seus escolhidos capitães foram submersos no Mar Vermelho.
5 Os abismos os cobriram; desceram às profundezas como pedra.
6 A tua destra, ó Senhor, é gloriosa em poder; a tua destra, ó Senhor, destroça o inimigo.
7 Na grandeza da tua excelência derrubas os que se levantam contra ti; envias o teu furor, que os devora como restolho.
8 Ao sopro dos teus narizes amontoaram-se as águas, as correntes pararam como montão; os abismos coalharam-se no coração do mar.
9 O inimigo dizia: Perseguirei, alcançarei, repartirei os despojos; deles se satisfará o meu desejo; arrancarei a minha espada, a minha mão os destruirá.
10 Sopraste com o teu vento, e o mar os cobriu; afundaram-se como chumbo em grandes aguas.
11 Quem entre os deuses é como tu, ó Senhor? e quem é como tu poderoso em santidade, admirável em louvores, operando maravilhas?
12 Estendeste a mão direita, e a terra os tragou.
13 Na tua beneficência guiaste o povo que remiste; na tua força o conduziste à tua santa habitação.
14 Os povos ouviram e estremeceram; dores apoderaram-se dos habitantes da Filístia.
15 Então os príncipes de Edom se pasmaram; dos poderosos de Moabe apoderou-se um tremor; derreteram-se todos os habitantes de Canaã.
16 Sobre eles caiu medo, e pavor; pela grandeza do teu braço emudeceram como uma pedra, até que o teu povo passasse, ó Senhor, até que passasse este povo que adquiriste.
17 Tu os introduzirás, e os plantarás no monte da tua herança, no lugar que tu, ó Senhor, aparelhaste para a tua habitação, no santuário, ó Senhor, que as tuas mãos estabeleceram.
18 O Senhor reinará eterna e perpetuamente.
19 Porque os cavalos de Faraó, com os seus carros e com os seus cavaleiros, entraram no mar, e o Senhor fez tornar as águas do mar sobre eles, mas os filhos de Israel passaram em seco pelo meio do mar.
20 Então Miriã, a profetisa, irmã de Arão, tomou na mão um tamboril, e todas as mulheres saíram atrás dela com tamboris, e com danças.
21 E Miriã lhes respondia: Cantai ao Senhor, porque gloriosamente triunfou; lançou no mar o cavalo com o seu cavaleiro.
22 Depois Moisés fez partir a Israel do Mar Vermelho, e saíram para o deserto de Sur; caminharam três dias no deserto, e não acharam água.
23 E chegaram a Mara, mas não podiam beber das suas águas, porque eram amargas; por isso chamou-se o lugar Mara.
24 E o povo murmurou contra Moisés, dizendo: Que havemos de beber?
25 Então clamou Moisés ao Senhor, e o Senhor mostrou-lhe uma árvore, e Moisés lançou-a nas águas, as quais se tornaram doces. Ali Deus lhes deu um estatuto e uma ordenança, e ali os provou,
26 dizendo: Se ouvires atentamente a voz do Senhor teu Deus, e fizeres o que é reto diante de seus olhos, e inclinares os ouvidos aos seus mandamentos, e guardares todos os seus estatutos, sobre ti não enviarei nenhuma das enfermidades que enviei sobre os egípcios; porque eu sou o Senhor que te sara.
27 Então vieram a Elim, onde havia doze fontes de água e setenta palmeiras; e ali, junto das águas, acamparam.'),
  ('33333333-3333-4333-8333-333333333333', 7, 'Josué 2', '1 De Sitim Josué, filho de Num, enviou secretamente dois homens como espias, dizendo-lhes: Ide reconhecer a terra, particularmente a Jericó. Foram pois, e entraram na casa duma prostituta, que se chamava Raabe, e pousaram ali.
2 Então deu-se notícia ao rei de Jericó, dizendo: Eis que esta noite vieram aqui uns homens dos filhos de Israel, para espiar a terra.
3 Pelo que o rei de Jericó mandou dizer a Raabe: Faze sair os homens que vieram a ti e entraram na tua casa, porque vieram espiar toda a terra.
4 Mas aquela mulher, tomando os dois homens, os escondeu, e disse: é verdade que os homens vieram a mim, porém eu não sabia donde eram;
5 e aconteceu que, havendo-se de fechar a porta, sendo já escuro, aqueles homens saíram. Não sei para onde foram; ide após eles depressa, porque os alcançareis.
6 Ela, porém, os tinha feito subir ao eirado, e os tinha escondido entre as canas do linho que pusera em ordem sobre o eirado.
7 Assim foram esses homens após eles pelo caminho do Jordão, até os vaus; e, logo que saíram, fechou-se a porta.
8 E, antes que os espias se deitassem, ela subiu ao eirado a ter com eles,
9 e disse-lhes: Bem sei que o Senhor vos deu esta terra, e que o pavor de vós caiu sobre nós, e que todos os moradores da terra se derretem diante de vós.
10 Porque temos ouvido que o Senhor secou as águas do Mar Vermelho diante de vós, quando saístes do Egito, e também o que fizestes aos dois reis dos amorreus, Siom e Ogue, que estavam além de Jordão, os quais destruístes totalmente.
11 Quando ouvimos isso, derreteram-se os nossos corações, e em ninguém mais há ânimo algum, por causa da vossa presença; porque o Senhor vosso Deus é Deus em cima no céu e embaixo na terra.
12 Agora pois, peço-vos, jurai-me pelo Senhor que, como usei de bondade para convosco, vós também usareis de bondade para com a casa e meu pai; e dai-me um sinal seguro
13 de que conservareis em vida meu pai e minha mãe, como também meus irmãos e minhas irmãs, com todos os que lhes pertencem, e de que livrareis da morte as nossas vidas.
14 Então eles lhe responderam: A nossa vida responderá pela vossa, se não denunciardes este nosso negócio; e, quando o Senhor nos entregar esta terra, usaremos para contigo de bondade e de fidelidade.
15 Ela então os fez descer por uma corda pela janela, porquanto a sua casa estava sobre o muro da cidade, de sorte que morava sobre o muro;
16 e disse-lhes: Ide-vos ao monte, para que não vos encontrem os perseguidores, e escondei-vos lá três dias, até que eles voltem; depois podereis tomar o vosso caminho.
17 Disseram-lhe os homens: Nós seremos inocentes no tocante a este juramento que nos fizeste jurar.
18 Eis que, quando nós entrarmos na terra, atarás este cordão de fio de escarlata à janela pela qual nos fizeste descer; e recolherás em casa contigo teu pai, tua mãe, teus irmãos e toda a família de teu pai.
19 Qualquer que sair fora das portas da tua casa, o seu sangue cairá sobre a sua cabeça, e nós seremos inocentes; mas qualquer que estiver contigo em casa, o seu sangue cairá sobre a nossa cabeça se nele se puser mão.
20 Se, porém, tu denunciares este nosso negócio, seremos desobrigados do juramento que nos fizeste jurar.
21 Ao que ela disse: Conforme as vossas palavras, assim seja. Então os despediu, e eles se foram; e ela atou o cordão de escarlata à janela.
22 Foram-se, pois, e chegaram ao monte, onde ficaram três dias, até que voltaram os perseguidores; pois estes os buscaram por todo o caminho, porém, não os acharam.
23 Então os dois homens, tornando a descer do monte, passaram o rio, chegaram a Josué, filho de Num, e lhe contaram tudo quanto lhes acontecera.
24 E disseram a Josué: Certamente o Senhor nos tem entregue nas mãos toda esta terra, pois todos os moradores se derretem diante de nós.'),
  ('33333333-3333-4333-8333-333333333333', 8, 'Juízes 4', '1 Mas os filhos de Israel tornaram a fazer o que era mau aos olhos do Senhor, depois da morte de Eúde.
2 E o Senhor os vendeu na mão de Jabim, rei de Canaã, que reinava em Hazor; o chefe do seu exército era Sísera, o qual habitava em Harosete dos Gentios.
3 Então os filhos de Israel clamaram ao Senhor, porquanto Jabim tinha novecentos carros de ferro, e por vinte anos oprimia cruelmente os filhos de Israel.
4 Ora, Débora, profetisa, mulher de Lapidote, julgava a Israel naquele tempo.
5 Ela se assentava debaixo da palmeira de Débora, entre Ramá e Betel, na região montanhosa de Efraim; e os filhos de Israel subiam a ter com ela para julgamento.
6 Mandou ela chamar a Baraque, filho de Abinoão, de Quedes-Naftali, e disse-lhe: Porventura o Senhor Deus de Israel não te ordena, dizendo: Vai, e atrai gente ao monte Tabor, e toma contigo dez mil homens dos filhos de Naftali e dos filhos de Zebulom;
7 e atrairei a ti, para o ribeiro de Quisom, Sísera, chefe do exército de Jabim; juntamente com os seus carros e com as suas tropas, e to entregarei na mão?
8 Disse-lhe Baraque: Se fores comigo, irei; porém se não fores, não irei.
9 Respondeu ela: Certamente irei contigo; porém não será tua a honra desta expedição, pois é mão de uma mulher o Senhor venderá a Sísera. Levantou-se, pois, Débora, e foi com Baraque a Quedes.
10 Então Baraque convocou a Zebulom e a Naftali em Quedes, e subiram dez mil homens após ele; também Débora subiu com ele.
11 Ora, Heber, um queneu, se tinha apartado dos queneus, dos filhos de Hobabe, sogro de Moisés, e tinha estendido as suas tendas até o carvalho de Zaananim, que está junto a Quedes.
12 Anunciaram a Sísera que Baraque, filho de Abinoão, tinha subido ao monte Tabor.
13 Sísera, pois, ajuntou todos os seus carros, novecentos carros de ferro, e todo o povo que estava com ele, desde Harosete dos Gentios até o ribeiro de Quisom.
14 Então disse Débora a Baraque: Levanta-te, porque este é o dia em que o Senhor entregou Sísera na tua mão; porventura o Senhor não saiu adiante de ti? Baraque, pois, desceu do monte Tabor, e dez mil homens após ele.
15 E o Senhor desbaratou a Sísera, com todos os seus carros e todo o seu exército, ao fio da espada, diante de Baraque; e Sísera, descendo do seu carro, fugiu a pé.
16 Mas Baraque perseguiu os carros e o exército, até Harosete dos Gentios; e todo o exército de Sísera caiu ao fio da espada; não restou um só homem.
17 Entretanto Sísera fugiu a pé para a tenda de Jael, mulher de Heber, o queneu, porquanto havia paz entre Jabim, rei de Hazor, e a casa de Heber, o queneu.
18 Saindo Jael ao encontro de Sísera, disse-lhe: Entra, senhor meu, entra aqui; não temas. Ele entrou na sua tenda; e ela o cobriu com uma coberta.
19 Então ele lhe disse: Peço-te que me dês a beber um pouco d''água, porque tenho sede. Então ela abriu um odre de leite, e deu-lhe de beber, e o cobriu.
20 Disse-lhe ele mais: Põe-te à porta da tenda; e se alguém vier e te perguntar: Está aqui algum homem? responderás: Não.
21 Então Jael, mulher de Heber, tomou uma estaca da tenda e, levando um martelo, chegou-se de mansinho a ele e lhe cravou a estaca na fonte, de sorte que penetrou na terra; pois ele estava num profundo sono e mui cansado. E assim morreu.
22 E eis que, seguindo Baraque a Sísera, Jael lhe saiu ao encontro e disse-lhe: Vem, e mostrar-te-ei o homem a quem procuras. Entrou ele na tenda; e eis que Sísera jazia morto, com a estaca na fonte.
23 Assim Deus naquele dia humilhou a Jabim, rei de Canaã, diante dos filhos de Israel.
24 E a mão dos filhos de Israel prevalecia cada vez mais contra Jabim, rei de Canaã, até que o destruíram.'),
  ('33333333-3333-4333-8333-333333333333', 9, 'Rute 1', '1 Nos dias em que os juízes governavam, houve uma fome na terra; pelo que um homem de Belém de Judá saiu a peregrinar no país de Moabe, ele, sua mulher, e seus dois filhos.
2 Chamava-se este homem Elimeleque, e sua mulher Noêmi, e seus dois filhos se chamavam Malom e Quiliom; eram efrateus, de Belém de Judá. Tendo entrado no país de Moabe, ficaram ali.
3 E morreu Elimeleque, marido de Noêmi; e ficou ela com os seus dois filhos,
4 os quais se casaram com mulheres moabitas; uma destas se chamava Orfa, e a outra Rute; e moraram ali quase dez anos.
5 E morreram também os dois, Malom e Quiliom, ficando assim a mulher desamparada de seus dois filhos e de seu marido.
6 Então se levantou ela com as suas noras, para voltar do país de Moabe, porquanto nessa terra tinha ouvido que o Senhor havia visitado o seu povo, dando-lhe pão.
7 Pelo que saiu do lugar onde estava, e com ela as duas noras. Indo elas caminhando para voltarem para a terra de Judá,
8 disse Noêmi às suas noras: Ide, voltai, cada uma para a casa de sua mãe; e o Senhor use convosco de benevolência, como vós o fizestes com os falecidos e comigo.
9 O Senhor vos dê que acheis descanso cada uma em casa de seu marido. Quando as beijou, porém, levantaram a vóz e choraram.
10 E disseram-lhe: Certamente voltaremos contigo para o teu povo.
11 Noêmi, porém, respondeu: Voltai, minhas filhas; porque ireis comigo? Tenho eu ainda filhos no meu ventre, para que vos viessem a ser maridos?
12 Voltai, filhas minhas; ide-vos, porque já sou velha demais para me casar. Ainda quando eu dissesse: Tenho esperança; ainda que esta noite tivesse marido e ainda viesse a ter filhos.
13 esperá-los-íeis até que viessem a ser grandes? deter-vos-íeis por eles, sem tomardes marido? Não, filhas minhas, porque mais amargo me é a mim do que a vós mesmas; porquanto a mão do Senhor se descarregou contra mim.
14 Então levantaram a voz, e tornaram a chorar; e Orfa beijou a sua sogra, porém Rute se apegou a ela.
15 Pelo que disse Noêmi: Eis que tua concunhada voltou para o seu povo e para os seus deuses; volta também tu após a tua concunhada.
16 Respondeu, porém, Rute: Não me insistes a que te abandone e deixe de seguir-te. Porque aonde quer que tu fores, irei eu; e onde quer que pousares, ali pousarei eu; o teu povo será o meu povo, o teu Deus será o meu Deus.
17 Onde quer que morreres, morrerei eu, e ali serei sepultada. Assim me faça o Senhor, e outro tanto, se outra coisa que não seja a morte me separar de ti.
18 Vendo Noêmi que de todo estava resolvida a ir com ela, deixou de lhe falar nisso.
19 Assim, pois, foram-se ambas, até que chegaram a Belém. E sucedeu que, ao entrarem em Belém, toda a cidade se comoveu por causa delas, e as mulheres perguntavam: É esta, porventura, Noêmi?
20 Ela, porém, lhes respondeu: Não me chameis Noêmi; chamai-me Mara, porque o Todo-Poderoso me encheu de amargura.
21 Cheia parti, porém vazia o Senhor me fez tornar. Por que, pois, me chamais Noêmi, visto que o Senhor testemunhou contra mim, e o Todo-Poderoso me afligiu?
22 Assim Noêmi voltou, e com ela Rute, a moabita, sua nora, que veio do país de Moabe; e chegaram a Belém no principio da sega da cevada.'),
  ('33333333-3333-4333-8333-333333333333', 10, '1 Samuel 1', '1 Houve um homem de Ramataim-Zofim, da região montanhosa de Efraim, cujo nome era Elcana, filho de Jeroão, filho de Eliú, filho de Toú, filho de Zufe, efraimita.
2 Tinha ele duas mulheres: uma se chamava Ana, e a outra Penina. Penina tinha filhos, porém Ana não os tinha.
3 De ano em ano este homem subia da sua cidade para adorar e sacrificar ao Senhor dos exércitos em Siló. Assistiam ali os sacerdotes do Senhor, Hofni e Finéias, os dois filhos de Eli.
4 No dia em que Elcana sacrificava, costumava dar quinhões a Penina, sua mulher, e a todos os seus filhos e filhas;
5 Porém a Ana dava uma porção dobrada; porque amava a Ana, embora o Senhor lhe tivesse cerrado a madre.
6 Ora, a sua rival muito a provocava para irritá-la, porque o Senhor lhe havia cerrado a madre.
7 E assim sucedia de ano em ano que, ao subirem à casa do Senhor, Penina provocava a Ana; pelo que esta chorava e não comia.
8 Então Elcana, seu marido, lhe perguntou: Ana, por que choras? e porque não comes? e por que está triste o teu coração? Não te sou eu melhor de que dez filhos?
9 Então Ana se levantou, depois que comeram e beberam em Siló; e Eli, sacerdote, estava sentado, numa cadeira, junto a um pilar do templo do Senhor.
10 Ela, pois, com amargura de alma, orou ao Senhor, e chorou muito,
11 e fez um voto, dizendo: ó Senhor dos exércitos! se deveras atentares para a aflição da tua serva, e de mim te lembrares, e da tua serva não te esqueceres, mas lhe deres um filho varão, ao Senhor o darei por todos os dias da sua vida, e pela sua cabeça não passará navalha.
12 Continuando ela a orar perante o Senhor, Eli observou a sua boca;
13 porquanto Ana falava no seu coração; só se moviam os seus lábios, e não se ouvia a sua voz; pelo que Eli a teve por embriagada,
14 e lhe disse: Até quando estarás tu embriagada? Aparta de ti o teu vinho.
15 Mas Ana respondeu: Não, Senhor meu, eu sou uma mulher atribulada de espírito; não bebi vinho nem bebida forte, porém derramei a minha alma perante o Senhor.
16 Não tenhas, pois, a tua serva por filha de Belial; porque da multidão dos meus cuidados e do meu desgosto tenho falado até agora.
17 Então lhe respondeu Eli: Vai-te em paz; e o Deus de Israel te conceda a petição que lhe fizeste.
18 Ao que disse ela: Ache a tua serva graça aos teus olhos. Assim a mulher se foi o seu caminho, e comeu, e já não era triste o seu semblante.
19 Depois, levantando-se de madrugada, adoraram perante o Senhor e, voltando, foram a sua casa em Ramá. Elcana conheceu a Ana, sua mulher, e o Senhor se lembrou dela.
20 De modo que Ana concebeu e, no tempo devido, teve um filho, ao qual chamou Samuel; porque, dizia ela, o tenho pedido ao Senhor.
21 Subiu, pois aquele homem, Elcana, com toda a sua casa, para oferecer ao Senhor o sacrifício anual e cumprir o seu voto.
22 Ana, porém, não subiu, pois disse a seu marido: Quando o menino for desmamado, então o levarei, para que apareça perante o Senhor, e lá fique para sempre.
23 E Elcana, seu marido, lhe disse: faze o que bem te parecer; fica até que o desmames; tão-somente confirme o Senhor a sua palavra. Assim ficou a mulher, e amamentou seu filho, até que o desmamou.
24 Depois de o ter desmamado, ela o tomou consigo, com um touro de três anos, uma efa de farinha e um odre de vinho, e o levou à casa do Senhor, em Siló; e era o menino ainda muito criança.
25 Então degolaram o touro, e trouxeram o menino a Eli;
26 e disse ela: Ah, meu Senhor! tão certamente como vive a tua alma, meu Senhor, eu sou aquela mulher que aqui esteve contigo, orando ao Senhor.
27 Por este menino orava eu, e o Senhor atendeu a petição que eu lhe fiz.
28 Por isso eu também o entreguei ao Senhor; por todos os dias que viver, ao Senhor está entregue. E adoraram ali ao Senhor.'),
  ('33333333-3333-4333-8333-333333333333', 11, '1 Samuel 25', '1 Ora, faleceu Samuel; e todo o Israel se ajuntou e o pranteou; e o sepultaram na sua casa, em Ramá. E Davi se levantou e desceu ao deserto de Parã.
2 Havia um homem em Maom que tinha as suas possessões no Carmelo. Este homem era muito rico, pois tinha três mil ovelhas e mil Cabras e estava tosquiando as suas ovelhas no Carmelo.
3 Chamava-se o homem Nabal, e sua mulher chamava-se Abigail; era a mulher sensata e formosa; o homem porém, era duro, e maligno nas suas ações; e era da casa de Calebe.
4 Ouviu Davi no deserto que Nabal tosquiava as suas ovelhas,
5 e enviou-lhe dez mancebos, dizendo-lhes: Subi ao Carmelo, ide a Nabal e perguntai-lhe, em meu nome, como está.
6 Assim lhe direis: Paz seja contigo, e com a tua casa, e com tudo o que tens.
7 Agora, pois, tenho ouvido que tens tosquiadores. Ora, os pastores que tens acabam de estar conosco; agravo nenhum lhes fizemos, nem lhes desapareceu coisa alguma por todo o tempo que estiveram no Carmelo.
8 Pergunta-o aos teus mancebos, e eles to dirão. Que achem, portanto, os teus servos graça aos teus olhos, porque viemos em boa ocasião. Dá, pois, a teus servos e a Davi, teu filho, o que achares à mão.
9 Chegando, pois, os mancebos de Davi, falaram a Nabal todas aquelas palavras em nome de Davi, e se calaram.
10 Ao que Nabal respondeu aos servos de Davi, e disse: Quem é Davi, e quem o filho de Jessé? Muitos servos há que hoje fogem ao seu senhor.
11 Tomaria eu, pois, o meu pão, e a minha água, e a carne das minhas reses que degolei para os meus tosquiadores, e os daria a homens que não sei donde vêm?
12 Então os mancebos de Davi se puseram a caminho e, voltando, vieram anunciar-lhe todas estas palavras.
13 Pelo que disse Davi aos seus homens: Cada um cinja a sua espada. E cada um cingiu a sua espada, e Davi também cingiu a sua, e subiram após Davi cerca de quatrocentos homens, e duzentos ficaram com a bagagem.
14 um dentre os mancebos, porém, o anunciou a Abigail, mulher de Nabal, dizendo: Eis que Davi enviou mensageiros desde o deserto a saudar o nosso amo; e ele os destratou.
15 Todavia, aqueles homens têm-nos sido muito bons, e nunca fomos agravados deles, e nada nos desapareceu por todo o tempo em que convivemos com eles quando estávamos no campo.
16 De muro em redor nos serviram, assim de dia como de noite, todos os dias que andamos com eles apascentando as ovelhas.
17 Considera, pois, agora e vê o que hás de fazer, porque o mal já está de todo determinado contra o nosso amo e contra toda a sua casa; e ele é tal filho de Belial, que não há quem lhe possa falar.
18 Então Abigail se apressou, e tomou duzentos pães, dois odres de vinho, cinco ovelhas assadas, cinco medidas de trigo tostado, cem cachos de passas, e duzentas pastas de figos secos, e os pôs sobre jumentos.
19 E disse aos seus mancebos: Ide adiante de mim; eis que vos seguirei de perto. Porém não o declarou a Nabal, seu marido.
20 E quando ela, montada num jumento, ia descendo pelo encoberto do monte, eis que Davi e os seus homens lhe vinham ao encontro; e ela se encontrou com eles.
21 Ora, Davi tinha dito: Na verdade que em vão tenho guardado tudo quanto este tem no deserto, de sorte que nada lhe faltou de tudo quanto lhe pertencia; e ele me pagou mal por bem.
22 Assim faça Deus a Davi, e outro tanto, se eu deixar até o amanhecer, de tudo o que pertence a Nabal, um só varão.
23 Vendo, pois, Abigail a Davi, apressou-se, desceu do jumento e prostrou-se sobre o seu rosto diante de Davi, inclinando-se à terra,
24 e, prostrada a seus pés, lhe disse: Ah, senhor meu, minha seja a iniqüidade! Deixa a tua serva falar aos teus ouvidos, e ouve as palavras da tua serva.
25 Rogo-te, meu senhor, que não faças caso deste homem de Belial, a saber, Nabal; porque tal é ele qual é o seu nome. Nabal é o seu nome, e a loucura está com ele; mas eu, tua serva, não vi os mancebos de meu senhor, que enviaste.
26 Agora, pois, meu senhor, vive o Senhor, e vive a tua alma, porquanto o Senhor te impediu de derramares sangue, e de te vingares com a tua própria mão, sejam agora como Nabal os teus inimigos e os que procuram fazer o mal contra o meu senhor.
27 Aceita agora este presente que a tua serva trouxe a meu senhor; seja ele dado aos mancebos que seguem ao meu senhor.
28 Perdoa, pois, a transgressão da tua serva; porque certamente fará o Senhor casa firme a meu senhor, pois meu senhor guerreia as guerras do Senhor; e não se achará mal em ti por todos os teus dias.
29 Se alguém se levantar para te perseguir, e para buscar a tua vida, então a vida de meu senhor será atada no feixe dos que vivem com o Senhor teu Deus; porém a vida de teus inimigos ele arrojará ao longe, como do côncavo de uma funda.
30 Quando o Senhor tiver feito para com o meu senhor conforme todo o bem que já tem dito de ti, e te houver estabelecido por príncipe sobre Israel,
31 então, meu senhor, não terás no coração esta tristeza nem este remorso de teres derramado sangue sem causa, ou de haver-se vingado o meu senhor a si mesmo. E quando o Senhor fizer bem a meu senhor, lembra-te então da tua serva.
32 Ao que Davi disse a Abigail: Bendito seja o Senhor Deus de Israel, que hoje te enviou ao meu encontro!
33 E bendito seja o teu conselho, e bendita sejas tu, que hoje me impediste de derramar sangue, e de vingar-me pela minha própria mão!
34 Pois, na verdade, vive o Senhor Deus de Israel que me impediu de te fazer mal, que se tu não te apressaras e não me vieras ao encontro, não teria ficado a Nabal até a luz da manhã nem mesmo um menino.
35 Então Davi aceitou da mão dela o que lhe tinha trazido, e lhe disse: Sobe em paz à tua casa; vê que dei ouvidos à tua voz, e aceitei a tua face.
36 Ora, quando Abigail voltou para Nabal, eis que ele fazia em sua casa um banquete, como banquete de rei; e o coração de Nabal estava alegre, pois ele estava muito embriagado; pelo que ela não lhe deu a entender nada daquilo, nem pouco nem muito, até a luz da manhã.
37 Sucedeu, pois, que, pela manhã, estando Nabal já livre do vinho, sua mulher lhe contou essas coisas; de modo que o seu coração desfaleceu, e ele ficou como uma pedra.
38 Passados uns dez dias, o Senhor feriu a Nabal, e ele morreu.
39 Quando Davi ouviu que Nabal morrera, disse: Bendito seja o Senhor, que me vingou da afronta que recebi de Nabal, e deteve do mal a seu servo, fazendo cair a maldade de Nabal sobre a sua cabeça. Depois mandou Davi falar a Abigail, para tomá-la por mulher.
40 Vindo, pois, os servos de Davi a Abigail, no Carmelo, lhe falaram, dizendo: Davi nos mandou a ti, para te tomarmos por sua mulher.
41 Ao que ela se levantou, e se inclinou com o rosto em terra, e disse: Eis que a tua serva servirá de criada para lavar os pés dos servos de meu senhor.
42 Então Abigail se apressou e, levantando-se, montou num jumento, e levando as cinco moças que lhe assistiam, seguiu os mensageiros de Davi, que a recebeu por mulher.
43 Davi tomou também a Ainoã de Jizreel; e ambas foram suas mulheres.
44 Pois Saul tinha dado sua filha Mical, mulher de Davi, a Palti, filho de Laís, o qual era de Galim.'),
  ('33333333-3333-4333-8333-333333333333', 12, 'Ester 4', '1 Quando Mardoqueu soube tudo quanto se havia passado, rasgou as suas vestes, vestiu-se de saco e de cinza, e saiu pelo meio da cidade, clamando com grande e amargo clamor;
2 e chegou até diante da porta do rei, pois ninguém vestido de saco podia entrar pelas portas do rei.
3 Em todas as províncias aonde chegava a ordem do rei, e o seu decreto, havia entre os judeus grande pranto, com jejum, e choro, e lamentação; e muitos se deitavam em saco e em cinza.
4 Quando vieram as moças de Ester e os eunucos lho fizeram saber, a rainha muito se entristeceu; e enviou roupa para Mardoqueu, a fim de que, despindo-lhe o saco, lha vestissem; ele, porém, não a aceitou.
5 Então Ester mandou chamar Hataque, um dos eunucos do rei, que este havia designado para a servir, e o mandou ir ter com Mardoqueu para saber que era aquilo, e por que era.
6 Hataque, pois, saiu a ter com Mardoqueu à praça da cidade, diante da porta do rei;
7 e Mardoqueu lhe fez saber tudo quanto lhe tinha sucedido, como também a soma exata do dinheiro que Hamã prometera pagar ao tesouro do rei pela destruição dos judeus.
8 Também lhe deu a cópia do decreto escrito que se publicara em Susã para os destruir, para que a mostrasse a Ester, e lha explicasse, ordenando-lhe que fosse ter com o rei, e lhe pedisse misericórdia e lhe fizesse súplica ao seu povo.
9 Veio, pois, Hataque, e referiu a Ester as palavras de Mardoqueu.
10 Então falou Ester a Hataque, mandando-o dizer a Mardoqueu:
11 Todos os servos do rei, e o povo das províncias do rei, bem sabem que, para todo homem ou mulher que entrar à presença do rei no pátio interior sem ser chamado, não há senão uma sentença, a de morte, a menos que o rei estenda para ele o cetro de ouro, para que viva; mas eu já há trinta dias não sou chamada para entrar a ter com o rei.
12 E referiram a Mardoqueu as palavras de Ester.
13 Então Mardoqueu mandou que respondessem a Ester: Não imagines que, por estares no palácio do rei, terás mais sorte para escapar do que todos os outros judeus.
14 Pois, se de todo te calares agora, de outra parte se levantarão socorro e livramento para os judeus, mas tu e a casa de teu pai perecereis; e quem sabe se não foi para tal tempo como este que chegaste ao reino?
15 De novo Ester mandou-os responder a Mardoqueu:
16 Vai, ajunta todos os judeus que se acham em Susã, e jejuai por mim, e não comais nem bebais por três dias, nem de noite nem de dia; e eu e as minhas moças também assim jejuaremos. Depois irei ter com o rei, ainda que isso não é segundo a lei; e se eu perecer, pereci.
17 Então Mardoqueu foi e fez conforme tudo quanto Ester lhe ordenara.'),
  ('33333333-3333-4333-8333-333333333333', 13, 'Lucas 1', '1 Visto que muitos têm empreendido fazer uma narração coordenada dos fatos que entre nós se realizaram,
2 segundo no-los transmitiram os que desde o princípio foram testemunhas oculares e ministros da palavra,
3 também eu, depois de haver investigado tudo cuidadosamente desde o começo, pareceu-me bem, ó excelentíssimo Teófilo, escrever-te uma narração em ordem.
4 para que conheças plenamente a verdade das coisas em que foste instruído.
5 Houve nos dias do Rei Herodes, rei da Judéia, um sacerdote chamado Zacarias, da turma de Abias; e sua mulher era descendente de Arão, e chamava-se Isabel.
6 Ambos eram justos diante de Deus, andando irrepreensíveis em todos os mandamentos e preceitos do Senhor.
7 Mas não tinham filhos, porque Isabel era estéril, e ambos avançados em idade.
8 Ora, estando ele a exercer as funções sacerdotais perante Deus, na ordem da sua turma,
9 segundo o costume do sacerdócio, coube-lhe por sorte entrar no santuário do Senhor, para oferecer o incenso;
10 e toda a multidão do povo orava da parte de fora, à hora do incenso.
11 Apareceu-lhe, então, um anjo do Senhor, em pé à direita do altar do incenso.
12 E Zacarias, vendo-o, ficou turbado, e o temor o assaltou.
13 Mas o anjo lhe disse: Não temais, Zacarias; porque a tua oração foi ouvida, e Isabel, tua mulher, te dará à luz um filho, e lhe porás o nome de João;
14 e terás alegria e regozijo, e muitos se alegrarão com o seu nascimento;
15 porque ele será grande diante do Senhor; não beberá vinho, nem bebida forte; e será cheio do Espírito Santo já desde o ventre de sua mãe;
16 converterá muitos dos filhos de Israel ao Senhor seu Deus;
17 irá adiante dele no espírito e poder de Elias, para converter os corações dos pais aos filhos, e os rebeldes à prudência dos justos, a fim de preparar para o Senhor um povo apercebido.
18 Disse então Zacarias ao anjo: Como terei certeza disso? pois eu sou velho, e minha mulher também está avançada em idade.
19 Ao que lhe respondeu o anjo: Eu sou Gabriel, que assisto diante de Deus, e fui enviado para te falar e te dar estas boas novas;
20 e eis que ficarás mudo, e não poderás falar até o dia em que estas coisas aconteçam; porquanto não creste nas minhas palavras, que a seu tempo hão de cumprir-se.
21 O povo estava esperando Zacarias, e se admirava da sua demora no santuário.
22 Quando saiu, porém, não lhes podia falar, e perceberam que tivera uma visão no santuário. E falava-lhes por acenos, mas permanecia mudo.
23 E, terminados os dias do seu ministério, voltou para casa.
24 Depois desses dias Isabel, sua mulher, concebeu, e por cinco meses se ocultou, dizendo:
25 Assim me fez o Senhor nos dias em que atentou para mim, a fim de acabar com o meu opróbrio diante dos homens.
26 Ora, no sexto mês, foi o anjo Gabriel enviado por Deus a uma cidade da Galiléia, chamada Nazaré,
27 a uma virgem desposada com um varão cujo nome era José, da casa de Davi; e o nome da virgem era Maria.
28 E, entrando o anjo onde ela estava disse: Salve, agraciada; o Senhor é contigo.
29 Ela, porém, ao ouvir estas palavras, turbou-se muito e pôs-se a pensar que saudação seria essa.
30 Disse-lhe então o anjo: Não temas, Maria; pois achaste graça diante de Deus.
31 Eis que conceberás e darás à luz um filho, ao qual porás o nome de Jesus.
32 Este será grande e será chamado filho do Altíssimo; o Senhor Deus lhe dará o trono de Davi seu pai;
33 e reinará eternamente sobre a casa de Jacó, e o seu reino não terá fim.
34 Então Maria perguntou ao anjo: Como se fará isso, uma vez que não conheço varão?
35 Respondeu-lhe o anjo: Virá sobre ti o Espírito Santo, e o poder do Altíssimo te cobrirá com a sua sombra; por isso o que há de nascer será chamado santo, Filho de Deus.
36 Eis que também Isabel, tua parenta concebeu um filho em sua velhice; e é este o sexto mês para aquela que era chamada estéril;
37 porque para Deus nada será impossível.
38 Disse então Maria. Eis aqui a serva do Senhor; cumpra-se em mim segundo a tua palavra. E o anjo ausentou-se dela.
39 Naqueles dias levantou-se Maria, foi apressadamente à região montanhosa, a uma cidade de Judá,
40 entrou em casa de Zacarias e saudou a Isabel.
41 Ao ouvir Isabel a saudação de Maria, saltou a criancinha no seu ventre, e Isabel ficou cheia do Espírito Santo,
42 e exclamou em alta voz: Bendita és tu entre as mulheres, e bendito é o fruto do teu ventre!
43 E donde me provém isto, que venha visitar-me a mãe do meu Senhor?
44 Pois logo que me soou aos ouvidos a voz da tua saudação, a criancinha saltou de alegria dentro de mim.
45 Bem-aventurada aquela que creu que se hão de cumprir as coisas que da parte do Senhor lhe foram ditas.
46 Disse então Maria: A minha alma engrandece ao Senhor,
47 e o meu espírito exulta em Deus meu Salvador;
48 porque atentou na condição humilde de sua serva. Desde agora, pois, todas as gerações me chamarão bem-aventurada,
49 porque o Poderoso me fez grandes coisas; e santo é o seu nome.
50 E a sua misericórdia vai de geração em geração sobre os que o temem.
51 Com o seu braço manifestou poder; dissipou os que eram soberbos nos pensamentos de seus corações;
52 depôs dos tronos os poderosos, e elevou os humildes.
53 Aos famintos encheu de bens, e vazios despediu os ricos.
54 Auxiliou a Israel, seu servo, lembrando-se de misericórdia
55 (como falou a nossos pais) para com Abraão e a sua descendência para sempre.
56 E Maria ficou com ela cerca de três meses; e depois voltou para sua casa.
57 Ora, completou-se para Isabel o tempo de dar à luz, e teve um filho.
58 Ouviram seus vizinhos e parentes que o Senhor lhe multiplicara a sua misericórdia, e se alegravam com ela.
59 Sucedeu, pois, no oitavo dia, que vieram circuncidar o menino; e queriam dar-lhe o nome de seu pai, Zacarias.
60 Respondeu, porém, sua mãe: De modo nenhum, mas será chamado João.
61 Ao que lhe disseram: Ninguém há na tua parentela que se chame por este nome.
62 E perguntaram por acenos ao pai como queria que se chamasse.
63 E pedindo ele uma tabuinha, escreveu: Seu nome é João. E todos se admiraram.
64 Imediatamente a boca se lhe abriu, e a língua se lhe soltou; louvando a Deus.
65 Então veio temor sobre todos os seus vizinhos; e em toda a região montanhosa da Judéia foram divulgadas todas estas coisas.
66 E todos os que delas souberam as guardavam no coração, dizendo: Que virá a ser, então, este menino? Pois a mão do Senhor estava com ele.
67 Zacarias, seu pai, ficou cheio do Espírito Santo e profetizou, dizendo:
68 Bendito, seja o Senhor Deus de Israel, porque visitou e remiu o seu povo,
69 e para nós fez surgir uma salvação poderosa na casa de Davi, seu servo;
70 assim como desde os tempos antigos tem anunciado pela boca dos seus santos profetas;
71 para nos livrar dos nossos inimigos e da mão de todos os que nos odeiam;
72 para usar de misericórdia com nossos pais, e lembrar-se do seu santo pacto
73 e do juramento que fez a Abrão, nosso pai,
74 de conceder-nos que, libertados da mão de nossos inimigos, o servíssemos sem temor,
75 em santidade e justiça perante ele, todos os dias da nossa vida.
76 E tu, menino, serás chamado profeta do Altíssimo, porque irás ante a face do Senhor, a preparar os seus caminhos;
77 para dar ao seu povo conhecimento da salvação, na remissão dos seus pecados,
78 graças à entrenhável misericórdia do nosso Deus, pela qual nos há de visitar a aurora lá do alto,
79 para alumiar aos que jazem nas trevas e na sombra da morte, a fim de dirigir os nossos pés no caminho da paz.
80 Ora, o menino crescia, e se robustecia em espírito; e habitava nos desertos até o dia da sua manifestação a Israel.'),
  ('33333333-3333-4333-8333-333333333333', 14, 'Lucas 10', '1 Depois disso designou o Senhor outros setenta, e os enviou adiante de si, de dois em dois, a todas as cidades e lugares aonde ele havia de ir.
2 E dizia-lhes: Na verdade, a seara é grande, mas os trabalhadores são poucos; rogai, pois, ao Senhor da seara que mande trabalhadores para a sua seara.
3 Ide; eis que vos envio como cordeiros ao meio de lobos.
4 Não leveis bolsa, nem alforge, nem alparcas; e a ninguém saudeis pelo caminho.
5 Em qualquer casa em que entrardes, dizei primeiro: Paz seja com esta casa.
6 E se ali houver um filho da paz, repousará sobre ele a vossa paz; e se não, voltará para vós.
7 Ficai nessa casa, comendo e bebendo do que eles tiverem; pois digno é o trabalhador do seu salário. Não andeis de casa em casa.
8 Também, em qualquer cidade em que entrardes, e vos receberem, comei do que puserem diante de vós.
9 Curai os enfermos que nela houver, e dizei-lhes: É chegado a vós o reino de Deus.
10 Mas em qualquer cidade em que entrardes, e vos não receberem, saíndo pelas ruas, dizei:
11 Até o pó da vossa cidade, que se nos pegou aos pés, sacudimos contra vós. Contudo, sabei isto: que o reino de Deus é chegado.
12 Digo-vos que naquele dia haverá menos rigor para Sodoma, do que para aquela cidade.
13 Ai de ti, Corazim! ai de ti, Betsaida! Porque, se em Tiro e em Sidom se tivessem operado os milagres que em vós se operaram, há muito, sentadas em cilício e cinza, elas se teriam arrependido.
14 Contudo, para Tiro e Sidom haverá menos rigor no juízo do que para vós.
15 E tu, Cafarnaum, porventura serás elevada até o céu? até o hades descerás.
16 Quem vos ouve, a mim me ouve; e quem vos rejeita, a mim me rejeita; e quem a mim me rejeita, rejeita aquele que me enviou.
17 Voltaram depois os setenta com alegria, dizendo: Senhor, em teu nome, até os demônios se nos submetem.
18 Respondeu-lhes ele: Eu via Satanás, como raio, cair do céu.
19 Eis que vos dei autoridade para pisar serpentes e escorpiões, e sobre todo o poder do inimigo; e nada vos fará dano algum.
20 Contudo, não vos alegreis porque se vos submetem os espíritos; alegrai-vos antes por estarem os vossos nomes escritos nos céus.
21 Naquela mesma hora exultou Jesus no Espírito Santo, e disse: Graças te dou, ó Pai, Senhor do céu e da terra, porque ocultaste estas coisas aos sábios e entendidos, e as revelaste aos pequeninos; sim, ó Pai, porque assim foi do teu agrado.
22 Todas as coisas me foram entregues por meu Pai; e ninguém conhece quem é o Filho senão o Pai, nem quem é o Pai senão o Filho, e aquele a quem o Filho o quiser revelar.
23 E voltando-se para os discípulos, disse-lhes em particular: Bem-aventurados os olhos que vêem o que vós vedes.
24 Pois vos digo que muitos profetas e reis desejaram ver o que vós vedes, e não o viram; e ouvir o que ouvis, e não o ouviram.
25 E eis que se levantou certo doutor da lei e, para o experimentar, disse: Mestre, que farei para herdar a vida eterna?
26 Perguntou-lhe Jesus: Que está escrito na lei? Como lês tu?
27 Respondeu-lhe ele: Amarás ao Senhor teu Deus de todo o teu coração, de toda a tua alma, de todas as tuas forças e de todo o teu entendimento, e ao teu próximo como a ti mesmo.
28 Tornou-lhe Jesus: Respondeste bem; faze isso, e viverás.
29 Ele, porém, querendo justificar-se, perguntou a Jesus: E quem é o meu próximo?
30 Jesus, prosseguindo, disse: Um homem descia de Jerusalém a Jericó, e caiu nas mãos de salteadores, os quais o despojaram e espancando-o, se retiraram, deixando-o meio morto.
31 Casualmente, descia pelo mesmo caminho certo sacerdote; e vendo-o, passou de largo.
32 De igual modo também um levita chegou àquele lugar, viu-o, e passou de largo.
33 Mas um samaritano, que ia de viagem, chegou perto dele e, vendo-o, encheu-se de compaixão;
34 e aproximando-se, atou-lhe as feridas, deitando nelas azeite e vinho; e pondo-o sobre a sua cavalgadura, levou-o para uma estalagem e cuidou dele.
35 No dia seguinte tirou dois denários, deu-os ao hospedeiro e disse-lhe: Cuida dele; e tudo o que gastares a mais, eu te pagarei quando voltar.
36 Qual, pois, destes três te parece ter sido o próximo daquele que caiu nas mãos dos salteadores?
37 Respondeu o doutor da lei: Aquele que usou de misericórdia para com ele. Disse-lhe, pois, Jesus: Vai, e faze tu o mesmo.
38 Ora, quando iam de caminho, entrou Jesus numa aldeia; e certa mulher, por nome Marta, o recebeu em sua casa.
39 Tinha esta uma irmã chamada Maria, a qual, sentando-se aos pés do Senhor, ouvia a sua palavra.
40 Marta, porém, andava preocupada com muito serviço; e aproximando-se, disse: Senhor, não se te dá que minha irmã me tenha deixado a servir sozinha? Dize-lhe, pois, que me ajude.
41 Respondeu-lhe o Senhor: Marta, Marta, estás ansiosa e perturbada com muitas coisas;
42 entretanto poucas são necessárias, ou mesmo uma só; e Maria escolheu a boa parte, a qual não lhe será tirada.'),
  ('33333333-3333-4333-8333-333333333333', 15, 'João 20', '1 No primeiro dia da semana Maria Madalena foi ao sepulcro de madrugada, sendo ainda escuro, e viu que a pedra fora removida do sepulcro.
2 Correu, pois, e foi ter com Simão Pedro, e o outro discípulo, a quem Jesus amava, e disse-lhes: Tiraram do sepulcro o Senhor, e não sabemos onde o puseram.
3 Saíram então Pedro e o outro discípulo e foram ao sepulcro.
4 Corriam os dois juntos, mas o outro discípulo correu mais ligeiro do que Pedro, e chegou primeiro ao sepulcro;
5 e, abaixando-se viu os panos de linho ali deixados, todavia não entrou.
6 Chegou, pois, Simão Pedro, que o seguia, e entrou no sepulcro e viu os panos de linho ali deixados,
7 e que o lenço, que estivera sobre a cabeça de Jesus, não estava com os panos, mas enrolado num lugar à parte.
8 Então entrou também o outro discípulo, que chegara primeiro ao sepulcro, e viu e creu.
9 Porque ainda não entendiam a escritura, que era necessário que ele ressurgisse dentre os mortos.
10 Tornaram, pois, os discípulos para casa.
11 Maria, porém, estava em pé, diante do sepulcro, a chorar. Enquanto chorava, abaixou-se a olhar para dentro do sepulcro,
12 e viu dois anjos vestidos de branco sentados onde jazera o corpo de Jesus, um à cabeceira e outro aos pés.
13 E perguntaram-lhe eles: Mulher, por que choras? Respondeu- lhes: Porque tiraram o meu Senhor, e não sei onde o puseram.
14 Ao dizer isso, voltou-se para trás, e viu a Jesus ali em pé, mas não sabia que era Jesus.
15 Perguntou-lhe Jesus: Mulher, por que choras? A quem procuras? Ela, julgando que fosse o jardineiro, respondeu-lhe: Senhor, se tu o levaste, dize-me onde o puseste, e eu o levarei.
16 Disse-lhe Jesus: Maria! Ela, virando-se, disse-lhe em hebraico: Raboni! - que quer dizer, Mestre.
17 Disse-lhe Jesus: Deixa de me tocar, porque ainda não subi ao Pai; mas vai a meus irmãos e dize-lhes que eu subo para meu Pai e vosso Pai, meu Deus e vosso Deus.
18 E foi Maria Madalena anunciar aos discípulos: Vi o Senhor! - e que ele lhe dissera estas coisas.
19 Chegada, pois, a tarde, naquele dia, o primeiro da semana, e estando os discípulos reunidos com as portas cerradas por medo dos judeus, chegou Jesus, pôs-se no meio e disse-lhes: Paz seja convosco.
20 Dito isto, mostrou-lhes as mãos e o lado. Alegraram-se, pois, os discípulos ao verem o Senhor.
21 Disse-lhes, então, Jesus segunda vez: Paz seja convosco; assim como o Pai me enviou, também eu vos envio a vós.
22 E havendo dito isso, assoprou sobre eles, e disse-lhes: Recebei o Espírito Santo.
23 Àqueles a quem perdoardes os pecados, são-lhes perdoados; e àqueles a quem os retiverdes, são-lhes retidos.
24 Ora, Tomé, um dos doze, chamado Dídimo, não estava com eles quando veio Jesus.
25 Diziam-lhe, pois, os outros discípulos: Vimos o Senhor. Ele, porém, lhes respondeu: Se eu não vir o sinal dos cravos nas mãos, e não meter a mão no seu lado, de maneira nenhuma crerei.
26 Oito dias depois estavam os discípulos outra vez ali reunidos, e Tomé com eles. Chegou Jesus, estando as portas fechadas, pôs-se no meio deles e disse: Paz seja convosco.
27 Depois disse a Tomé: Chega aqui o teu dedo, e vê as minhas mãos; chega a tua mão, e mete-a no meu lado; e não mais sejas incrédulo, mas crente.
28 Respondeu-lhe Tomé: Senhor meu, e Deus meu!
29 Disse-lhe Jesus: Porque me viste, creste? Bem-aventurados os que não viram e creram.
30 Jesus, na verdade, operou na presença de seus discípulos ainda muitos outros sinais que não estão escritos neste livro;
31 estes, porém, estão escritos para que creiais que Jesus é o Cristo, o Filho de Deus, e para que, crendo, tenhais vida em seu nome.'),
  ('44444444-4444-4444-8444-444444444444', 1, 'Marcos 1', '1 Princípio do evangelho de Jesus Cristo, Filho de Deus.
2 Conforme está escrito no profeta Isaías: Eis que envio ante a tua face o meu mensageiro, que há de preparar o teu caminho;
3 voz do que clama no deserto: Preparai o caminho do Senhor, endireitai as suas veredas;
4 assim apareceu João, o Batista, no deserto, pregando o batismo de arrependimento para remissão dos pecados.
5 E saíam a ter com ele toda a terra da Judéia, e todos os moradores de Jerusalém; e eram por ele batizados no rio Jordão, confessando os seus pecados.
6 Ora, João usava uma veste de pêlos de camelo, e um cinto de couro em torno de seus lombos, e comia gafanhotos e mel silvestre.
7 E pregava, dizendo: Após mim vem aquele que é mais poderoso do que eu, de quem não sou digno de, inclinando-me, desatar a correia das alparcas.
8 Eu vos batizei em água; ele, porém, vos batizará no Espírito Santo.
9 E aconteceu naqueles dias que veio Jesus de Nazaré da Galiléia, e foi batizado por João no Jordão.
10 E logo, quando saía da água, viu os céus se abrirem, e o Espírito, qual pomba, a descer sobre ele;
11 e ouviu-se dos céus esta voz: Tu és meu Filho amado; em ti me comprazo.
12 Imediatamente o Espírito o impeliu para o deserto.
13 E esteve no deserto quarenta dias sendo tentado por Satanás; estava entre as feras, e os anjos o serviam.
14 Ora, depois que João foi entregue, veio Jesus para a Galiléia pregando o evangelho de Deus
15 e dizendo: O tempo está cumprido, e é chegado o reino de Deus. Arrependei-vos, e crede no evangelho.
16 E, andando junto do mar da Galiléia, viu a Simão, e a André, irmão de Simão, os quais lançavam a rede ao mar, pois eram pescadores.
17 Disse-lhes Jesus: Vinde após mim, e eu farei que vos torneis pescadores de homens.
18 Então eles, deixando imediatamente as suas redes, o seguiram.
19 E ele, passando um pouco adiante, viu Tiago, filho de Zebedeu, e João, seu irmão, que estavam no barco, consertando as redes,
20 e logo os chamou; eles, deixando seu pai Zebedeu no barco com os empregados, o seguiram.
21 Entraram em Cafarnaum; e, logo no sábado, indo ele à sinagoga, pôs-se a ensinar.
22 E maravilhavam-se da sua doutrina, porque os ensinava como tendo autoridade, e não como os escribas.
23 Ora, estava na sinagoga um homem possesso dum espírito imundo, o qual gritou:
24 Que temos nós contigo, Jesus, nazareno? Vieste destruir-nos? Bem sei quem és: o Santo de Deus.
25 Mas Jesus o repreendeu, dizendo: Cala-te, e sai dele.
26 Então o espírito imundo, convulsionando-o e clamando com grande voz, saiu dele.
27 E todos se maravilharam a ponto de perguntarem entre si, dizendo: Que é isto? Uma nova doutrina com autoridade! Pois ele ordena aos espíritos imundos, e eles lhe obedecem!
28 E logo correu a sua fama por toda a região da Galiléia.
29 Em seguida, saiu da sinagoga e foi a casa de Simão e André com Tiago e João.
30 A sogra de Simão estava de cama com febre, e logo lhe falaram a respeito dela.
31 Então Jesus, chegando-se e tomando-a pela mão, a levantou; e a febre a deixou, e ela os servia.
32 Sendo já tarde, tendo-se posto o sol, traziam-lhe todos os enfermos, e os endemoniados;
33 e toda a cidade estava reunida à porta;
34 e ele curou muitos doentes atacados de diversas moléstias, e expulsou muitos demônios; mas não permitia que os demônios falassem, porque o conheciam.
35 De madrugada, ainda bem escuro, levantou-se, saiu e foi a um lugar deserto, e ali orava.
36 Foram, pois, Simão e seus companheiros procurá-lo;
37 quando o encontraram, disseram-lhe: Todos te buscam.
38 Respondeu-lhes Jesus: Vamos a outras partes, às povoações vizinhas, para que eu pregue ali também; pois para isso é que vim.
39 Foi, então, por toda a Galiléia, pregando nas sinagogas deles e expulsando os demônios.
40 E veio a ele um leproso que, de joelhos, lhe rogava, dizendo: Se quiseres, bem podes tornar-me limpo.
41 Jesus, pois, compadecido dele, estendendo a mão, tocou-o e disse-lhe: Quero; sê limpo.
42 Imediatamente desapareceu dele a lepra e ficou limpo.
43 E Jesus, advertindo-o secretamente, logo o despediu,
44 dizendo-lhe: Olha, não digas nada a ninguém; mas vai, mostra-te ao sacerdote e oferece pela tua purificação o que Moisés determinou, para lhes servir de testemunho.
45 Ele, porém, saindo dali, começou a publicar o caso por toda parte e a divulgá-lo, de modo que Jesus já não podia entrar abertamente numa cidade, mas conservava-se fora em lugares desertos; e de todos os lados iam ter com ele.'),
  ('44444444-4444-4444-8444-444444444444', 2, 'Marcos 2', '1 Alguns dias depois entrou Jesus outra vez em Cafarnaum, e soube-se que ele estava em casa.
2 Ajuntaram-se, pois, muitos, a ponto de não caberem nem mesmo diante da porta; e ele lhes anunciava a palavra.
3 Nisso vieram alguns a trazer-lhe um paralítico, carregado por quatro;
4 e não podendo aproximar-se dele, por causa da multidão, descobriram o telhado onde estava e, fazendo uma abertura, baixaram o leito em que jazia o paralítico.
5 E Jesus, vendo-lhes a fé, disse ao paralítico: Filho, perdoados são os teus pecados.
6 Ora, estavam ali sentados alguns dos escribas, que arrazoavam em seus corações, dizendo:
7 Por que fala assim este homem? Ele blasfema. Quem pode perdoar pecados senão um só, que é Deus?
8 Mas Jesus logo percebeu em seu espírito que eles assim arrazoavam dentro de si, e perguntou-lhes: Por que arrazoais desse modo em vossos corações?
9 Qual é mais fácil? dizer ao paralítico: Perdoados são os teus pecados; ou dizer: Levanta-te, toma o teu leito, e anda?
10 Ora, para que saibais que o Filho do homem tem sobre a terra autoridade para perdoar pecados ( disse ao paralítico ),
11 a ti te digo, levanta-te, toma o teu leito, e vai para tua casa.
12 Então ele se levantou e, tomando logo o leito, saiu à vista de todos; de modo que todos pasmavam e glorificavam a Deus, dizendo: Nunca vimos coisa semelhante.
13 Outra vez saiu Jesus para a beira do mar; e toda a multidão ia ter com ele, e ele os ensinava.
14 Quando ia passando, viu a Levi, filho de Alfeu, sentado na coletoria, e disse-lhe: Segue-me. E ele, levantando-se, o seguiu.
15 Ora, estando Jesus à mesa em casa de Levi, estavam também ali reclinados com ele e seus discípulos muitos publicanos e pecadores; pois eram em grande número e o seguiam.
16 Vendo os escribas e fariseus que comia com os publicanos e pecadores, perguntavam aos discípulos: Por que é que ele come com os publicanos e pecadores?
17 Jesus, porém, ouvindo isso, disse-lhes: Não necessitam de médico os sãos, mas sim os enfermos; eu não vim chamar justos, mas pecadores.
18 Ora, os discípulos de João e os fariseus estavam jejuando; e foram perguntar-lhe: Por que jejuam os discípulos de João e os dos fariseus, mas os teus discípulos não jejuam?
19 Respondeu-lhes Jesus: Podem, porventura, jejuar os convidados às núpcias, enquanto está com eles o noivo? Enquanto têm consigo o noivo não podem jejuar;
20 dias virão, porém, em que lhes será tirado o noivo; nesses dias, sim hão de jejuar.
21 Ninguém cose remendo de pano novo em vestido velho; do contrário o remendo novo tira parte do velho, e torna-se maior a rotura.
22 E ninguém deita vinho novo em odres velhos; do contrário, o vinho novo romperá os odres, e perder-se-á o vinho e também os odres; mas deita-se vinho novo em odres novos.
23 E sucedeu passar ele num dia de sábado pelas searas; e os seus discípulos, caminhando, começaram a colher espigas.
24 E os fariseus lhe perguntaram: Olha, por que estão fazendo no sábado o que não é lícito?
25 Respondeu-lhes ele: Acaso nunca lestes o que fez Davi quando se viu em necessidade e teve fome, ele e seus companheiros?
26 Como entrou na casa de Deus, no templo do sumo sacerdote Abiatar, e comeu dos pães da proposição, dos quais não era lícito comer senão aos sacerdotes, e deu também aos companheiros?
27 E prosseguiu: O sábado foi feito por causa do homem, e não o homem por causa do sábado.
28 Pelo que o Filho do homem até do sábado é Senhor.'),
  ('44444444-4444-4444-8444-444444444444', 3, 'Marcos 3', '1 Outra vez entrou numa sinagoga, e estava ali um homem que tinha uma das mãos atrofiada.
2 E observavam-no para ver se no sábado curaria o homem, a fim de o acusarem.
3 E disse Jesus ao homem que tinha a mão atrofiada: Levanta-te e vem para o meio.
4 Então lhes perguntou: É lícito no sábado fazer bem, ou fazer mal? salvar a vida ou matar? Eles, porém, se calaram.
5 E olhando em redor para eles com indignação, condoendo-se da dureza dos seus corações, disse ao homem: Estende a tua mão. Ele estendeu, e lhe foi restabelecida.
6 E os fariseus, saindo dali, entraram logo em conselho com os herodianos contra ele, para o matarem.
7 Jesus, porém, se retirou com os seus discípulos para a beira do mar; e uma grande multidão dos da Galiléia o seguiu; também da Judéia,
8 e de Jerusalém, da Iduméia e de além do Jordão, e das regiões de Tiro e de Sidom, grandes multidões, ouvindo falar de tudo quanto fazia, vieram ter com ele.
9 Recomendou, pois, a seus discípulos que se lhe preparasse um barquinho, por causa da multidão, para que não o apertasse;
10 porque tinha curado a muitos, de modo que todos quantos tinham algum mal arrojavam-se a ele para lhe tocarem.
11 E os espíritos imundos, quando o viam, prostravam-se diante dele e clamavam, dizendo: Tu és o Filho de Deus.
12 E ele lhes advertia com insistência que não o dessem a conhecer.
13 Depois subiu ao monte, e chamou a si os que ele mesmo queria; e vieram a ele.
14 Então designou doze para que estivessem com ele, e os mandasse a pregar;
15 e para que tivessem autoridade de expulsar os demônios.
16 Designou, pois, os doze, a saber: Simão, a quem pôs o nome de Pedro;
17 Tiago, filho de Zebedeu, e João, irmão de Tiago, aos quais pôs o nome de Boanerges, que significa: Filhos do trovão;
18 André, Filipe, Bartolomeu, Mateus, Tomé, Tiago, filho de Alfeu, Tadeu, Simão, o cananeu,
19 e Judas Iscariotes, aquele que o traiu.
20 Depois entrou numa casa. E afluiu outra vez a multidão, de tal modo que nem podiam comer.
21 Quando os seus ouviram isso, saíram para o prender; porque diziam: Ele está fora de si.
22 E os escribas que tinham descido de Jerusalém diziam: Ele está possesso de Belzebu; e: É pelo príncipe dos demônios que expulsa os demônios.
23 Então Jesus os chamou e lhes disse por parábolas: Como pode Satanás expulsar Satanás?
24 Pois, se um reino se dividir contra si mesmo, tal reino não pode subsistir;
25 ou, se uma casa se dividir contra si mesma, tal casa não poderá subsistir;
26 e se Satanás se tem levantado contra si mesmo, e está dividido, tampouco pode ele subsistir; antes tem fim.
27 Pois ninguém pode entrar na casa do valente e roubar-lhe os bens, se primeiro não amarrar o valente; e então lhe saqueará a casa.
28 Em verdade vos digo: Todos os pecados serão perdoados aos filhos dos homens, bem como todas as blasfêmias que proferirem;
29 mas aquele que blasfemar contra o Espírito Santo, nunca mais terá perdão, mas será réu de pecado eterno.
30 Porquanto eles diziam: Está possesso de um espírito imundo.
31 Chegaram então sua mãe e seus irmãos e, ficando da parte de fora, mandaram chamá-lo.
32 E a multidão estava sentada ao redor dele, e disseram-lhe: Eis que tua mãe e teus irmãos estão lá fora e te procuram.
33 Respondeu-lhes Jesus, dizendo: Quem é minha mãe e meus irmãos!
34 E olhando em redor para os que estavam sentados à roda de si, disse: Eis aqui minha mãe e meus irmãos!
35 Pois aquele que fizer a vontade de Deus, esse é meu irmão, irmã e mãe.'),
  ('44444444-4444-4444-8444-444444444444', 4, 'Marcos 4', '1 Outra vez começou a ensinar à beira do mar. E reuniu-se a ele tão grande multidão que ele entrou num barco e sentou-se nele, sobre o mar; e todo o povo estava em terra junto do mar.
2 Então lhes ensinava muitas coisas por parábolas, e lhes dizia no seu ensino:
3 Ouvi: Eis que o semeador saiu a semear;
4 e aconteceu que, quando semeava, uma parte da semente caiu à beira do caminho, e vieram as aves e a comeram.
5 Outra caiu no solo pedregoso, onde não havia muita terra: e logo nasceu, porque não tinha terra profunda;
6 mas, saindo o sol, queimou-se; e, porque não tinha raiz, secou-se.
7 E outra caiu entre espinhos; e cresceram os espinhos, e a sufocaram; e não deu fruto.
8 Mas outras caíram em boa terra e, vingando e crescendo, davam fruto; e um grão produzia trinta, outro sessenta, e outro cem.
9 E disse-lhes: Quem tem ouvidos para ouvir, ouça.
10 Quando se achou só, os que estavam ao redor dele, com os doze, interrogaram-no acerca da parábola.
11 E ele lhes disse: A vós é confiado o mistério do reino de Deus, mas aos de fora tudo se lhes diz por parábolas;
12 para que vendo, vejam, e não percebam; e ouvindo, ouçam, e não entendam; para que não se convertam e sejam perdoados.
13 Disse-lhes ainda: Não percebeis esta parábola? como pois entendereis todas as parábolas?
14 O semeador semeia a palavra.
15 E os que estão junto do caminho são aqueles em quem a palavra é semeada; mas, tendo-a eles ouvido, vem logo Satanás e tira a palavra que neles foi semeada.
16 Do mesmo modo, aqueles que foram semeados nos lugares pedregosos são os que, ouvindo a palavra, imediatamente com alegria a recebem;
17 mas não têm raiz em si mesmos, antes são de pouca duração; depois, sobrevindo tribulação ou perseguição por causa da palavra, logo se escandalizam.
18 Outros ainda são aqueles que foram semeados entre os espinhos; estes são os que ouvem a palavra;
19 mas os cuidados do mundo, a sedução das riquezas e a cobiça doutras coisas, entrando, sufocam a palavra, e ela fica infrutífera.
20 Aqueles outros que foram semeados em boa terra são os que ouvem a palavra e a recebem, e dão fruto, a trinta, a sessenta, e a cem, por um.
21 Disse-lhes mais: Vem porventura a candeia para se meter debaixo do alqueire, ou debaixo da cama? não é antes para se colocar no velador?
22 Porque nada está encoberto senão para ser manifesto; e nada foi escondido senão para vir à luz.
23 Se alguém tem ouvidos para ouvir, ouça.
24 Também lhes disse: Atendei ao que ouvis. Com a medida com que medis vos medirão a vós, e ainda se vos acrescentará.
25 Pois ao que tem, ser-lhe-á dado; e ao que não tem, até aquilo que tem ser-lhe-á tirado.
26 Disse também: O reino de Deus é assim como se um homem lançasse semente à terra,
27 e dormisse e se levantasse de noite e de dia, e a semente brotasse e crescesse, sem ele saber como.
28 A terra por si mesma produz fruto, primeiro a erva, depois a espiga, e por último o grão cheio na espiga.
29 Mas assim que o fruto amadurecer, logo lhe mete a foice, porque é chegada a ceifa.
30 Disse ainda: A que assemelharemos o reino de Deus? ou com que parábola o representaremos?
31 É como um grão de mostarda que, quando se semeia, é a menor de todas as sementes que há na terra;
32 mas, tendo sido semeado, cresce e faz-se a maior de todas as hortaliças e cria grandes ramos, de tal modo que as aves do céu podem aninhar-se à sua sombra.
33 E com muitas parábolas lhes dirigia a palavra, conforme podiam compreender.
34 E sem parábola não lhes falava; mas em particular explicava tudo a seus discípulos.
35 Naquele dia, quando já era tarde, disse-lhes: Passemos para o outro lado.
36 E eles, deixando a multidão, o levaram consigo, assim como estava, no barco; e havia com ele também outros barcos.
37 E se levantou grande tempestade de vento, e as ondas batiam dentro do barco, de modo que já se enchia.
38 Ele, porém, estava na popa dormindo sobre a almofada; e despertaram-no, e lhe perguntaram: Mestre, não se te dá que pereçamos?
39 E ele, levantando-se, repreendeu o vento, e disse ao mar: Cala-te, aquieta-te. E cessou o vento, e fez-se grande bonança.
40 Então lhes perguntou: Por que sois assim tímidos? Ainda não tendes fé?
41 Encheram-se de grande temor, e diziam uns aos outros: Quem, porventura, é este, que até o vento e o mar lhe obedecem?'),
  ('44444444-4444-4444-8444-444444444444', 5, 'Marcos 5', '1 Chegaram então ao outro lado do mar, à terra dos gerasenos.
2 E, logo que Jesus saíra do barco, lhe veio ao encontro, dos sepulcros, um homem com espírito imundo,
3 o qual tinha a sua morada nos sepulcros; e nem ainda com cadeias podia alguém prendê-lo;
4 porque, tendo sido muitas vezes preso com grilhões e cadeias, as cadeias foram por ele feitas em pedaços, e os grilhões em migalhas; e ninguém o podia domar;
5 e sempre, de dia e de noite, andava pelos sepulcros e pelos montes, gritando, e ferindo-se com pedras,
6 Vendo, pois, de longe a Jesus, correu e adorou-o;
7 e, clamando com grande voz, disse: Que tenho eu contigo, Jesus, Filho do Deus Altíssimo? conjuro-te por Deus que não me atormentes.
8 Pois Jesus lhe dizia: Sai desse homem, espírito imundo.
9 E perguntou-lhe: Qual é o teu nome? Respondeu-lhe ele: Legião é o meu nome, porque somos muitos.
10 E rogava-lhe muito que não os enviasse para fora da região.
11 Ora, andava ali pastando no monte uma grande manada de porcos.
12 Rogaram-lhe, pois, os demônios, dizendo: Manda-nos para aqueles porcos, para que entremos neles.
13 E ele lho permitiu. Saindo, então, os espíritos imundos, entraram nos porcos; e precipitou-se a manada, que era de uns dois mil, pelo despenhadeiro no mar, onde todos se afogaram.
14 Nisso fugiram aqueles que os apascentavam, e o anunciaram na cidade e nos campos; e muitos foram ver o que era aquilo que tinha acontecido.
15 Chegando-se a Jesus, viram o endemoninhado, o que tivera a legião, sentado, vestido, e em perfeito juízo; e temeram.
16 E os que tinham visto aquilo contaram-lhes como havia acontecido ao endemoninhado, e acerca dos porcos.
17 Então começaram a rogar-lhe que se retirasse dos seus termos.
18 E, entrando ele no barco, rogava-lhe o que fora endemoninhado que o deixasse estar com ele.
19 Jesus, porém, não lho permitiu, mas disse-lhe: Vai para tua casa, para os teus, e anuncia-lhes o quanto o Senhor te fez, e como teve misericórdia de ti.
20 Ele se retirou, pois, e começou a publicar em Decápolis tudo quanto lhe fizera Jesus; e todos se admiravam.
21 Tendo Jesus passado de novo no barco para o outro lado, ajuntou-se a ele uma grande multidão; e ele estava à beira do mar.
22 Chegou um dos chefes da sinagoga, chamado Jairo e, logo que viu a Jesus, lançou-se-lhe aos pés.
23 e lhe rogava com instância, dizendo: Minha filhinha está nas últimas; rogo-te que venhas e lhe imponhas as mãos para que sare e viva.
24 Jesus foi com ele, e seguia-o uma grande multidão, que o apertava.
25 Ora, certa mulher, que havia doze anos padecia de uma hemorragia,
26 e que tinha sofrido bastante às mãos de muitos médicos, e despendido tudo quanto possuía sem nada aproveitar, antes indo a pior,
27 tendo ouvido falar a respeito de Jesus, veio por detrás, entre a multidão, e tocou-lhe o manto;
28 porque dizia: Se tão-somente tocar-lhe as vestes, ficaria curada.
29 E imediatamente cessou a sua hemorragia; e sentiu no corpo estar já curada do seu mal.
30 E logo Jesus, percebendo em si mesmo que saíra dele poder, virou-se no meio da multidão e perguntou: Quem me tocou as vestes?
31 Responderam-lhe os seus discípulos: Vês que a multidão te aperta, e perguntas: Quem me tocou?
32 Mas ele olhava em redor para ver a que isto fizera.
33 Então a mulher, atemorizada e trêmula, cônscia do que nela se havia operado, veio e prostrou-se diante dele, e declarou-lhe toda a verdade.
34 Disse-lhe ele: Filha, a tua fé te salvou; vai-te em paz, e fica livre desse teu mal.
35 Enquanto ele ainda falava, chegaram pessoas da casa do chefe da sinagoga, a quem disseram: A tua filha já morreu; por que ainda incomodas o Mestre?
36 O que percebendo Jesus, disse ao chefe da sinagoga: Não temas, crê somente.
37 E não permitiu que ninguém o acompanhasse, senão Pedro, Tiago, e João, irmão de Tiago.
38 Quando chegaram a casa do chefe da sinagoga, viu Jesus um alvoroço, e os que choravam e faziam grande pranto.
39 E, entrando, disse-lhes: Por que fazeis alvoroço e chorais? a menina não morreu, mas dorme.
40 E riam-se dele; porém ele, tendo feito sair a todos, tomou consigo o pai e a mãe da menina, e os que com ele vieram, e entrou onde a menina estava.
41 E, tomando a mão da menina, disse-lhe: Talita cumi, que, traduzido, é: Menina, a ti te digo, levanta-te.
42 Imediatamente a menina se levantou, e pôs-se a andar, pois tinha doze anos. E logo foram tomados de grande espanto.
43 Então ordenou-lhes expressamente que ninguém o soubesse; e mandou que lhe dessem de comer.'),
  ('44444444-4444-4444-8444-444444444444', 6, 'Marcos 6', '1 Saiu Jesus dali, e foi para a sua terra, e os seus discípulos o seguiam.
2 Ora, chegando o sábado, começou a ensinar na sinagoga; e muitos, ao ouví-lo, se maravilhavam, dizendo: Donde lhe vêm estas coisas? e que sabedoria é esta que lhe é dada? e como se fazem tais milagres por suas mãos?
3 Não é este o carpinteiro, filho de Maria, irmão de Tiago, de José, de Judas e de Simão? e não estão aqui entre nós suas irmãs? E escandalizavam-se dele.
4 Então Jesus lhes dizia: Um profeta não fica sem honra senão na sua terra, entre os seus parentes, e na sua própria casa.
5 E não podia fazer ali nenhum milagre, a não ser curar alguns poucos enfermos, impondo-lhes as mãos.
6 E admirou-se da incredulidade deles. Em seguida percorria as aldeias circunvizinhas, ensinando.
7 E chamou a si os doze, e começou a enviá-los a dois e dois, e dava-lhes poder sobre os espíritos imundos;
8 ordenou-lhes que nada levassem para o caminho, senão apenas um bordão; nem pão, nem alforje, nem dinheiro no cinto;
9 mas que fossem calçados de sandálias, e que não vestissem duas túnicas.
10 Dizia-lhes mais: Onde quer que entrardes numa casa, ficai nela até sairdes daquele lugar.
11 E se qualquer lugar não vos receber, nem os homens vos ouvirem, saindo dali, sacudi o pó que estiver debaixo dos vossos pés, em testemunho contra eles.
12 Então saíram e pregaram que todos se arrependessem;
13 e expulsavam muitos demônios, e ungiam muitos enfermos com óleo, e os curavam.
14 E soube disso o rei Herodes (porque o nome de Jesus se tornara célebre), e disse: João, o Batista, ressuscitou dos mortos; e por isso estes poderes milagrosos operam nele.
15 Mas outros diziam: É Elias. E ainda outros diziam: É profeta como um dos profetas.
16 Herodes, porém, ouvindo isso, dizia: É João, aquele a quem eu mandei degolar: ele ressuscitou.
17 Porquanto o próprio Herodes mandara prender a João, e encerrá-lo maniatado no cárcere, por causa de Herodias, mulher de seu irmão Filipe; porque ele se havia casado com ela.
18 Pois João dizia a Herodes: Não te é lícito ter a mulher de teu irmão.
19 Por isso Herodias lhe guardava rancor e queria matá-lo, mas não podia;
20 porque Herodes temia a João, sabendo que era varão justo e santo, e o guardava em segurança; e, ao ouvi-lo, ficava muito perplexo, contudo de boa mente o escutava.
21 Chegado, porém, um dia oportuno quando Herodes no seu aniversário natalício ofereceu um banquete aos grandes da sua corte, aos principais da Galiléia,
22 entrou a filha da mesma Herodias e, dançando, agradou a Herodes e aos convivas. Então o rei disse à jovem: Pede-me o que quiseres, e eu to darei.
23 E jurou-lhe, dizendo: Tudo o que me pedires te darei, ainda que seja metade do meu reino.
24 Tendo ela saído, perguntou a sua mãe: Que pedirei? Ela respondeu: A cabeça de João, o Batista.
25 E tornando logo com pressa à presença do rei, pediu, dizendo: Quero que imediatamente me dês num prato a cabeça de João, o Batista.
26 Ora, entristeceu-se muito o rei; todavia, por causa dos seus juramentos e por causa dos que estavam à mesa, não lha quis negar.
27 O rei, pois, enviou logo um soldado da sua guarda com ordem de trazer a cabeça de João. Então ele foi e o degolou no cárcere,
28 e trouxe a cabeça num prato e a deu à jovem, e a jovem a deu à sua mãe.
29 Quando os seus discípulos ouviram isso, vieram, tomaram o seu corpo e o puseram num sepulcro.
30 Reuniram-se os apóstolos com Jesus e contaram-lhe tudo o que tinham feito e ensinado.
31 Ao que ele lhes disse: Vinde vós, à parte, para um lugar deserto, e descansai um pouco. Porque eram muitos os que vinham e iam, e não tinham tempo nem para comer.
32 Retiraram-se, pois, no barco para um lugar deserto, à parte.
33 Muitos, porém, os viram partir, e os reconheceram; e para lá correram a pé de todas as cidades, e ali chegaram primeiro do que eles.
34 E Jesus, ao desembarcar, viu uma grande multidão e compadeceu-se deles, porque eram como ovelhas que não têm pastor; e começou a ensinar-lhes muitas coisas.
35 Estando a hora já muito adiantada, aproximaram-se dele seus discípulos e disseram: O lugar é deserto, e a hora já está muito adiantada;
36 despede-os, para que vão aos sítios e às aldeias, em redor, e comprem para si o que comer.
37 Ele, porém, lhes respondeu: Dai-lhes vós de comer. Então eles lhe perguntaram: Havemos de ir comprar duzentos denários de pão e dar-lhes de comer?
38 Ao que ele lhes disse: Quantos pães tendes? Ide ver. E, tendo-se informado, responderam: Cinco pães e dois peixes.
39 Então lhes ordenou que a todos fizessem reclinar-se, em grupos, sobre a relva verde.
40 E reclinaram-se em grupos de cem e de cinquenta.
41 E tomando os cinco pães e os dois peixes, e erguendo os olhos ao céu, os abençoou; partiu os pães e os entregava a seus discípulos para lhos servirem; também repartiu os dois peixes por todos.
42 E todos comeram e se fartaram.
43 Em seguida, recolheram doze cestos cheios dos pedaços de pão e de peixe.
44 Ora, os que comeram os pães eram cinco mil homens.
45 Logo em seguida obrigou os seus discípulos a entrar no barco e passar adiante, para o outro lado, a Betsaida, enquanto ele despedia a multidão.
46 E, tendo-a despedido, foi ao monte para orar.
47 Chegada a tardinha, estava o barco no meio do mar, e ele sozinho em terra.
48 E, vendo-os fatigados a remar, porque o vento lhes era contrário, pela quarta vigília da noite, foi ter com eles, andando sobre o mar; e queria passar-lhes adiante;
49 eles, porém, ao vê-lo andando sobre o mar, pensaram que era um fantasma e gritaram;
50 porque todos o viram e se assustaram; mas ele imediatamente falou com eles e disse-lhes: Tende ânimo; sou eu; não temais.
51 E subiu para junto deles no barco, e o vento cessou; e ficaram, no seu íntimo, grandemente pasmados;
52 pois não tinham compreendido o milagre dos pães, antes o seu coração estava endurecido.
53 E, terminada a travessia, chegaram à terra em Genezaré, e ali atracaram.
54 Logo que desembarcaram, o povo reconheceu a Jesus;
55 e correndo eles por toda aquela região, começaram a levar nos leitos os que se achavam enfermos, para onde ouviam dizer que ele estava.
56 Onde quer, pois, que entrava, fosse nas aldeias, nas cidades ou nos campos, apresentavam os enfermos nas praças, e rogavam-lhe que os deixasse tocar ao menos a orla do seu manto; e todos os que a tocavam ficavam curados.'),
  ('44444444-4444-4444-8444-444444444444', 7, 'Marcos 7', '1 Foram ter com Jesus os fariseus, e alguns dos escribas vindos de Jerusalém,
2 e repararam que alguns dos seus discípulos comiam pão com as mãos impuras, isto é, por lavar.
3 Pois os fariseus, e todos os judeus, guardando a tradição dos anciãos, não comem sem lavar as mãos cuidadosamente;
4 e quando voltam do mercado, se não se purificarem, não comem. E muitas outras coisas há que receberam para observar, como a lavagem de copos, de jarros e de vasos de bronze.
5 Perguntaram-lhe, pois, os fariseus e os escribas: Por que não andam os teus discípulos conforme a tradição dos anciãos, mas comem o pão com as mãos por lavar?
6 Respondeu-lhes: Bem profetizou Isaías acerca de vós, hipócritas, como está escrito: Este povo honra-me com os lábios; o seu coração, porém, está longe de mim;
7 mas em vão me adoram, ensinando doutrinas que são preceitos de homens.
8 Vós deixais o mandamento de Deus, e vos apegais à tradição dos homens.
9 Disse-lhes ainda: Bem sabeis rejeitar o mandamento de Deus, para guardardes a vossa tradição.
10 Pois Moisés disse: Honra a teu pai e a tua mãe; e: Quem maldisser ao pai ou à mãe, certamente morrerá.
11 Mas vós dizeis: Se um homem disser a seu pai ou a sua mãe: Aquilo que poderías aproveitar de mim é Corbã, isto é, oferta ao Senhor,
12 não mais lhe permitis fazer coisa alguma por seu pai ou por sua mãe,
13 invalidando assim a palavra de Deus pela vossa tradição que vós transmitistes; também muitas outras coisas semelhantes fazeis.
14 E chamando a si outra vez a multidão, disse-lhes: Ouvi-me vós todos, e entendei.
15 Nada há fora do homem que, entrando nele, possa contaminá-lo; mas o que sai do homem, isso é que o contamina.
16 [Se alguém tem ouvidos para ouvir, ouça.]
17 Depois, quando deixou a multidão e entrou em casa, os seus discípulos o interrogaram acerca da parábola.
18 Respondeu-lhes ele: Assim também vós estais sem entender? Não compreendeis que tudo o que de fora entra no homem não o pode contaminar,
19 porque não lhe entra no coração, mas no ventre, e é lançado fora? Assim declarou puros todos os alimentos.
20 E prosseguiu: O que sai do homem , isso é que o contamina.
21 Pois é do interior, do coração dos homens, que procedem os maus pensamentos, as prostituições, os furtos, os homicídios, os adultérios,
22 a cobiça, as maldades, o dolo, a libertinagem, a inveja, a blasfêmia, a soberba, a insensatez;
23 todas estas más coisas procedem de dentro e contaminam o homem.
24 Levantando-se dali, foi para as regiões de Tiro e Sidom. E entrando numa casa, não queria que ninguém o soubesse, mas não pode ocultar-se;
25 porque logo, certa mulher, cuja filha estava possessa de um espírito imundo, ouvindo falar dele, veio e prostrou-se-lhe aos pés;
26 (ora, a mulher era grega, de origem siro-fenícia) e rogava-lhe que expulsasse de sua filha o demônio.
27 Respondeu-lhes Jesus: Deixa que primeiro se fartem os filhos; porque não é bom tomar o pão dos filhos e lança-lo aos cachorrinhos.
28 Ela, porém, replicou, e disse-lhe: Sim, Senhor; mas também os cachorrinhos debaixo da mesa comem das migalhas dos filhos.
29 Então ele lhe disse: Por essa palavra, vai; o demônio já saiu de tua filha.
30 E, voltando ela para casa, achou a menina deitada sobre a cama, e que o demônio já havia saído.
31 Tendo Jesus partido das regiões de Tiro, foi por Sidom até o mar da Galiléia, passando pelas regiões de Decápolis.
32 E trouxeram-lhe um surdo, que falava dificilmente; e rogaram-lhe que pusesse a mão sobre ele.
33 Jesus, pois, tirou-o de entre a multidão, à parte, meteu-lhe os dedos nos ouvidos e, cuspindo, tocou-lhe na língua;
34 e erguendo os olhos ao céu, suspirou e disse-lhe: Efatá; isto é Abre-te.
35 E abriram-se-lhe os ouvidos, a prisão da língua se desfez, e falava perfeitamente.
36 Então lhes ordenou Jesus que a ninguém o dissessem; mas, quando mais lho proibia, tanto mais o divulgavam.
37 E se maravilhavam sobremaneira, dizendo: Tudo tem feito bem; faz até os surdos ouvir e os mudos falar.'),
  ('44444444-4444-4444-8444-444444444444', 8, 'Marcos 8', '1 Naqueles dias, havendo de novo uma grande multidão, e não tendo o que comer, chamou Jesus os discípulos e disse-lhes:
2 Tenho compaixão da multidão, porque já faz três dias que eles estão comigo, e não têm o que comer.
3 Se eu os mandar em jejum para suas casas, desfalecerão no caminho; e alguns deles vieram de longe.
4 E seus discípulos lhe responderam: Donde poderá alguém satisfazê-los de pão aqui no deserto?
5 Perguntou-lhes Jesus: Quantos pães tendes? Responderam: Sete.
6 Logo mandou ao povo que se sentasse no chão; e tomando os sete pães e havendo dado graças, partiu-os e os entregava a seus discípulos para que os distribuíssem; e eles os distribuíram pela multidão.
7 Tinham também alguns peixinhos, os quais ele abençoou, e mandou que estes também fossem distribuídos.
8 Comeram, pois, e se fartaram; e dos pedaços que sobejavam levantaram sete alcofas.
9 Ora, eram cerca de quatro mil homens. E Jesus os despediu.
10 E, entrando logo no barco com seus discípulos, foi para as regiões de Dalmanuta.
11 Saíram os fariseus e começaram a discutir com ele, pedindo-lhe um sinal do céu, para o experimentarem.
12 Ele, suspirando profundamente em seu espírito, disse: Por que pede esta geração um sinal? Em verdade vos digo que a esta geração não será dado sinal algum.
13 E, deixando-os, tornou a embarcar e foi para o outro lado.
14 Ora, eles se esqueceram de levar pão, e no barco não tinham consigo senão um pão.
15 E Jesus ordenou-lhes, dizendo: Olhai, guardai-vos do fermento dos fariseus e do fermento de Herodes.
16 Pelo que eles arrazoavam entre si porque não tinham pão.
17 E Jesus, percebendo isso, disse-lhes: Por que arrazoais por não terdes pão? não compreendeis ainda, nem entendeis? tendes o vosso coração endurecido?
18 Tendo olhos, não vedes? e tendo ouvidos, não ouvis? e não vos lembrais?
19 Quando parti os cinco pães para os cinco mil, quantos cestos cheios de pedaços levantastes? Responderam-lhe: Doze.
20 E quando parti os sete para os quatro mil, quantas alcofas cheias de pedaços levantastes? Responderam-lhe: Sete.
21 E ele lhes disse: Não entendeis ainda?
22 Então chegaram a Betsaída. E trouxeram-lhe um cego, e rogaram-lhe que o tocasse.
23 Jesus, pois, tomou o cego pela mão, e o levou para fora da aldeia; e cuspindo-lhe nos olhos, e impondo-lhe as mãos, perguntou-lhe: Vês alguma coisa?
24 E, levantando ele os olhos, disse: Estou vendo os homens; porque como árvores os vejo andando.
25 Então tornou a pôr-lhe as mãos sobre os olhos; e ele, olhando atentamente, ficou restabelecido, pois já via nitidamente todas as coisas.
26 Depois o mandou para casa, dizendo: Mas não entres na aldeia.
27 E saiu Jesus com os seus discípulos para as aldeias de Cesaréia de Filipe, e no caminho interrogou os discípulos, dizendo: Quem dizem os homens que eu sou?
28 Responderam-lhe eles: Uns dizem: João, o Batista; outros: Elias; e ainda outros: Algum dos profetas.
29 Então lhes perguntou: Mas vós, quem dizeis que eu sou? Respondendo, Pedro lhe disse: Tu és o Cristo.
30 E ordenou-lhes Jesus que a ninguém dissessem aquilo a respeito dele.
31 Começou então a ensinar-lhes que era necessário que o Filho do homem padecesse muitas coisas, que fosse rejeitado pelos anciãos e principais sacerdotes e pelos escribas, que fosse morto, e que depois de três dias ressurgisse.
32 E isso dizia abertamente. Ao que Pedro, tomando-o à parte, começou a repreendê-lo.
33 Mas ele, virando-se olhando para seus discípulos, repreendeu a Pedro, dizendo: Para trás de mim, Satanás; porque não cuidas das coisas que são de Deus, mas sim das que são dos homens.
34 E chamando a si a multidão com os discípulos, disse-lhes: Se alguém quer vir após mim, negue-se a si mesmo, tome a sua cruz, e siga-me.
35 Pois quem quiser salvar a sua vida, perdê-la-á; mas quem perder a sua vida por amor de mim e do evangelho, salvá-la-á.
36 Pois que aproveita ao homem ganhar o mundo inteiro e perder a sua vida?
37 Ou que daria o homem em troca da sua vida?
38 Porquanto, qualquer que, entre esta geração adúltera e pecadora, se envergonhar de mim e das minhas palavras, também dele se envergonhará o Filho do homem quando vier na glória de seu Pai com os santos anjos.'),
('44444444-4444-4444-8444-444444444444', 9, 'Marcos 9', '1 Disse-lhes mais: Em verdade vos digo que, dos que aqui estão, alguns há que de modo nenhum provarão a morte até que vejam o reino de Deus já chegando com poder.
2 Seis dias depois tomou Jesus consigo a Pedro, a Tiago, e a João, e os levou à parte sós, a um alto monte; e foi transfigurado diante deles;
3 as suas vestes tornaram-se resplandecentes, extremamente brancas, tais como nenhum lavandeiro sobre a terra as poderia branquear.
4 E apareceu-lhes Elias com Moisés, e falavam com Jesus.
5 Pedro, tomando a palavra, disse a Jesus: Mestre, bom é estarmos aqui; faça-mos, pois, três cabanas, uma para ti, outra para Moisés, e outra para Elias.
6 Pois não sabia o que havia de dizer, porque ficaram atemorizados.
7 Nisto veio uma nuvem que os cobriu, e dela saiu uma voz que dizia: Este é o meu Filho amado; a ele ouvi.
8 De repente, tendo olhado em redor, não viram mais a ninguém consigo, senão só a Jesus.
9 Enquanto desciam do monte, ordenou-lhes que a ninguém contassem o que tinham visto, até que o Filho do homem ressurgisse dentre os mortos.
10 E eles guardaram o caso em segredo, indagando entre si o que seria o ressurgir dentre os mortos.
11 Então lhe perguntaram: Por que dizem os escribas que é necessário que Elias venha primeiro?
12 Respondeu-lhes Jesus: Na verdade Elias havia de vir primeiro, e restaurar todas as coisas; e como é que está escrito acerca do Filho do homem que ele deva padecer muito e ser aviltado?
13 Digo-vos, porém, que Elias já veio, e fizeram-lhe tudo quanto quiseram, como dele está escrito.
14 Quando chegaram aonde estavam os discípulos, viram ao redor deles uma grande multidão, e alguns escribas a discutirem com eles.
15 E logo toda a multidão, vendo a Jesus, ficou grandemente surpreendida; e correndo todos para ele, o saudavam.
16 Perguntou ele aos escribas: Que é que discutis com eles?
17 Respondeu-lhe um dentre a multidão: Mestre, eu te trouxe meu filho, que tem um espírito mudo;
18 e este, onde quer que o apanha, convulsiona-o, de modo que ele espuma, range os dentes, e vai definhando; e eu pedi aos teus discípulos que o expulsassem, e não puderam.
19 Ao que Jesus lhes respondeu: Ó geração incrédula! até quando estarei convosco? até quando vos hei de suportar? Trazei-mo.
20 Então lhe trouxeram; e quando ele viu a Jesus, o espírito imediatamente o convulsionou; e o endemoninhado, caindo por terra, revolvia-se espumando.
21 E perguntou Jesus ao pai dele: Há quanto tempo sucede-lhe isto? Respondeu ele: Desde a infância;
22 e muitas vezes o tem lançado no fogo, e na água, para o destruir; mas se podes fazer alguma coisa, tem compaixão de nós e ajuda-nos.
23 Ao que lhe disse Jesus: Se podes! - tudo é possível ao que crê.
24 Imediatamente o pai do menino, clamando, [com lágrimas] disse: Creio! Ajuda a minha incredulidade.
25 E Jesus, vendo que a multidão, correndo, se aglomerava, repreendeu o espírito imundo, dizendo: espírito mudo e surdo, eu te ordeno: Sai dele, e nunca mais entres nele.
26 E ele, gritando, e agitando-o muito, saiu; e ficou o menino como morto, de modo que a maior parte dizia: Morreu.
27 Mas Jesus, tomando-o pela mão, o ergueu; e ele ficou em pé.
28 E quando entrou em casa, seus discípulos lhe perguntaram à parte: Por que não pudemos nós expulsá-lo?
29 Respondeu-lhes: Esta casta não sai de modo algum, salvo à força de oração [e jejum.]
30 Depois, tendo partido dali, passavam pela Galiléia, e ele não queria que ninguém o soubesse;
31 porque ensinava a seus discípulos, e lhes dizia: O Filho do homem será entregue nas mãos dos homens, que o matarão; e morto ele, depois de três dias ressurgirá.
32 Mas eles não entendiam esta palavra, e temiam interrogá-lo.
33 Chegaram a Cafarnaum. E estando ele em casa, perguntou-lhes: Que estáveis discutindo pelo caminho?
34 Mas eles se calaram, porque pelo caminho haviam discutido entre si qual deles era o maior.
35 E ele, sentando-se, chamou os doze e lhes disse: se alguém quiser ser o primeiro, será o derradeiro de todos e o servo de todos.
36 Então tomou uma criança, pô-la no meio deles e, abraçando-a, disse-lhes:
37 Qualquer que em meu nome receber uma destas crianças, a mim me recebe; e qualquer que me recebe a mim, recebe não a mim mas àquele que me enviou.
38 Disse-lhe João: Mestre, vimos um homem que em teu nome expulsava demônios, e nós lho proibimos, porque não nos seguia.
39 Jesus, porém, respondeu: Não lho proibais; porque ninguém há que faça milagre em meu nome e possa logo depois falar mal de mim;
40 pois quem não é contra nós, é por nós.
41 Porquanto qualquer que vos der a beber um copo de água em meu nome, porque sois de Cristo, em verdade vos digo que de modo algum perderá a sua recompensa.
42 Mas qualquer que fizer tropeçar um destes pequeninos que crêem em mim, melhor lhe fora que se lhe pendurasse ao pescoço uma pedra de moinho, e que fosse lançado no mar.
43 E se a tua mão te fizer tropeçar, corta-a; melhor é entrares na vida aleijado, do que, tendo duas mãos, ires para o inferno, para o fogo que nunca se apaga.
44 [onde o seu verme não morre, e o fogo não se apaga.]
45 Ou, se o teu pé te fizer tropeçar, corta-o; melhor é entrares coxo na vida, do que, tendo dois pés, seres lançado no inferno.
46 [onde o seu verme não morre, e o fogo não se apaga.]
47 Ou, se o teu olho te fizer tropeçar, lança-o fora; melhor é entrares no reino de Deus com um só olho, do que, tendo dois olhos, seres lançado no inferno.
48 onde o seu verme não morre, e o fogo não se apaga.
49 Porque cada um será salgado com fogo.
50 Bom é o sal; mas, se o sal se tornar insípido, com que o haveis de temperar? Tende sal em vós mesmos, e guardai a paz uns com os outros.'),
  ('44444444-4444-4444-8444-444444444444', 10, 'Marcos 10', '1 Levantando-se Jesus, partiu dali para os termos da Judéia, e para além do Jordão; e de novo as multidões se reuniram em torno dele; e tornou a ensiná-las, como tinha por costume.
2 Então se aproximaram dele alguns fariseus e, para o experimentarem, lhe perguntaram: É lícito ao homem repudiar sua mulher?
3 Ele, porém, respondeu-lhes: Que vos ordenou Moisés?
4 Replicaram eles: Moisés permitiu escrever carta de divórcio, e repudiar a mulher.
5 Disse-lhes Jesus: Pela dureza dos vossos corações ele vos deixou escrito esse mandamento.
6 Mas desde o princípio da criação, Deus os fez homem e mulher.
7 Por isso deixará o homem a seu pai e a sua mãe, [e unir-se-á à sua mulher,]
8 e serão os dois uma só carne; assim já não são mais dois, mas uma só carne.
9 Porquanto o que Deus ajuntou, não o separe o homem.
10 Em casa os discípulos interrogaram-no de novo sobre isso.
11 Ao que lhes respondeu: Qualquer que repudiar sua mulher e casar com outra comete adultério contra ela;
12 e se ela repudiar seu marido e casar com outro, comete adultério.
13 Então lhe traziam algumas crianças para que as tocasse; mas os discípulos o repreenderam.
14 Jesus, porém, vendo isto, indignou-se e disse-lhes: Deixai vir a mim as crianças, e não as impeçais, porque de tais é o reino de Deus.
15 Em verdade vos digo que qualquer que não receber o reino de Deus como criança, de maneira nenhuma entrará nele.
16 E, tomando-as nos seus braços, as abençoou, pondo as mãos sobre elas.
17 Ora, ao sair para se pôr a caminho, correu para ele um homem, o qual se ajoelhou diante dele e lhe perguntou: Bom Mestre, que hei de fazer para herdar a vida eterna?
18 Respondeu-lhe Jesus: Por que me chamas bom? ninguém é bom, senão um que é Deus.
19 Sabes os mandamentos: Não matarás; não adulterarás; não furtarás; não dirás falso testemunho; a ninguém defraudarás; honra a teu pai e a tua mãe.
20 Ele, porém, lhe replicou: Mestre, tudo isso tenho guardado desde a minha juventude.
21 E Jesus, olhando para ele, o amou e lhe disse: Uma coisa te falta; vai vende tudo quanto tens e dá-o aos pobres, e terás um tesouro no céu; e vem, segue-me.
22 Mas ele, pesaroso desta palavra, retirou-se triste, porque possuía muitos bens.
23 Então Jesus, olhando em redor, disse aos seus discípulos: Quão dificilmente entrarão no reino de Deus os que têm riquezas!
24 E os discípulos se maravilharam destas suas palavras; mas Jesus, tornando a falar, disse-lhes: Filhos, quão difícil é [para os que confiam nas riquezas] entrar no reino de Deus!
25 É mais fácil um camelo passar pelo fundo de uma agulha, do que entrar um rico no reino de Deus.
26 Com isso eles ficaram sobremaneira maravilhados, dizendo entre si: Quem pode, então, ser salvo?
27 Jesus, fixando os olhos neles, respondeu: Para os homens é impossível, mas não para Deus; porque para Deus tudo é possível.
28 Pedro começou a dizer-lhe: Eis que nós deixamos tudo e te seguimos.
29 Respondeu Jesus: Em verdade vos digo que ninguém há, que tenha deixado casa, ou irmãos, ou irmãs, ou mãe, ou pai, ou filhos, ou campos, por amor de mim e do evangelho,
30 que não receba cem vezes tanto, já neste tempo, em casas, e irmãos, e irmãs, e mães, e filhos, e campos, com perseguições; e no mundo vindouro a vida eterna.
31 Mas muitos que são primeiros serão últimos; e muitos que são últimos serão primeiros.
32 Ora, estavam a caminho, subindo para Jerusalém; e Jesus ia adiante deles, e eles se maravilhavam e o seguiam atemorizados. De novo tomou consigo os doze e começou a contar-lhes as coisas que lhe haviam de sobrevir,
33 dizendo: Eis que subimos a Jerusalém, e o Filho do homem será entregue aos principais sacerdotes e aos escribas; e eles o condenarão à morte, e o entregarão aos gentios;
34 e hão de escarnecê-lo e cuspir nele, e açoitá-lo, e matá-lo; e depois de três dias ressurgirá.
35 Nisso aproximaram-se dele Tiago e João, filhos de Zebedeu, dizendo-lhe: Mestre, queremos que nos faças o que te pedirmos.
36 Ele, pois, lhes perguntou: Que quereis que eu vos faça?
37 Responderam-lhe: Concede-nos que na tua glória nos sentemos, um à tua direita, e outro à tua esquerda.
38 Mas Jesus lhes disse: Não sabeis o que pedis; podeis beber o cálice que eu bebo, e ser batizados no batismo em que eu sou batizado?
39 E lhe responderam: Podemos. Mas Jesus lhes disse: O cálice que eu bebo, haveis de bebê-lo, e no batismo em que eu sou batizado, haveis de ser batizados;
40 mas o sentar-se à minha direita, ou à minha esquerda, não me pertence concedê-lo; mas isso é para aqueles a quem está reservado.
41 E ouvindo isso os dez, começaram a indignar-se contra Tiago e João.
42 Então Jesus chamou-os para junto de si e lhes disse: Sabeis que os que são reconhecidos como governadores dos gentios, deles se assenhoreiam, e que sobre eles os seus grandes exercem autoridade.
43 Mas entre vós não será assim; antes, qualquer que entre vós quiser tornar-se grande, será esse o que vos sirva;
44 e qualquer que entre vós quiser ser o primeiro, será servo de todos.
45 Pois também o Filho do homem não veio para ser servido, mas para servir, e para dar a sua vida em resgate de muitos.
46 Depois chegaram a Jericó. E, ao sair ele de Jericó com seus discípulos e uma grande multidão, estava sentado junto do caminho um mendigo cego, Bartimeu filho de Timeu.
47 Este, quando ouviu que era Jesus, o nazareno, começou a clamar, dizendo: Jesus, Filho de Davi, tem compaixão de mim!
48 E muitos o repreendiam, para que se calasse; mas ele clamava ainda mais: Filho de Davi, tem compaixão de mim.
49 Parou, pois, Jesus e disse: Chamai-o. E chamaram o cego, dizendo-lhe: Tem bom ânimo; levanta-te, ele te chama.
50 Nisto, lançando de si a sua capa, de um salto se levantou e foi ter com Jesus.
51 Perguntou-lhe Jesus: Que queres que te faça? Respondeu-lhe o cego: Mestre, que eu veja.
52 Disse-lhe Jesus: Vai, a tua fé te salvou. E imediatamente recuperou a vista, e foi seguindo pelo caminho.'),
  ('44444444-4444-4444-8444-444444444444', 11, 'Marcos 11', '1 Ora, quando se aproximavam de Jerusalém, de Betfagé e de Betânia, junto do Monte das Oliveiras, enviou Jesus dois dos seus discípulos
2 e disse-lhes: Ide à aldeia que está defronte de vós; e logo que nela entrardes, encontrareis preso um jumentinho, em que ainda ninguém montou; desprendei-o e trazei-o.
3 E se alguém vos perguntar: Por que fazeis isso? respondei: O Senhor precisa dele, e logo tornará a enviá-lo para aqui.
4 Foram, pois, e acharam o jumentinho preso ao portão do lado de fora na rua, e o desprenderam.
5 E alguns dos que ali estavam lhes perguntaram: Que fazeis, desprendendo o jumentinho?
6 Responderam como Jesus lhes tinha mandado; e lho deixaram levar.
7 Então trouxeram a Jesus o jumentinho e lançaram sobre ele os seus mantos; e Jesus montou nele.
8 Muitos também estenderam pelo caminho os seus mantos, e outros, ramagens que tinham cortado nos campos.
9 E tanto os que o precediam como os que o seguiam, clamavam: Hosana! bendito o que vem em nome do Senhor!
10 Bendito o reino que vem, o reino de nosso pai Davi! Hosana nas alturas!
11 Tendo Jesus entrado em Jerusalém, foi ao templo; e tendo observado tudo em redor, como já fosse tarde, saiu para Betânia com os doze.
12 No dia seguinte, depois de saírem de Betânia teve fome,
13 e avistando de longe uma figueira que tinha folhas, foi ver se, porventura, acharia nela alguma coisa; e chegando a ela, nada achou senão folhas, porque não era tempo de figos.
14 E Jesus, falando, disse à figueira: Nunca mais coma alguém fruto de ti. E seus discípulos ouviram isso.
15 Chegaram, pois, a Jerusalém. E entrando ele no templo, começou a expulsar os que ali vendiam e compravam; e derribou as mesas dos cambistas, e as cadeiras dos que vendiam pombas;
16 e não consentia que ninguém atravessasse o templo levando qualquer utensílio;
17 e ensinava, dizendo-lhes: Não está escrito: A minha casa será chamada casa de oração para todas as nações? Vós, porém, a tendes feito covil de salteadores.
18 Ora, os principais sacerdotes e os escribas ouviram isto, e procuravam um modo de o matar; pois o temiam, porque toda a multidão se maravilhava da sua doutrina.
19 Ao cair da tarde, saíam da cidade.
20 Quando passavam na manhã seguinte, viram que a figueira tinha secado desde as raízes.
21 Então Pedro, lembrando-se, disse-lhe: Olha, Mestre, secou-se a figueira que amaldiçoaste.
22 Respondeu-lhes Jesus: Tende fé em Deus.
23 Em verdade vos digo que qualquer que disser a este monte: Ergue-te e lança-te no mar; e não duvidar em seu coração, mas crer que se fará aquilo que diz, assim lhe será feito.
24 Por isso vos digo: que tudo o que pedirdes em oração, crede que o recebereis, e tê-lo-eis.
25 Quando estiverdes orando, perdoai, se tendes alguma coisa contra alguém, para que também vosso Pai que está no céu, vos perdoe as vossas ofensas.
26 [Mas, se vós não perdoardes, também vosso Pai, que está no céu, não vos perdoará as vossas ofensas.]
27 Vieram de novo a Jerusalém. E andando Jesus pelo templo, aproximaram-se dele os principais sacerdotes, os escribas e os anciãos,
28 que lhe perguntaram: Com que autoridade fazes tu estas coisas? ou quem te deu autoridade para fazê-las?
29 Respondeu-lhes Jesus: Eu vos perguntarei uma coisa; respondei-me, pois, e eu vos direi com que autoridade faço estas coisas.
30 O batismo de João era do céu, ou dos homens? respondei-me.
31 Ao que eles arrazoavam entre si: Se dissermos: Do céu, ele dirá: Então por que não o crestes?
32 Mas diremos, porventura: Dos homens? - É que temiam o povo; porque todos verdadeiramente tinham a João como profeta.
33 Responderam, pois, a Jesus: Não sabemos. Replicou-lhes ele: Nem eu vos digo com que autoridade faço estas coisas.'),
  ('44444444-4444-4444-8444-444444444444', 12, 'Marcos 12', '1 Então começou Jesus a falar-lhes por parábolas. Um homem plantou uma vinha, cercou-a com uma sebe, cavou um lagar, e edificou uma torre; depois arrendou-a a uns lavradores e ausentou-se do país.
2 No tempo próprio, enviou um servo aos lavradores para que deles recebesse do fruto da vinha.
3 Mas estes, apoderando-se dele, o espancaram e o mandaram embora de mãos vazias.
4 E tornou a enviar-lhes outro servo; e a este feriram na cabeça e o ultrajaram.
5 Então enviou ainda outro, e a este mataram; e a outros muitos, dos quais a uns espancaram e a outros mataram.
6 Ora, tinha ele ainda um, o seu filho amado; a este lhes enviou por último, dizendo: A meu filho terão respeito.
7 Mas aqueles lavradores disseram entre si: Este é o herdeiro; vinde, matemo-lo, e a herança será nossa.
8 E, agarrando-o, o mataram, e o lançaram fora da vinha.
9 Que fará, pois, o senhor da vinha? Virá e destruirá os lavradores, e dará a vinha a outros.
10 Nunca lestes esta escritura: A pedra que os edificadores rejeitaram, essa foi posta como pedra angular;
11 pelo Senhor foi feito isso, e é maravilhoso aos nossos olhos?
12 Procuravam então prendê-lo, mas temeram a multidão, pois perceberam que contra eles proferira essa parábola; e, deixando-o, se retiraram.
13 Enviaram-lhe então alguns dos fariseus e dos herodianos, para que o apanhassem em alguma palavra.
14 Aproximando-se, pois, disseram-lhe: Mestre, sabemos que és verdadeiro, e de ninguém se te dá; porque não olhas à aparência dos homens, mas ensinas segundo a verdade o caminho de Deus; é lícito dar tributo a César, ou não? Daremos, ou não daremos?
15 Mas Jesus, percebendo a hipocrisia deles, respondeu-lhes: Por que me experimentais? trazei-me um denário para que eu o veja.
16 E eles lho trouxeram. Perguntou-lhes Jesus: De quem é esta imagem e inscrição? Responderam-lhe: De César.
17 Disse-lhes Jesus: Dai, pois, a César o que é de César, e a Deus o que é de Deus. E admiravam-se dele.
18 Então se aproximaram dele alguns dos saduceus, que dizem não haver ressurreição, e lhe perguntaram, dizendo:
19 Mestre, Moisés nos deixou escrito que se morrer alguém, deixando mulher sem deixar filhos, o irmão dele case com a mulher, e suscite descendência ao irmão.
20 Ora, havia sete irmãos; o primeiro casou-se e morreu sem deixar descendência;
21 o segundo casou-se com a viúva, e morreu, não deixando descendência; e da mesma forma, o terceiro; e assim os sete, e não deixaram descendência.
22 Depois de todos, morreu também a mulher.
23 Na ressurreição, de qual deles será ela esposa, pois os sete por esposa a tiveram?
24 Respondeu-lhes Jesus: Porventura não errais vós em razão de não compreenderdes as Escrituras nem o poder de Deus?
25 Porquanto, ao ressuscitarem dos mortos, nem se casam, nem se dão em casamento; pelo contrário, são como os anjos nos céus.
26 Quanto aos mortos, porém, serem ressuscitados, não lestes no livro de Moisés, onde se fala da sarça, como Deus lhe disse: Eu sou o Deus de Abraão, o Deus de Isaque e o Deus de Jacó?
27 Ora, ele não é Deus de mortos, mas de vivos. Estais em grande erro.
28 Aproximou-se dele um dos escribas que os ouvira discutir e, percebendo que lhes havia respondido bem, perguntou-lhe: Qual é o primeiro de todos os mandamentos?
29 Respondeu Jesus: O primeiro é: Ouve, Israel, o Senhor nosso Deus é o único Senhor.
30 Amarás, pois, ao Senhor teu Deus de todo o teu coração, de toda a tua alma, de todo o teu entendimento e de todas as tuas forças.
31 E o segundo é este: Amarás ao teu próximo como a ti mesmo. Não há outro mandamento maior do que esses.
32 Ao que lhe disse o escriba: Muito bem, Mestre; com verdade disseste que ele é um, e fora dele não há outro;
33 e que amá-lo de todo o coração, de todo o entendimento e de todas as forças, e amar o próximo como a si mesmo, é mais do que todos os holocaustos e sacrifícios.
34 E Jesus, vendo que havia respondido sabiamente, disse-lhe: Não estás longe do reino de Deus. E ninguém ousava mais interrogá-lo.
35 Por sua vez, Jesus, enquanto ensinava no templo, perguntou: Como é que os escribas dizem que o Cristo é filho de Davi?
36 O próprio Davi falou, movido pelo Espírito Santo: Disse o Senhor ao meu Senhor: Assenta-te à minha direita, até que eu ponha os teus inimigos debaixo dos teus pés.
37 Davi mesmo lhe chama Senhor; como é ele seu filho? E a grande multidão o ouvia com prazer.
38 E prosseguindo ele no seu ensino, disse: Guardai-vos dos escribas, que gostam de andar com vestes compridas, e das saudações nas praças,
39 e dos primeiros assentos nas sinagogas, e dos primeiros lugares nos banquetes,
40 que devoram as casas das viúvas, e por pretexto fazem longas orações; estes hão de receber muito maior condenação.
41 E sentando-se Jesus defronte do cofre das ofertas, observava como a multidão lançava dinheiro no cofre; e muitos ricos deitavam muito.
42 Vindo, porém, uma pobre viúva, lançou duas pequenas moedas, que valiam meio centavo.
43 E chamando ele os seus discípulos, disse-lhes: Em verdade vos digo que esta pobre viúva deu mais do que todos os que deitavam ofertas no cofre;
44 porque todos deram daquilo que lhes sobrava; mas esta, da sua pobreza, deu tudo o que tinha, mesmo todo o seu sustento.'),
  ('44444444-4444-4444-8444-444444444444', 13, 'Marcos 13', '1 Quando saía do templo, disse-lhe um dos seus discípulos: Mestre, olha que pedras e que edifícios!
2 Ao que Jesus lhe disse: Vês estes grandes edifícios? Não se deixará aqui pedra sobre pedra que não seja derribada.
3 Depois estando ele sentado no Monte das Oliveiras, defronte do templo, Pedro, Tiago, João e André perguntaram-lhe em particular:
4 Dize-nos, quando sucederão essas coisas, e que sinal haverá quando todas elas estiverem para se cumprir?
5 Então Jesus começou a dizer-lhes: Acautelai-vos; ninguém vos engane;
6 muitos virão em meu nome, dizendo: Sou eu; e a muitos enganarão.
7 Quando, porém, ouvirdes falar em guerras e rumores de guerras, não vos perturbeis; forçoso é que assim aconteça: mas ainda não é o fim.
8 Pois se levantará nação contra nação, e reino contra reino; e haverá terremotos em diversos lugares, e haverá fomes. Isso será o princípio das dores.
9 Mas olhai por vós mesmos; pois por minha causa vos hão de entregar aos sinédrios e às sinagogas, e sereis açoitados; também sereis levados perante governadores e reis, para lhes servir de testemunho.
10 Mas importa que primeiro o evangelho seja pregado entre todas as nações.
11 Quando, pois, vos conduzirem para vos entregar, não vos preocupeis com o que haveis de dizer; mas, o que vos for dado naquela hora, isso falai; porque não sois vós que falais, mas sim o Espírito Santo.
12 Um irmão entregará à morte a seu irmão, e um pai a seu filho; e filhos se levantarão contra os pais e os matarão.
13 E sereis odiados de todos por causa do meu nome; mas aquele que perseverar até o fim, esse será salvo.
14 Ora, quando vós virdes a abominação da desolação estar onde não deve estar (quem lê, entenda), então os que estiverem na Judéia fujam para os montes;
15 quem estiver no eirado não desça, nem entre para tirar alguma coisa da sua casa;
16 e quem estiver no campo não volte atrás para buscar a sua capa.
17 Mas ai das que estiverem grávidas, e das que amamentarem naqueles dias!
18 Orai, pois, para que isto não suceda no inverno;
19 porque naqueles dias haverá uma tribulação tal, qual nunca houve desde o princípio da criação, que Deus criou, até agora, nem jamais haverá.
20 Se o Senhor não abreviasse aqueles dias, ninguém se salvaria mas ele, por causa dos eleitos que escolheu, abreviou aqueles dias.
21 Então, se alguém vos disser: Eis aqui o Cristo! ou: Ei-lo ali! não acrediteis.
22 Porque hão de surgir falsos cristos e falsos profetas, e farão sinais e prodígios para enganar, se possível, até os escolhidos.
23 Ficai vós, pois, de sobreaviso; eis que de antemão vos tenho dito tudo.
24 Mas naqueles dias, depois daquela tribulação, o sol escurecerá, e a lua não dará a sua luz;
25 as estrelas cairão do céu, e os poderes que estão nos céus, serão abalados.
26 Então verão vir o Filho do homem nas nuvens, com grande poder e glória.
27 E logo enviará os seus anjos, e ajuntará os seus eleitos, desde os quatro ventos, desde a extremidade da terra até a extremidade do céu.
28 Da figueira, pois, aprendei a parábola: Quando já o seu ramo se torna tenro e brota folhas, sabeis que está próximo o verão.
29 Assim também vós, quando virdes sucederem essas coisas, sabei que ele está próximo, mesmo às portas.
30 Em verdade vos digo que não passará esta geração, até que todas essas coisas aconteçam.
31 Passará o céu e a terra, mas as minhas palavras não passarão.
32 Quanto, porém, ao dia e à hora, ninguém sabe, nem os anjos no céu nem o Filho, senão o Pai.
33 Olhai! vigiai! porque não sabeis quando chegará o tempo.
34 É como se um homem, devendo viajar, ao deixar a sua casa, desse autoridade aos seus servos, a cada um o seu trabalho, e ordenasse também ao porteiro que vigiasse.
35 Vigiai, pois; porque não sabeis quando virá o senhor da casa; se à tarde, se à meia-noite, se ao cantar do galo, se pela manhã;
36 para que, vindo de improviso, não vos ache dormindo.
37 O que vos digo a vós, a todos o digo: Vigiai.'),
  ('44444444-4444-4444-8444-444444444444', 14, 'Marcos 14', '1 Ora, dali a dois dias era a páscoa e a festa dos pães Asmos; e os principais sacerdotes e os escribas andavam buscando como prender Jesus a traição, para o matarem.
2 Pois eles diziam: Não durante a festa, para que não haja tumulto entre o povo.
3 Estando ele em Betânia, reclinado à mesa em casa de Simão, o leproso, veio uma mulher que trazia um vaso de alabastro cheio de bálsamo de nardo puro, de grande preço; e, quebrando o vaso, derramou-lhe sobre a cabeça o bálsamo.
4 Mas alguns houve que em si mesmos se indignaram e disseram: Para que se fez este desperdício do bálsamo?
5 Pois podia ser vendido por mais de trezentos denários que se dariam aos pobres. E bramavam contra ela.
6 Jesus, porém, disse: Deixai-a; por que a molestais? Ela praticou uma boa ação para comigo.
7 Porquanto os pobres sempre os tendes convosco e, quando quiserdes, podeis fazer-lhes bem; a mim, porém, nem sempre me tendes.
8 ela fez o que pode; antecipou-se a ungir o meu corpo para a sepultura.
9 Em verdade vos digo que, em todo o mundo, onde quer que for pregado o evangelho, também o que ela fez será contado para memória sua.
10 Então Judas Iscariotes, um dos doze, foi ter com os principais sacerdotes para lhes entregar Jesus.
11 Ouvindo-o eles, alegraram-se, e prometeram dar-lhe dinheiro. E buscava como o entregaria em ocasião oportuna.
12 Ora, no primeiro dia dos pães ázimos, quando imolavam a páscoa, disseram-lhe seus discípulos: Aonde queres que vamos fazer os preparativos para comeres a páscoa?
13 Enviou, pois, dois dos seus discípulos, e disse-lhes: Ide à cidade, e vos sairá ao encontro um homem levando um cântaro de água; seguí-o;
14 e, onde ele entrar, dizei ao dono da casa: O Mestre manda perguntar: Onde está o meu aposento em que hei de comer a páscoa com os meus discípulos?
15 E ele vos mostrará um grande cenáculo mobiliado e pronto; aí fazei-nos os preparativos.
16 Partindo, pois, os discípulos, foram à cidade, onde acharam tudo como ele lhes dissera, e prepararam a páscoa.
17 Ao anoitecer chegou ele com os doze.
18 E, quando estavam reclinados à mesa e comiam, disse Jesus: Em verdade vos digo que um de vós, que comigo come, há de trair-me.
19 Ao que eles começaram a entristecer-se e a perguntar-lhe um após outro: Porventura sou eu?
20 Respondeu-lhes: É um dos doze, que mete comigo a mão no prato.
21 Pois o Filho do homem vai, conforme está escrito a seu respeito; mas ai daquele por quem o Filho do homem é traído! bom seria para esse homem se não houvera nascido.
22 Enquanto comiam, Jesus tomou pão e, abençoando-o, o partiu e deu-lho, dizendo: Tomai; isto é o meu corpo.
23 E tomando um cálice, rendeu graças e deu-lho; e todos beberam dele.
24 E disse-lhes: Isto é o meu sangue, o sangue do pacto, que por muitos é derramado.
25 Em verdade vos digo que não beberei mais do fruto da videira, até aquele dia em que o beber, de novo, no reino de Deus.
26 E, tendo cantado um hino, saíram para o Monte das Oliveiras.
27 Disse-lhes então Jesus: Todos vós vos escandalizareis; porque escrito está: Ferirei o pastor, e as ovelhas se dispersarão.
28 Todavia, depois que eu ressurgir, irei adiante de vós para a Galiléia.
29 Ao que Pedro lhe disse: Ainda que todos se escandalizem, nunca, porém, eu.
30 Replicou-lhe Jesus: Em verdade te digo que hoje, nesta noite, antes que o galo cante duas vezes, três vezes tu me negarás.
31 Mas ele repetia com veemência: Ainda que me seja necessário morrer contigo, de modo nenhum te negarei. Assim também diziam todos.
32 Então chegaram a um lugar chamado Getsêmani, e disse Jesus a seus discípulos: Sentai-vos aqui, enquanto eu oro.
33 E levou consigo a Pedro, a Tiago e a João, e começou a ter pavor e a angustiar-se;
34 e disse-lhes: A minha alma está triste até a morte; ficai aqui e vigiai.
35 E adiantando-se um pouco, prostrou-se em terra; e orava para que, se fosse possível, passasse dele aquela hora.
36 E dizia: Aba, Pai, tudo te é possível; afasta de mim este cálice; todavia não seja o que eu quero, mas o que tu queres.
37 Voltando, achou-os dormindo; e disse a Pedro: Simão, dormes? não pudeste vigiar uma hora?
38 Vigiai e orai, para que não entreis em tentação; o espírito, na verdade, está pronto, mas a carne é fraca.
39 Retirou-se de novo e orou, dizendo as mesmas palavras.
40 E voltando outra vez, achou-os dormindo, porque seus olhos estavam carregados; e não sabiam o que lhe responder.
41 Ao voltar pela terceira vez, disse-lhes: Dormi agora e descansai. Basta! É chegada a hora. Eis que o Filho do homem está sendo entregue nas mãos dos pecadores.
42 Levantai-vos, vamo-nos; eis que é chegado aquele que me trai.
43 E logo, enquanto ele ainda falava, chegou Judas, um dos doze, e com ele uma multidão com espadas e varapaus, vinda da parte dos principais sacerdotes, dos escribas e dos anciãos.
44 Ora, o que o traía lhes havia dado um sinal, dizendo: Aquele que eu beijar, esse é; prendei-o e levai-o com segurança.
45 E, logo que chegou, aproximando-se de Jesus, disse: Rabi! E o beijou.
46 Ao que eles lhes lançaram as mãos, e o prenderam.
47 Mas um dos que ali estavam, puxando da espada, feriu o servo do sumo sacerdote e cortou-lhe uma orelha.
48 Disse-lhes Jesus: Saístes com espadas e varapaus para me prender, como a um salteador?
49 Todos os dias estava convosco no templo, a ensinar, e não me prendestes; mas isto é para que se cumpram as Escrituras.
50 Nisto, todos o deixaram e fugiram.
51 Ora, seguia-o certo jovem envolto em um lençol sobre o corpo nu; e o agarraram.
52 Mas ele, largando o lençol, fugiu despido.
53 Levaram Jesus ao sumo sacerdote, e ajuntaram-se todos os principais sacerdotes, os anciãos e os escribas.
54 E Pedro o seguiu de longe até dentro do pátio do sumo sacerdote, e estava sentado com os guardas, aquentando-se ao fogo.
55 E os principais dos sacerdotes e todo o concílio buscavam algum testemunho contra Jesus, para o matar, e não o achavam.
56 Porque muitos testificavam falsamente contra ele, mas os testemunhos não eram coerentes.
57 Levantaram-se por fim alguns que depunham falsamente contra ele, dizendo:
58 Nós o ouvimos dizer: Eu destruirei este santuário, construído por mãos de homens, e em três dias edificarei outro, não feito por mãos de homens.
59 E nem assim concordava o seu testemunho.
60 Levantou-se então o sumo sacerdote no meio e perguntou a Jesus: Não respondes coisa alguma? Que é que estes depõem conta ti?
61 Ele, porém, permaneceu calado, e nada respondeu. Tornou o sumo sacerdote a interrogá-lo, perguntando-lhe: És tu o Cristo, o Filho do Deus bendito?
62 Respondeu Jesus: Eu o sou; e vereis o Filho do homem assentado à direita do Poder e vindo com as nuvens do céu.
63 Então o sumo sacerdote, rasgando as suas vestes, disse: Para que precisamos ainda de testemunhas?
64 Acabais de ouvir a blasfêmia; que vos parece? E todos o condenaram como réu de morte.
65 E alguns começaram a cuspir nele, e a cobrir-lhe o rosto, e a dar-lhe socos, e a dizer-lhe: Profetiza. E os guardas receberam-no a bofetadas.
66 Ora, estando Pedro em baixo, no átrio, chegou uma das criadas do sumo sacerdote
67 e, vendo a Pedro, que se estava aquentando, encarou-o e disse: Tu também estavas com o nazareno, esse Jesus.
68 Mas ele o negou, dizendo: Não sei nem compreendo o que dizes. E saiu para o alpendre.
69 E a criada, vendo-o, começou de novo a dizer aos que ali estavam: Esse é um deles.
70 Mas ele o negou outra vez. E pouco depois os que ali estavam disseram novamente a Pedro: Certamente tu és um deles; pois és também galileu.
71 Ele, porém, começou a praguejar e a jurar: Não conheço esse homem de quem falais.
72 Nesse instante o galo cantou pela segunda vez. E Pedro lembrou-se da palavra que lhe dissera Jesus: Antes que o galo cante duas vezes, três vezes me negarás. E caindo em si, começou a chorar.'),
  ('44444444-4444-4444-8444-444444444444', 15, 'Marcos 15', '1 Logo de manhã tiveram conselho os principais sacerdotes com os anciãos, os escribas e todo o sinédrio; e maniatando a Jesus, o levaram e o entregaram a Pilatos.
2 Pilatos lhe perguntou: És tu o rei dos judeus? Respondeu-lhe Jesus: É como dizes.
3 e os principais dos sacerdotes o acusavam de muitas coisas.
4 Tornou Pilatos a interrogá-lo, dizendo: Não respondes nada? Vê quantas acusações te fazem.
5 Mas Jesus nada mais respondeu, de maneira que Pilatos se admirava.
6 Ora, por ocasião da festa costumava soltar-lhes um preso qualquer que eles pedissem.
7 E havia um, chamado Barrabás, preso com outros sediciosos, os quais num motim haviam cometido um homicídio.
8 E a multidão subiu e começou a pedir o que lhe costumava fazer.
9 Ao que Pilatos lhes perguntou: Quereis que vos solte o rei dos judeus?
10 Pois ele sabia que por inveja os principais sacerdotes lho haviam entregado.
11 Mas os principais sacerdotes incitaram a multidão a pedir que lhes soltasse antes a Barrabás.
12 E Pilatos, tornando a falar, perguntou-lhes: Que farei então daquele a quem chamais reis dos judeus?
13 Novamente clamaram eles: Crucifica-o!
14 Disse-lhes Pilatos: Mas que mal fez ele? Ao que eles clamaram ainda mais: Crucifica-o!
15 Então Pilatos, querendo satisfazer a multidão, soltou-lhe Barrabás; e tendo mandado açoitar a Jesus, o entregou para ser crucificado.
16 Os soldados, pois, levaram-no para dentro, ao pátio, que é o pretório, e convocaram toda a coorte;
17 vestiram-no de púrpura e puseram-lhe na cabeça uma coroa de espinhos que haviam tecido;
18 e começaram a saudá-lo: Salve, rei dos judeus!
19 Davam-lhe com uma cana na cabeça, cuspiam nele e, postos de joelhos, o adoravam.
20 Depois de o terem assim escarnecido, despiram-lhe a púrpura, e lhe puseram as vestes. Então o levaram para fora, a fim de o crucificarem.
21 E obrigaram certo Simão, cireneu, pai de Alexandre e de Rufo, que por ali passava, vindo do campo, a carregar-lhe a cruz.
22 Levaram-no, pois, ao lugar do Gólgota, que quer dizer, lugar da Caveira.
23 E ofereciam-lhe vinho misturado com mirra; mas ele não o tomou.
24 Então o crucificaram, e repartiram entre si as vestes dele, lançando sortes sobre elas para ver o que cada um levaria.
25 E era a hora terceira quando o crucificaram.
26 Por cima dele estava escrito o título da sua acusação: O REI DOS JUDEUS.
27 Também, com ele, crucificaram dois salteadores, um à sua direita, e outro à esquerda.
28 [E cumpriu-se a escritura que diz: E com os malfeitores foi contado.]
29 E os que iam passando blasfemavam dele, meneando a cabeça e dizendo: Ah! tu que destróis o santuário e em três dias o reedificas.
30 salva-te a ti mesmo, descendo da cruz.
31 De igual modo também os principais sacerdotes, com os escribas, escarnecendo-o, diziam entre si: A outros salvou; a si mesmo não pode salvar;
32 desça agora da cruz o Cristo, o rei de Israel, para que vejamos e creiamos, Também os que com ele foram crucificados o injuriavam.
33 E, chegada a hora sexta, houve trevas sobre a terra, até a hora nona.
34 E, à hora nona, bradou Jesus em alta voz: Eloí, Eloí, lamá, sabactani? que, traduzido, é: Deus meu, Deus meu, por que me desamparaste?
35 Alguns dos que ali estavam, ouvindo isso, diziam: Eis que chama por Elias.
36 Correu um deles, ensopou uma esponja em vinagre e, pondo-a numa cana, dava-lhe de beber, dizendo: Deixai, vejamos se Elias virá tirá-lo.
37 Mas Jesus, dando um grande brado, expirou.
38 Então o véu do santuário se rasgou em dois, de alto a baixo.
39 Ora, o centurião, que estava defronte dele, vendo-o assim expirar, disse: Verdadeiramente este homem era filho de Deus.
40 Também ali estavam algumas mulheres olhando de longe, entre elas Maria Madalena, Maria, mãe de Tiago o Menor e de José, e Salomé;
41 as quais o seguiam e o serviam quando ele estava na Galiléia; e muitas outras que tinham subido com ele a Jerusalém.
42 Ao cair da tarde, como era o dia da preparação, isto é, a véspera do sábado,
43 José de Arimatéia, ilustre membro do sinédrio, que também esperava o reino de Deus, recobrando ânimo foi a Pilatos e pediu o corpo de Jesus.
44 Admirou-se Pilatos de que já tivesse morrido; e chamando o centurião, perguntou-lhe se, de fato, havia morrido.
45 E, depois que o soube do centurião, cedeu o cadáver a José;
46 o qual, tendo comprado um pano de linho, tirou da cruz o corpo, envolveu-o no pano e o depositou num sepulcro aberto em rocha; e rolou uma pedra para a porta do sepulcro.
47 E Maria Madalena e Maria, mãe de José, observavam onde fora posto.'),
  ('44444444-4444-4444-8444-444444444444', 16, 'Marcos 16', '1 Ora, passado o sábado, Maria Madalena, Maria, mãe de Tiago, e Salomé, compraram aromas para irem ungi-lo.
2 E, no primeiro dia da semana, foram ao sepulcro muito cedo, ao levantar do sol.
3 E diziam umas às outras: Quem nos revolverá a pedra da porta do sepulcro?
4 Mas, levantando os olhos, notaram que a pedra, que era muito grande, já estava revolvida;
5 e entrando no sepulcro, viram um moço sentado à direita, vestido de alvo manto; e ficaram atemorizadas.
6 Ele, porém, lhes disse: Não vos atemorizeis; buscais a Jesus, o nazareno, que foi crucificado; ele ressurgiu; não está aqui; eis o lugar onde o puseram.
7 Mas ide, dizei a seus discípulos, e a Pedro, que ele vai adiante de vós para a Galiléia; ali o vereis, como ele vos disse.
8 E, saindo elas, fugiram do sepulcro, porque estavam possuídas de medo e assombro; e não disseram nada a ninguém, porque temiam.
9 Ora, havendo Jesus ressurgido cedo no primeiro dia da semana, apareceu primeiramente a Maria Madalena, da qual tinha expulsado sete demônios.
10 Foi ela anunciá-lo aos que haviam andado com ele, os quais estavam tristes e chorando;
11 e ouvindo eles que vivia, e que tinha sido visto por ela, não o creram.
12 Depois disso manifestou-se sob outra forma a dois deles que iam de caminho para o campo,
13 os quais foram anunciá-lo aos outros; mas nem a estes deram crédito.
14 Por último, então, apareceu aos onze, estando eles reclinados à mesa, e lançou-lhes em rosto a sua incredulidade e dureza de coração, por não haverem dado crédito aos que o tinham visto já ressurgido.
15 E disse-lhes: Ide por todo o mundo, e pregai o evangelho a toda criatura.
16 Quem crer e for batizado será salvo; mas quem não crer será condenado.
17 E estes sinais acompanharão aos que crerem: em meu nome expulsarão demônios; falarão novas línguas;
18 pegarão em serpentes; e se beberem alguma coisa mortífera, não lhes fará dano algum; e porão as mãos sobre os enfermos, e estes serão curados.
19 Ora, o Senhor, depois de lhes ter falado, foi recebido no céu, e assentou-se à direita de Deus.
20 Eles, pois, saindo, pregaram por toda parte, cooperando com eles o Senhor, e confirmando a palavra com os sinais que os acompanhavam.')
on conflict (plan_id, dia) do update set referencia = excluded.referencia, texto = excluded.texto;
