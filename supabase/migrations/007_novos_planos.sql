-- ============ CONSTÂNCIA NA PALAVRA — novos planos de leitura (rodada 03/08) ============
-- Texto bíblico: João Ferreira de Almeida — DOMÍNIO PÚBLICO (mesma edição da seed original,
-- Provérbios 1:1 conferido byte-a-byte contra a 006 antes de gerar este arquivo).
-- Fonte: thiagobodruk/biblia (json/aa.json, Almeida, domínio público).
-- Dois planos novos: Mulheres da Bíblia (15 dias, curadoria temática) e
-- Evangelho de Marcos em 16 dias (plano simplificado/porta de entrada).
-- Idempotente: on conflict atualiza. Escrita via service role (migration).

insert into reading_plans (id, slug, titulo, descricao, total_dias, ordem, ativo) values
  ('33333333-3333-4333-8333-333333333333', 'mulheres-da-biblia', 'Mulheres da Bíblia', '15 dias, 15 mulheres — a fé, a coragem e a constância que atravessam a Escritura, do Antigo ao Novo Testamento.', 15, 3, true),
  ('44444444-4444-4444-8444-444444444444', 'marcos-16-dias', 'Evangelho de Marcos em 16 dias', 'O evangelho mais direto — ideal pra quem tá começando agora. Um capítulo por dia, sem enrolação.', 16, 4, true)
on conflict (slug) do update set titulo = excluded.titulo, descricao = excluded.descricao, total_dias = excluded.total_dias, ordem = excluded.ordem, ativo = excluded.ativo;

insert into reading_plan_days (plan_id, dia, referencia, texto) values
  ('33333333-3333-4333-8333-333333333333', 1, 'Rute 1', '1 Nos dias em que os juízes governavam, houve uma fome na terra; pelo que um homem de Belém de Judá saiu a peregrinar no país de Moabe, ele, sua mulher, e seus dois filhos.
2 Chamava-se este homem Elimeleque, e sua mulher Noêmi, e seus dois filhos se chamavam Malom e Quiliom; eram efrateus, de Belém de Judá. Tendo entrado no país de Moabe, ficaram ali.
3 E morreu Elimeleque, marido de Noêmi; e ficou ela com os seus dois filhos,
4 os quais se casaram com mulheres moabitas; uma destas se chamava Orfa, e a outra Rute; e moraram ali quase dez anos.
5 E morreram também os dois, Malom e Quiliom, ficando assim a mulher desamparada de seus dois filhos e de seu marido.
6 Então se levantou ela com as suas noras, para voltar do país de Moabe, porquanto nessa terra tinha ouvido que e Senhor havia visitado o seu povo, dando-lhe pão.
7 Pelo que saiu de lugar onde estava, e com ela as duas noras. Indo elas caminhando para voltarem para a terra de Judá,
8 disse Noêmi às suas noras: Ide, voltai, cada uma para a casa de sua mãe; e o Senhor use convosco de benevolência, como vós o fizestes com os falecidos e comigo.
9 O Senhor vos dê que acheis descanso cada uma em casa de seu marido. Quando as beijou, porém, levantaram a voz e choraram.
10 E disseram-lhe: Certamente voltaremos contigo para o teu povo.
11 Noêmi, porém, respondeu: Voltai, minhas filhas; porque ireis comigo? Tenho eu ainda filhos no meu ventre, para que vos viessem a ser maridos?
12 Voltai, filhas minhas; ide-vos, porque já sou velha demais para me casar. Ainda quando eu dissesse: Tenho esperança; ainda que esta noite tivesse marido e ainda viesse a ter filhos.
13 esperá-los-íeis até que viessem a ser grandes? deter-vos-íeis por eles, sem tomardes marido? Não, filhas minhas, porque mais amargo me é a mim do que a vós mesmas; porquanto a mão do Senhor se descarregou contra mim.
14 Então levantaram a voz, e tornaram a chorar; e Orfa beijou a sua sogra, porém Rute se apegou a ela.
15 Pelo que disse Noêmi: Eis que tua concunhada voltou para o seu povo e para os seus deuses; volta também tu após a tua concunhada.
16 Respondeu, porém, Rute: Não me instes a que te abandone e deixe de seguir-te. Porque aonde quer que tu fores, irei eu; e onde quer que pousares, ali pousarei eu; o teu povo será o meu povo, o teu Deus será o meu Deus.
17 Onde quer que morreres, morrerei eu, e ali serei sepultada. Assim me faça o Senhor, e outro tanto, se outra coisa que não seja a morte me separar de ti.
18 Vendo Noêmi que de todo estava resolvida a ir com ela, deixou de lhe falar nisso.
19 Assim, pois, foram-se ambas, até que chegaram a Belém. E sucedeu que, ao entrarem em Belém, toda a cidade se comoveu por causa delas, e as mulheres perguntavam: É esta, porventura, Noêmi?
20 Ela, porém, lhes respondeu: Não me chameis Noêmi; chamai-me Mara, porque o Todo-Poderoso me encheu de amargura.
21 Cheia parti, porém vazia o Senhor me fez tornar. Por que, pois, me chamais Noêmi, visto que o Senhor testemunhou contra mim, e o Todo-Poderoso me afligiu?
22 Assim Noêmi voltou, e com ela Rute, a moabita, sua nora, que veio do país de Moabe; e chegaram a Belém no principio da sega da cevada.'),
  ('33333333-3333-4333-8333-333333333333', 2, 'Rute 2', '1 Ora, tinha Noêmi um parente de seu marido, homem poderoso e rico, da família de Elimeleque; e ele se chamava Boaz.
2 Rute, a moabita, disse a Noêmi: Deixa-me ir ao campo a apanhar espigas atrás daquele a cujos olhos eu achar graça. E ela lhe respondeu: Vai, minha filha.
3 Foi, pois, e chegando ao campo respigava após os segadores; e caiu-lhe em sorte uma parte do campo de Boaz, que era da família de Elimeleque.
4 E eis que Boaz veio de Belém, e disse aos segadores: O Senhor seja convosco. Responderam-lhe eles: O Senhor te abençoe.
5 Depois perguntou Boaz ao moço que estava posto sobre os segadores: De quem é esta moça?
6 Respondeu-lhe o moço: Esta é a moça moabita que voltou com Noêmi do país de Moabe.
7 Disse-me ela: Deixa-me colher e ajuntar espigas por entre os molhos após os segadores: Assim ela veio, e está aqui desde pela manhã até agora, sem descansar nem sequer um pouco.
8 Então disse Boaz a Rute: Escuta filha minha; não vás colher em outro campo, nem tampouco passes daqui, mas ajunta-te às minhas moças.
9 Os teus olhos estarão atentos no campo que segarem, e irás após elas; não dei eu ordem aos moços, que não te molestem? Quando tiveres sede, vai aos vasos, e bebe do que os moços tiverem tirado.
10 Então ela, inclinando-se e prostrando-se com o rosto em terra, perguntou-lhe: Por que achei eu graça aos teus olhos, para que faças caso de mim, sendo eu estrangeira?
11 Ao que lhe respondeu Boaz: Bem se me contou tudo quanto tens feito para com tua sogra depois da morte de teu marido; como deixaste a teu pai e a tua mãe, e a terra onde nasceste, e vieste para um povo que dantes não conhecias.
12 O Senhor recompense o que fizeste, e te seja concedido pleno galardão da parte do Senhor Deus de Israel, sob cujas asas te vieste abrigar.
13 E disse ela: Ache eu graça aos teus olhos, senhor meu, pois me consolaste, e falaste bondosamente a tua serva, não sendo eu nem mesmo como uma das tuas criadas.
14 Também à hora de comer, disse-lhe Boaz: Achega-te, come do pão e molha o teu bocado no vinagre. E, sentando-se ela ao lado dos segadores, ele lhe ofereceu grão tostado, e ela comeu e ficou satisfeita, e ainda lhe sobejou.
15 Quando ela se levantou para respigar, Boaz deu ordem aos seus moços, dizendo: Até entre os molhos deixai-a respirar, e não a censureis.
16 Também, tirai dos molhos algumas espigas e deixai-as ficar, para que as colha, e não a repreendais.
17 Assim ela respigou naquele campo até a tarde; e debulhou o que havia apanhado e foi quase uma efa de cevada.
18 Então, carregando com a cevada, veio à cidade; e viu sua sogra o que ela havia apanhado. Também Rute tirou e deu-lhe o que lhe sobejara depois de fartar-se.
19 Ao que lhe perguntou sua sogra: Onde respigaste hoje, e onde trabalhaste? Bendito seja aquele que fez caso de ti. E ela relatou à sua sogra com quem tinha trabalhado, e disse: O nome do homem com quem hoje trabalhei é Boaz.
20 Disse Noêmi a sua nora: Bendito seja ele do Senhor, que não tem deixado de misturar a sua beneficência nem para com os vivos nem para com os mortos. Disse-lhe mais Noêmi: Esse homem é parente nosso, um dos nossos remidores.
21 Respondeu Rute, a moabita: Ele me disse ainda: Seguirás de perto os meus moços até que tenham acabado toda a minha sega.
22 Então disse Noêmi a sua nora, Rute: Bom é, filha minha, que saias com as suas moças, e que não te encontrem noutro campo.
23 Assim se ajuntou com as moças de Boaz, para respigar até e fim da sega da cevada e do trigo; e morava com a sua sogra.'),
  ('33333333-3333-4333-8333-333333333333', 3, 'Rute 3', '1 Depois lhe disse Noêmi, sua sogra: Minha filha, não te hei de buscar descanso, para que fiques bem?
2 Ora pois, não é Boaz, com cujas moças estiveste, de nossa parentela. Eis que esta noite ele vai joeirar a cevada na eira.
3 Lava-te pois, unge-te, veste os teus melhores vestidos, e desce à eira; porém não te dês a conhecer ao homem, até que tenha acabado de comer e beber.
4 E quando ele se deitar, notarás o lugar em que se deita; então entrarás, descobrir-lhe-ás os pés e te deitarás, e ele te dirá o que deves fazer.
5 Respondeu-lhe Rute: Tudo quanto me disseres, farei.
6 Então desceu à eira, e fez conforme tudo o que sua sogra lhe tinha ordenado.
7 Havendo, pois, Boaz comido e bebido, e estando já o seu coração alegre, veio deitar-se ao pé de uma meda; e vindo ela de mansinho, descobriu-lhe os pés, e se deitou.
8 Ora, pela meia-noite, o homem estremeceu, voltou-se, e viu uma mulher deitada aos seus pés.
9 E perguntou ele: Quem és tu? Ao que ela respondeu: Sou Rute, tua serva; estende a tua capa sobre a tua serva, porque tu és o remidor.
10 Então disse ele: Bendita sejas tu do Senhor, minha filha; mostraste agora mais bondade do que dantes, visto que após nenhum mancebo foste, quer pobre quer rico.
11 Agora, pois, minha filha, não temas; tudo quanto disseres te farei, pois toda a cidade do meu povo sabe que és mulher virtuosa.
12 Ora, é bem verdade que eu sou remidor, porém há ainda outro mais chegado do que eu.
13 Fica-te aqui esta noite, e será que pela manhã, se ele cumprir para contigo os deveres de remidor, que o faça; mas se não os quiser cumprir, então eu o farei tão certamente como vive o Senhor; deita-te até pela manhã.
14 Ficou, pois, deitada a seus pés até pela manhã, e levantou-se antes que fosse possível a uma pessoa reconhecer outra; porquanto ele disse: Não se saiba que uma mulher veio à eira.
15 Disse mais: Traze aqui a capa com que te cobres, e segura-a. Segurou-a, pois, e ele as mediu seis medidas de cevada, e lhas pôs no ombro. Então ela foi para a cidade.
16 Quando chegou à sua sogra, esta lhe perguntou: Como te houveste, minha filha? E ela lhe contou tudo quanto aquele homem lhe fizera.
17 Disse mais: Estas seis medidas de cevada ele mas deu, dizendo: Não voltarás vazia para tua sogra.
18 Então disse Noêmi: Espera, minha filha, até que saibas como irá terminar o caso; porque aquele homem não descansará enquanto não tiver concluído hoje este negócio.'),
  ('33333333-3333-4333-8333-333333333333', 4, 'Rute 4', '1 Boaz subiu à porta da cidade, e assentou-se ali. Quando o remidor de que ele havia falado ia passando, disse-lhe Boaz: Meu amigo, vem cá, assenta-te aqui. Ele se virou, e se assentou.
2 Então Boaz tomou dez homens dentre os anciãos da cidade, e lhes disse: Sentai-vos aqui. E eles se sentaram.
3 Disse Boaz ao remidor: Noêmi, que voltou da terra dos moabitas, vendeu a parte da terra que pertencia a Elimeleque; nosso irmão.
4 Resolvi informar-te disto, e dizer-te: Compra-a na presença dos que estão sentados aqui, na presença dos anciãos do meu povo; se hás de redimi-la, redime-a, e se não, declara-mo, para que o saiba, pois outro não há, senão tu, que a redima, e eu depois de ti. Então disse ele: Eu a redimirei.
5 Disse, porém, Boaz: No dia em que comprares o campo da mão de Noêmi, também tomarás a Rute, a moabita, que foi mulher do falecido, para suscitar o nome dele na sua herança.
6 Então disse o remidor: Não poderei redimi-lo para mim, para que não prejudique a minha própria herança; toma para ti o meu direito de remissão, porque eu não o posso fazer.
7 Outrora em Israel, para confirmar qualquer negócio relativo à remissão e à permuta, o homem descalçava o sapato e o dava ao seu próximo; e isto era por testemunho em Israel.
8 Dizendo, pois, o remidor a Boaz: Compra-a para ti, descalçou o sapato.
9 Então Boaz disse aos anciãos e a todo o povo: Sois hoje testemunhas de que comprei tudo quanto foi de Elimeleque, e de Quiliom, e de Malom, da mão de Noêmi,
10 e de que também tomei por mulher a Rute, a moabita, que foi mulher de Malom, para suscitar o nome do falecido na sua herança, para que a nome dele não seja desarraigado dentre seus irmãos e da porta do seu lugar; disto sois hoje testemunhas.
11 Ao que todo o povo que estava na porta e os anciãos responderam: Somos testemunhas. O Senhor faça a esta mulher, que entra na tua casa, como a Raquel e a Léia, que juntas edificaram a casa de Israel. Porta-te valorosamente em Efrata, e faze-te nome afamado em Belém.
12 Também seja a tua casa como a casa de Pérez, que Tamar deu a Judá, pela posteridade que o Senhor te der desta moça.
13 Assim tomou Boaz a Rute, e ela lhe foi por mulher; ele a conheceu, e o Senhor permitiu a Rute conceber, e ela teve um filho.
14 Disseram então as mulheres a Noêmi: Bendito seja o Senhor, que não te deixou hoje sem remidor; e torne-se o seu nome afamado em Israel.
15 Ele será restaurador da tua vida, e consolador da tua velhice, pois tua nora, que te ama, o deu à luz; ela te é melhor do que sete filhos.
16 E Noêmi tomou o menino, pô-lo no seu regaço, e foi sua ama.
17 E as vizinhas deram-lhe nome, dizendo: A Noêmi nasceu um filho, E chamaram ao menino Obede. Este é o pai de Jessé, pai de Davi.
18 São estas as gerações de Pérez: Pérez gerou a Hezrom,
19 Hezrom gerou a Rão, Rão gerou a Aminadabe,
20 Aminadabe gereu a Nasom, Nasom gerou a Salmom,
21 Salmom gerou a Boaz, Boaz gerou a Obede,
22 Obede gerou a Jessé, e Jessé gerou a Davi.'),
  ('33333333-3333-4333-8333-333333333333', 5, 'Gênesis 21', '1 O Senhor visitou a Sara, como tinha dito, e lhe fez como havia prometido.
2 Sara concebeu, e deu a Abraão um filho na sua velhice, ao tempo determinado, de que Deus lhe falara;
3 e, Abraão pôs no filho que lhe nascera, que Sara lhe dera, o nome de Isaque.
4 E Abraão circuncidou a seu filho Isaque, quando tinha oito dias, conforme Deus lhe ordenara.
5 Ora, Abraão tinha cem anos, quando lhe nasceu Isaque, seu filho.
6 Pelo que disse Sara: Deus preparou riso para mim; todo aquele que o ouvir, se rirá comigo.
7 E acrescentou: Quem diria a Abraão que Sara havia de amamentar filhos? no entanto lhe dei um filho na sua velhice.
8 cresceu o menino, e foi desmamado; e Abraão fez um grande banquete no dia em que Isaque foi desmamado.
9 Ora, Sara viu brincando o filho de Agar a egípcia, que esta dera à luz a Abraão.
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
26 Respondeu-lhe Abimeleque: Não sei quem fez isso; nem tu mo fizeste saber, nem tampouco ouvi eu falar nisso, senão hoje.
27 Tomou, pois, Abraão ovelhas e bois, e os deu a Abimeleque; assim fizeram entre, si um pacto.
28 Pôs Abraão, porém, à parte sete cordeiras do rebanho.
29 E perguntou Abimeleque a Abraão: Que significam estas sete cordeiras que puseste à parte?
30 Respondeu Abraão: Estas sete cordeiras receberás da minha mão para que me sirvam de testemunho de que eu cavei este poço.
31 Pelo que chamou aquele lugar Beer-Seba, porque ali os dois juraram.
32 Assim fizeram uma pacto em Beer-Seba. Depois se levantaram Abimeleque e Ficol, o chefe do seu exército, e tornaram para a terra dos filisteus.
33 Abraão plantou uma tamargueira em Beer-Seba, e invocou ali o nome do Senhor, o Deus eterno.
34 E peregrinou Abraão na terra dos filisteus muitos dias.'),
  ('33333333-3333-4333-8333-333333333333', 6, 'Êxodo 2', '1 Foi-se um homem da casa de Levi e casou com uma filha de Levi.
2 A mulher concebeu e deu à luz um filho; e, vendo que ele era formoso, escondeu-o três meses.
3 Não podendo, porém, escondê-lo por mais tempo, tomou para ele uma arca de juncos, e a revestiu de betume e pez; e, pondo nela o menino, colocou-a entre os juncos a margem do rio.
4 E sua irmã postou-se de longe, para saber o que lhe aconteceria.
5 A filha de Faraó desceu para banhar-se no rio, e as suas criadas passeavam à beira do rio. Vendo ela a arca no meio os juncos, mandou a sua criada buscá-la.
6 E abrindo-a, viu a criança, e eis que o menino chorava; então ela teve compaixão dele, e disse: Este é um dos filhos dos hebreus.
7 Então a irmã do menino perguntou à filha de Faraó: Queres que eu te vá chamar uma ama dentre as hebréias, para que crie este menino para ti?
8 Respondeu-lhe a filha de Faraó: Vai. Foi, pois, a moça e chamou a mãe do menino.
9 Disse-lhe a filha de Faraó: Leva este menino, e cria-mo; eu te darei o teu salário. E a mulher tomou o menino e o criou.
10 Quando, pois, o menino era já grande, ela o trouxe à filha de Faraó, a qual o adotou; e lhe chamou Moisés, dizendo: Porque das águas o tirei.
11 Ora, aconteceu naqueles dias que, sendo Moisés já homem, saiu a ter com seus irmãos e atentou para as suas cargas; e viu um egípcio que feria a um hebreu dentre, seus irmãos.
12 Olhou para um lado e para outro, e vendo que não havia ninguém ali, matou o egípcio e escondeu-o na areia.
13 Tornou a sair no dia seguinte, e eis que dois hebreus contendiam; e perguntou ao que fazia a injustiça: Por que feres a teu próximo?
14 Respondeu ele: Quem te constituiu a ti príncipe e juiz sobre nós? Pensas tu matar-me, como mataste o egípcio? Temeu, pois, Moisés e disse: Certamente o negócio já foi descoberto.
15 E quando Faraó soube disso, procurou matar a Moisés. Este, porém, fugiu da presença de Faraó, e foi habitar na terra de Midiã; e sentou-se junto a um poço.
16 O sacerdote de Midiã tinha sete filhas, as quais vieram tirar água, e encheram os tanques para dar de beber ao rebanho de seu pai.
17 Então vieram os pastores, e as expulsaram dali; Moisés, porém, levantou-se e as defendeu, e deu de beber ao rebanho delas.
18 Quando elas voltaram a Reuel, seu pai, este lhes perguntou: como é que hoje voltastes tão cedo?
19 Responderam elas: um egípcio nos livrou da mão dos pastores; e ainda tirou água para nós e deu de beber ao rebanho.
20 E ele perguntou a suas filhas: Onde está ele; por que deixastes lá o homem? chamai-o para que coma pão.
21 Então Moisés concordou em morar com aquele homem, o qual lhe deu sua filha Zípora.
22 E ela deu à luz um filho, a quem ele chamou Gérson, porque disse: Peregrino sou em terra estrangeira.
23 No decorrer de muitos dias, morreu o rei do Egito; e os filhos de Israel gemiam debaixo da servidão; pelo que clamaram, e subiu a Deus o seu clamor por causa dessa servidão.
24 Então Deus, ouvindo-lhes os gemidos, lembrou-se do seu pacto com Abraão, com Isaque e com Jacó.
25 E atentou Deus para os filhos de Israel; e Deus os conheceu.'),
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
9 Respondeu ela: Certamente irei contigo; porém não será tua a honra desta expedição, pois à mão de uma mulher o Senhor venderá a Sísera. Levantou-se, pois, Débora, e foi com Baraque a Quedes.
10 Então Baraque convocou a Zebulom e a Naftali em Quedes, e subiram dez mil homens após ele; também Débora subiu com ele.
11 Ora, Heber, um queneu, se tinha apartado dos queneus, dos filhos de Hobabe, sogro de Moisés, e tinha estendido as suas tendas até o carvalho de Zaananim, que está junto a Quedes.
12 Anunciaram a Sísera que Baraque, filho de Abinoão, tinha subido ao monte Tabor.
13 Sísera, pois, ajuntou todos os seus carros, novecentos carros de ferro, e todo o povo que estava com ele, desde Harosete dos Gentios até o ribeiro de Quisom.
14 Então disse Débora a Baraque: Levanta-te, porque este é o dia em que o Senhor entregou Sísera na tua mão; porventura o Senhor não saiu adiante de ti? Baraque, pois, desceu do monte Tabor, e dez mil homens após ele.
15 E o Senhor desbaratou a Sísera, com todos os seus carros e todo o seu exército, ao fio da espada, diante de Baraque; e Sísera, descendo do seu carro, fugiu a pé.
16 Mas Baraque perseguiu os carros e o exército, até Harosete dos Gentios; e todo o exército de Sísera caiu ao fio da espada; não restou um só homem.
17 Entretanto Sísera fugiu a pé para a tenda de Jael, mulher de Heber, o queneu, porquanto havia paz entre Jabim, rei de Hazor, e a casa de Heber, o queneu.
18 Saindo Jael ao encontro de Sísera, disse-lhe: Entra, senhor meu, entra aqui; não temas. Ele entrou na sua tenda; e ela o cobriu com uma coberta.
19 Então ele lhe disse: Peço-te que me dês a beber um pouco d&#x27;água, porque tenho sede. Então ela abriu um odre de leite, e deu-lhe de beber, e o cobriu.
20 Disse-lhe ele mais: Põe-te à porta da tenda; e se alguém vier e te perguntar: Está aqui algum homem? responderás: Não.
21 Então Jael, mulher de Heber, tomou uma estaca da tenda e, levando um martelo, chegou-se de mansinho a ele e lhe cravou a estaca na fonte, de sorte que penetrou na terra; pois ele estava num profundo sono e mui cansado. E assim morreu.
22 E eis que, seguindo Baraque a Sísera, Jael lhe saiu ao encontro e disse-lhe: Vem, e mostrar-te-ei o homem a quem procuras. Entrou ele na tenda; e eis que Sísera jazia morto, com a estaca na fonte.
23 Assim Deus naquele dia humilhou a Jabim, rei de Canaã, diante dos filhos de Israel.
24 E a mão dos filhos de Israel prevalecia cada vez mais contra Jabim, rei de Canaã, até que o destruíram.'),
  ('33333333-3333-4333-8333-333333333333', 9, '1 Samuel 1', '1 Houve um homem de Ramataim-Zofim, da região montanhosa de Efraim, cujo nome era Elcana, filho de Jeroão, filho de Eliú, filho de Toú, filho de Zufe, efraimita.
2 Tinha ele duas mulheres: uma se chamava Ana, e a outra Penina. Penina tinha filhos, porém Ana não os tinha.
3 De ano em ano este homem subia da sua cidade para adorar e sacrificar ao Senhor dos exércitos em Siló. Assistiam ali os sacerdotes do Senhor, Hofni e Finéias, os dois filhos de Eli.
4 No dia em que Elcana sacrificava, costumava dar quinhões a Penina, sua mulher, e a todos os seus filhos e filhas;
5 porém a Ana, embora a amasse, dava um só quinhão, porquanto o Senhor lhe havia cerrado a madre.
6 Ora, a sua rival muito a provocava para irritá-la, porque o Senhor lhe havia cerrado a madre.
7 E assim sucedia de ano em ano que, ao subirem à casa do Senhor, Penina provocava a Ana; pelo que esta chorava e não comia.
8 Então Elcana, seu marido, lhe perguntou: Ana, por que choras? e porque não comes? e por que está triste o teu coração? Não te sou eu melhor de que dez filhos?
9 Então Ana se levantou, depois que comeram e beberam em Siló; e Eli, sacerdote, estava sentado, numa cadeira, junto a um pilar do templo do Senhor.
10 Ela, pois, com amargura de alma, orou ao Senhor, e chorou muito,
11 e fez um voto, dizendo: ó Senhor dos exércitos! se deveras atentares para a aflição da tua serva, e de mim te lembrares, e da tua serva não te esqueceres, mas lhe deres um filho varão, ao Senhor o darei por todos os dias da sua vida, e pela sua cabeça não passará navalha.
12 Continuando ela a orar perante e Senhor, Eli observou a sua boca;
13 porquanto Ana falava no seu coração; só se moviam os seus lábios, e não se ouvia a sua voz; pelo que Eli a teve por embriagada,
14 e lhe disse: Até quando estarás tu embriagada? Aparta de ti o teu vinho.
15 Mas Ana respondeu: Não, Senhor meu, eu sou uma mulher atribulada de espírito; não bebi vinho nem bebida forte, porém derramei a minha alma perante o Senhor.
16 Não tenhas, pois, a tua serva por filha de Belial; porque da multidão dos meus cuidados e do meu desgosto tenho falado até agora.
17 Então lhe respondeu Eli: Vai-te em paz; e o Deus de Israel te conceda a petição que lhe fizeste.
18 Ao que disse ela: Ache a tua serva graça aos teus olhos. Assim a mulher se foi o seu caminho, e comeu, e já não era triste o seu semblante.
19 Depois, levantando-se de madrugada, adoraram perante o Senhor e, voltando, foram a sua casa em Ramá. Elcana conheceu a Ana, sua mulher, e o Senhor se lembrou dela.
20 De modo que Ana concebeu e, no tempo devido, teve um filho, ao qual chamou Samuel; porque, dizia ela, o tenho pedido ao Senhor.
21 Subiu, pois aquele homem, Elcana, com toda a sua casa, para oferecer ao Senhor o sacrifício anual e cumprir o seu voto.
22 Ana, porém, não subiu, pois disse a seu marido: Quando o menino for desmamado, então e levarei, para que apareça perante o Senhor, e lá fique para sempre.
23 E Elcana, seu marido, lhe disse: faze o que bem te parecer; fica até que o desmames; tão-somente confirme o Senhor a sua palavra. Assim ficou a mulher, e amamentou seu filho, até que o desmamou.
24 Depois de o ter desmamado, ela o tomou consigo, com um touro de três anos, uma efa de farinha e um odre de vinho, e o levou à casa do Senhor, em Siló; e era o menino ainda muito criança.
25 Então degolaram o touro, e trouxeram o menino a Eli;
26 e disse ela: Ah, meu Senhor! tão certamente como vive a tua alma, meu Senhor, eu sou aquela mulher que aqui esteve contigo, orando ao Senhor.
27 Por este menino orava eu, e o Senhor atendeu a petição que eu lhe fiz.
28 Por isso eu também o entreguei ao Senhor; por todos os dias que viver, ao Senhor está entregue. E adoraram ali ao Senhor.'),
  ('33333333-3333-4333-8333-333333333333', 10, '1 Samuel 25', '1 Ora, faleceu Samuel; e todo o Israel se ajuntou e o pranteou; e o sepultaram na sua casa, em Ramá. E Davi se levantou e desceu ao deserto de Parã.
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
  ('33333333-3333-4333-8333-333333333333', 11, 'Ester 4', '1 Quando Mordecai soube tudo quanto se havia passado, rasgou as suas vestes, vestiu-se de saco e de cinza, e saiu pelo meio da cidade, clamando com grande e amargo clamor;
2 e chegou até diante da porta do rei, pois ninguém vestido de saco podia entrar elas portas do rei.
3 Em todas as províncias aonde chegava a ordem do rei, e o seu decreto, havia entre os judeus grande pranto, com jejum, e choro, e lamentação; e muitos se deitavam em saco e em cinza.
4 Quando vieram as moças de Ester e os eunucos lho fizeram saber, a rainha muito se entristeceu; e enviou roupa para Mordecai, a fim de que, despindo-lhe o saco, lha vestissem; ele, porém, não a aceitou.
5 Então Ester mandou chamar Hataque, um dos eunucos do rei, que este havia designado para a servir, e o mandou ir ter com Mordecai para saber que era aquilo, e por que era.
6 Hataque, pois, saiu a ter com Mordecai à praça da cidade, diante da porta do rei;
7 e Mordecai lhe fez saber tudo quanto lhe tinha sucedido, como também a soma exata do dinheiro que Hamã prometera pagar ao tesouro do rei pela destruição dos judeus.
8 Também lhe deu a cópia do decreto escrito que se publicara em Susã para os destruir, para que a mostrasse a Ester, e lha explicasse, ordenando-lhe que fosse ter com o rei, e lhe pedisse misericórdia e lhe fizesse súplica ao seu povo.
9 Veio, pois, Hataque, e referiu a Ester as palavras de Mordecai.
10 Então falou Ester a Hataque, mandando-o dizer a Mordecai:
11 Todos os servos do rei, e o povo das províncias do rei, bem sabem que, para todo homem ou mulher que entrar à presença do rei no pátio interior sem ser chamado, não há senão uma sentença, a de morte, a menos que o rei estenda para ele o cetro de ouro, para que viva; mas eu já há trinta dias não sou chamada para entrar a ter com o rei.
12 E referiram a Mordecai as palavras de Ester.
13 Então Mordecai mandou que respondessem a Ester: Não imagines que, por estares no palácio do rei, terás mais sorte para escapar do que todos os outros judeus.
14 Pois, se de todo te calares agora, de outra parte se levantarão socorro e livramento para os judeus, mas tu e a casa de teu pai perecereis; e quem sabe se não foi para tal tempo como este que chegaste ao reino?
15 De novo Ester mandou-os responder a Mordecai:
16 Vai, ajunta todos os judeus que se acham em Susã, e jejuai por mim, e não comais nem bebais por três dias, nem de noite nem de dia; e eu e as minhas moças também assim jejuaremos.  Depois irei ter com o rei, ainda que isso não é segundo a lei;  e se eu perecer, pereci.
17 Então Mordecai foi e fez conforme tudo quanto Ester lhe ordenara.'),
  ('33333333-3333-4333-8333-333333333333', 12, 'Ester 7', '1 Entraram, pois, o rei e Hamã para se banquetearem com a rainha Ester.
2 Ainda outra vez disse o rei a Ester, no segundo dia, durante o banquete do vinho: Qual é a tua petição, rainha Ester?  e ser-te-á concedida;  e qual é o teu rogo?  Até metade do reino se te dará.
3 Então respondeu a rainha Ester, e disse: Ó rei!  se eu tenho alcançado o teu favor, e se parecer bem ao rei, seja-me concedida a minha vida, eis a minha petição, e o meu povo, eis o meu rogo;
4 porque fomos vendidos, eu e o meu povo, para sermos destruídos, mortos e exterminados; se ainda por servos e por servas nos tivessem vendido, eu teria me calado, ainda que o adversário não poderia ter compensado a perda do rei.
5 Então falou o rei Assuero, e disse à rainha Ester: Quem é e onde está esse, cujo coração o instigou a fazer assim?
6 Respondeu Ester: Um adversário e inimigo, este perverso Hamã!  Então Hamã ficou aterrorizado perante o rei e a rainha.
7 E o rei, no seu furor, se levantou do banquete do vinho e entrou no jardim do palácio; Hamã, porém, ficou para rogar à rainha Ester pela sua vida, porque viu que já o mal lhe estava determinado pelo rei.
8 Ora, o rei voltou do jardim do palácio à sala do banquete do vinho; e Hamã havia caído prostrado sobre o leito em que estava Ester.  Então disse o rei:  Porventura quereria ele também violar a rainha perante mim na minha própria casa?  Ao sair essa palavra da boca do rei, cobriram a Hamã o rosto.
9 Então disse Harbona, um dos eunucos que serviam diante do rei: Eis que a forca de cinqüenta côvados de altura que Hamã fizera para Mordecai, que falara em defesa do rei, está junto à casa de Hamã.  Então disse o rei:  Enforcai-o nela.
10 Enforcaram-no, pois, na forca que ele tinha preparado para Mordecai. Então o furor do rei se aplacou.'),
  ('33333333-3333-4333-8333-333333333333', 13, 'Lucas 1', '1 Visto que muitos têm empreendido fazer uma narração coordenada dos fatos que entre nós se realizaram,
2 segundo no-los transmitiram os que desde o princípio foram testemunhas oculares e ministros da palavra,
3 também a mim, depois de haver investido tudo cuidadosamente desde o começo, pareceu-me bem, ó excelentíssimo Teófilo, escrever-te uma narração em ordem.
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
54 Auxiliou a Isabel, seu servo, lembrando-se de misericórdia
55 {como falou a nossos pais} para com Abraão e a sua descendência para sempre.
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
78 graças à entranhável misericórdia do nosso Deus, pela qual nos há de visitar a aurora lá do alto,
79 para alumiar aos que jazem nas trevas e na sombra da morte, a fim de dirigir os nossos pés no caminho da paz.
80 Ora, o menino crescia, e se robustecia em espírito; e habitava nos desertos até o dia da sua manifestação a Israel.'),
  ('33333333-3333-4333-8333-333333333333', 14, 'João 4', '1 Quando, pois, o Senhor soube que os fariseus tinham ouvido dizer que ele, Jesus, fazia e batizava mais discípulos do que João
2 {ainda que Jesus mesmo não batizava, mas os seus discípulos}
3 deixou a Judéia, e foi outra vez para a Galiléia.
4 E era-lhe necessário passar por Samária.
5 Chegou, pois, a uma cidade de Samária, chamada Sicar, junto da herdade que Jacó dera a seu filho José;
6 achava-se ali o poço de Jacó. Jesus, pois, cansado da viagem, sentou-se assim junto do poço; era cerca da hora sexta.
7 Veio uma mulher de Samária tirar água. Disse-lhe Jesus: Dá-me de beber.
8 Pois seus discípulos tinham ido à cidade comprar comida.
9 Disse-lhe então a mulher samaritana: Como, sendo tu judeu, me pedes de beber a mim, que sou mulher samaritana? {Porque os judeus não se comunicavam com os samaritanos.}
10 Respondeu-lhe Jesus: Se tivesses conhecido o dom de Deus e quem é o que te diz: Dá-me de beber, tu lhe terias pedido e ele te haveria dado água viva.
11 Disse-lhe a mulher: Senhor, tu não tens com que tirá-la, e o poço é fundo; donde, pois, tens essa água viva?
12 És tu, porventura, maior do que o nosso pai Jacó, que nos deu o poço, do qual também ele mesmo bebeu, e os filhos, e o seu gado?.
13 Replicou-lhe Jesus: Todo o que beber desta água tornará a ter sede;
14 mas aquele que beber da água que eu lhe der nunca terá sede; pelo contrário, a água que eu lhe der se fará nele uma fonte de água que jorre para a vida eterna.
15 Disse-lhe a mulher: Senhor, dá-me dessa água, para que não mais tenha sede, nem venha aqui tirá-la.
16 Disse-lhe Jesus: Vai, chama o teu marido e vem cá.
17 Respondeu a mulher: Não tenho marido. Disse-lhe Jesus: Disseste bem: Não tenho marido;
18 porque cinco maridos tiveste, e o que agora tens não é teu marido; isso disseste com verdade.
19 Disse-lhe a mulher: Senhor, vejo que és profeta.
20 Nossos pais adoraram neste monte, e vós dizeis que em Jerusalém é o lugar onde se deve adorar.
21 Disse-lhe Jesus: Mulher, crê-me, a hora vem, em que nem neste monte, nem em Jerusalém adorareis o Pai.
22 Vós adorais o que não conheceis; nós adoramos o que conhecemos; porque a salvação vem dos judeus.
23 Mas a hora vem, e agora é, em que os verdadeiros adoradores adorarão o Pai em espírito e em verdade; porque o Pai procura a tais que assim o adorem.
24 Deus é Espírito, e é necessário que os que o adoram o adorem em espírito e em verdade.
25 Replicou-lhe a mulher: Eu sei que vem o Messias {que se chama o Cristo}; quando ele vier há de nos anunciar todas as coisas.
26 Disse-lhe Jesus: Eu o sou, eu que falo contigo.
27 E nisto vieram os seus discípulos, e se admiravam de que estivesse falando com uma mulher; todavia nenhum lhe perguntou: Que é que procuras? ou: Por que falas com ela?
28 Deixou, pois, a mulher o seu cântaro, foi à cidade e disse àqueles homens:
29 Vinde, vede um homem que me disse tudo quanto eu tenho feito; será este, porventura, o Cristo?
30 Saíram, pois, da cidade e vinham ter com ele.
31 Entrementes os seus discípulos lhe rogavam, dizendo: Rabi, come.
32 Ele, porém, respondeu: Uma comida tenho para comer que vós não conheceis.
33 Então os discípulos diziam uns aos outros: Acaso alguém lhe trouxe de comer?
34 Disse-lhes Jesus: A minha comida é fazer a vontade daquele que me enviou, e completar a sua obra.
35 Não dizeis vós: Ainda há quatro meses até que venha a ceifa? Ora, eu vos digo: levantai os vossos olhos, e vede os campos, que já estão brancos para a ceifa.
36 Quem ceifa já está recebendo recompensa e ajuntando fruto para a vida eterna; para que o que semeia e o que ceifa juntamente se regozijem.
37 Porque nisto é verdadeiro o ditado: Um é o que semeia, e outro o que ceifa.
38 Eu vos enviei a ceifar onde não trabalhaste; outros trabalharam, e vós entrastes no seu trabalho.
39 E muitos samaritanos daquela cidade creram nele, por causa da palavra da mulher, que testificava: Ele me disse tudo quanto tenho feito.
40 Indo, pois, ter com ele os samaritanos, rogaram-lhe que ficasse com eles; e ficou ali dois dias.
41 E muitos mais creram por causa da palavra dele;
42 e diziam à mulher: Já não é pela tua palavra que nós cremos; pois agora nós mesmos temos ouvido e sabemos que este é verdadeiramente o Salvador do mundo.
43 Passados os dois dias partiu dali para a Galiléia.
44 Porque Jesus mesmo testificou que um profeta não recebe honra na sua própria pátria.
45 Assim, pois, que chegou à Galiléia, os galileus o receberam, porque tinham visto todas as coisas que fizera em Jerusalém na ocasião da festa; pois também eles tinham ido à festa.
46 Foi, então, outra vez a Caná da Galiléia, onde da água fizera vinho. Ora, havia um oficial do rei, cujo filho estava enfermo em Cafarnaum.
47 Quando ele soube que Jesus tinha vindo da Judéia para a Galiléia, foi ter com ele, e lhe rogou que descesse e lhe curasse o filho; pois estava à morte.
48 Então Jesus lhe disse: Se não virdes sinais e prodígios, de modo algum crereis.
49 Rogou-lhe o oficial: Senhor, desce antes que meu filho morra.
50 Respondeu-lhe Jesus: Vai, o teu filho vive. E o homem creu na palavra que Jesus lhe dissera, e partiu.
51 Quando ele já ia descendo, saíram-lhe ao encontro os seus servos, e lhe disseram que seu filho vivia.
52 Perguntou-lhes, pois, a que hora começara a melhorar; ao que lhe disseram: Ontem à hora sétima a febre o deixou.
53 Reconheceu, pois, o pai ser aquela hora a mesma em que Jesus lhe dissera: O teu filho vive; e creu ele e toda a sua casa.
54 Foi esta a segunda vez que Jesus, ao voltar da Judéia para a Galiléia, ali operou sinal.'),
  ('33333333-3333-4333-8333-333333333333', 15, 'Atos 16', '1 Chegou também a Derbe e Listra. E eis que estava ali certo discípulo por nome Timóteo, filho de uma judia crente, mas de pai grego;
2 do qual davam bom testemunho os irmãos em Listra e Icônio.
3 Paulo quis que este fosse com ele e, tomando-o, o circuncidou por causa dos judeus que estavam naqueles lugares; porque todos sabiam que seu pai era grego.
4 Quando iam passando pelas cidades, entregavam aos irmãos, para serem observadas, as decisões que haviam sido tomadas pelos apóstolos e anciãos em Jerusalém.
5 Assim as igrejas eram confirmadas na fé, e dia a dia cresciam em número.
6 Atravessaram a região frígio-gálata, tendo sido impedidos pelo Espírito Santo de anunciar a palavra na Ásia;
7 e tendo chegado diante da Mísia, tentavam ir para Bitínia, mas o Espírito de Jesus não lho permitiu.
8 Então, passando pela Mísia, desceram a Trôade.
9 De noite apareceu a Paulo esta visão: estava ali em pé um homem da Macedônia, que lhe rogava: Passa à Macedônia e ajuda-nos.
10 E quando ele teve esta visão, procurávamos logo partir para a Macedônia, concluindo que Deus nos havia chamado para lhes anunciarmos o evangelho.
11 Navegando, pois, de Trôade, fomos em direitura a Samotrácia, e no dia seguinte a Neápolis;
12 e dali para Filipos, que é a primeira cidade desse distrito da Macedônia, e colônia romana; e estivemos alguns dias nessa cidade.
13 No sábado saímos portas afora para a beira do rio, onde julgávamos haver um lugar de oração e, sentados, falávamos às mulheres ali reunidas.
14 E certa mulher chamada Lídia, vendedora de púrpura, da cidade de Tiatira, e que temia a Deus, nos escutava e o Senhor lhe abriu o coração para atender às coisas que Paulo dizia.
15 Depois que foi batizada, ela e a sua casa, rogou-nos, dizendo: Se haveis julgado que eu sou fiel ao Senhor, entrai em minha casa, e ficai ali. E nos constrangeu a isso.
16 Ora, aconteceu que quando íamos ao lugar de oração, nos veio ao encontro uma jovem que tinha um espírito adivinhador, e que, adivinhando, dava grande lucro a seus senhores.
17 Ela, seguindo a Paulo e a nós, clamava, dizendo: São servos do Deus Altíssimo estes homens que vos anunciam um caminho de salvação.
18 E fazia isto por muitos dias. Mas Paulo, perturbado, voltou-se e disse ao espírito: Eu te ordeno em nome de Jesus Cristo que saias dela. E na mesma hora saiu.
19 Ora, vendo seus senhores que a esperança do seu lucro havia desaparecido, prenderam a Paulo e Silas, e os arrastaram para uma praça à presença dos magistrados.
20 E, apresentando-os aos magistrados, disseram: Estes homens, sendo judeus, estão perturbando muito a nossa cidade,
21 e pregam costumes que não nos é lícito receber nem praticar, sendo nós romanos.
22 A multidão levantou-se à uma contra eles, e os magistrados, rasgando-lhes os vestidos, mandaram açoitá-los com varas.
23 E, havendo-lhes dado muitos açoites, os lançaram na prisão, mandando ao carcereiro que os guardasse com segurança.
24 Ele, tendo recebido tal ordem, os lançou na prisão interior e lhes segurou os pés no tronco.
25 Pela meia-noite Paulo e Silas oravam e cantavam hinos a Deus, enquanto os presos os escutavam.
26 De repente houve um tão grande terremoto que foram abalados os alicerces do cárcere, e logo se abriram todas as portas e foram soltos os grilhões de todos.
27 Ora, o carcereiro, tendo acordado e vendo abertas as portas da prisão, tirou a espada e ia suicidar-se, supondo que os presos tivessem fugido.
28 Mas Paulo bradou em alta voz, dizendo: Não te faças nenhum mal, porque todos aqui estamos.
29 Tendo ele pedido luz, saltou dentro e, todo trêmulo, se prostrou ante Paulo e Silas
30 e, tirando-os para fora, disse: Senhores, que me é necessário fazer para me salvar?
31 Responderam eles: Crê no Senhor Jesus e serás salvo, tu e tua casa.
32 Então lhe pregaram a palavra de Deus, e a todos os que estavam em sua casa.
33 Tomando-os ele consigo naquela mesma hora da noite, lavou-lhes as feridas; e logo foi batizado, ele e todos os seus.
34 Então os fez subir para sua casa, pôs-lhes a mesa e alegrou-se muito com toda a sua casa, por ter crido em Deus.
35 Quando amanheceu, os magistrados mandaram quadrilheiros a dizer: Soltai aqueles homens.
36 E o carcereiro transmitiu a Paulo estas palavras, dizendo: Os magistrados mandaram que fosseis soltos; agora, pois, saí e ide em paz.
37 Mas Paulo respondeu-lhes: Açoitaram-nos publicamente sem sermos condenados, sendo cidadãos romanos, e nos lançaram na prisão, e agora encobertamente nos lançam fora? De modo nenhum será assim; mas venham eles mesmos e nos tirem.
38 E os quadrilheiros foram dizer aos magistrados estas palavras, e estes temeram quando ouviram que eles eram romanos;
39 vieram, pediram-lhes desculpas e, tirando-os para fora, rogavam que se retirassem da cidade.
40 Então eles saíram da prisão, entraram em casa de Lídia, e, vendo os irmãos, os confortaram, e partiram.'),
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
13 E esteve no deserto quarenta dias sentado tentado por Satanás; estava entre as feras, e os anjos o serviam.
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
32 Sendo já tarde, tendo-se posto o sol, traziam-lhe todos os enfermos, e os endemoninhados;
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
2 Ajuntaram-se, pois, muitos, a ponta de não caberem nem mesmo diante da porta; e ele lhes anunciava a palavra.
3 Nisso vieram alguns a trazer-lhe um paralítico, carregado por quatro;
4 e não podendo aproximar-se dele, por causa da multidão, descobriram o telhado onde estava e, fazendo uma abertura, baixaram o leito em que jazia o paralítico.
5 E Jesus, vendo-lhes a fé, disse ao paralítico: Filho, perdoados são os teus pecados.
6 Ora, estavam ali sentados alguns dos escribas, que arrazoavam em seus corações, dizendo:
7 Por que fala assim este homem? Ele blasfema. Quem pode perdoar pecados senão um só, que é Deus?
8 Mas Jesus logo percebeu em seu espírito que eles assim arrazoavam dentro de si, e perguntou-lhes: Por que arrazoais desse modo em vossos corações?
9 Qual é mais fácil? dizer ao paralítico: Perdoados são os teus pecados; ou dizer: Levanta-te, toma o teu leito, e anda?
10 Ora, para que saibais que o Filho do homem tem sobre a terra autoridade para perdoar pecados { disse ao paralítico },
11 a ti te digo, levanta-te, toma o teu leito, e vai para tua casa.
12 Então ele se levantou e, tomando logo o leito, saiu à vista de todos; de modo que todos pasmavam e glorificavam a Deus, dizendo: Nunca vimos coisa semelhante.
13 Outra vez saiu Jesus para a beira do mar; e toda a multidão ia ter com ele, e ele os ensinava.
14 Quando ia passando, viu a Levi, filho de Alfeu, sentado na coletoria, e disse-lhe: Segue-me. E ele, levantando-se, o seguiu.
15 Ora, estando Jesus à mesa em casa de Levi, estavam também ali reclinados com ele e seus discípulos muitos publicanos e pecadores; pois eram em grande número e o seguiam.
16 Vendo os escribas dos fariseus que comia com os publicanos e pecadores, perguntavam aos discípulos: Por que é que ele como com os publicanos e pecadores?
17 Jesus, porém, ouvindo isso, disse-lhes: Não necessitam de médico os sãos, mas sim os enfermos; eu não vim chamar justos, mas pecadores.
18 Ora, os discípulos de João e os fariseus estavam jejuando; e foram perguntar-lhe: Por que jejuam os discípulos de João e os dos fariseus, mas os teus discípulos não jejuam?
19 Respondeu-lhes Jesus: Podem, porventura, jejuar os convidados às núpcias, enquanto está com eles o noivo? Enquanto têm consigo o noivo não podem jejuar;
20 dias virão, porém, em que lhes será tirado o noivo; nesses dias, sim hão de jejuar.
21 Ninguém cose remendo de pano novo em vestido velho; do contrário o remendo novo tira parte do velho, e torna-se maior a rotura.
22 E ninguém deita vinho novo em odres velhos; do contrário, o vinho novo romperá os odres, e perder-se-á o vinho e também os odres; mas deita-se vinho novo em odres novos.
23 E sucedeu passar ele num dia de sábado pelas searas; e os seus discípulos, caminhando, começaram a colher espigas.
24 E os fariseus lhe perguntaram: Olha, por que estão fazendo no sábado o que não é lícito?
25 Respondeu-lhes ele: Acaso nunca lestes o que fez Davi quando se viu em necessidade e teve fome, ele e seus companheiros?
26 Como entrou na casa de Deus, no tempo do sumo sacerdote Abiatar, e comeu dos pães da proposição, dos quais não era lícito comer senão aos sacerdotes, e deu também aos companheiros?
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
33 E com muitas parábolas tais lhes dirigia a palavra, conforme podiam compreender.
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
2 Ora, chegando o sábado, começou a ensinar na sinagoga; e muitos, ao ouvi-lo, se maravilhavam, dizendo: Donde lhe vêm estas coisas? e que sabedoria é esta que lhe é dada? e como se fazem tais milagres por suas mãos?
3 Não é este o carpinteiro, filho de Maria, irmão de Tiago, de José, de Judas e de Simão? e não estão aqui entre nós suas irmãs? E escandalizavam-se dele.
4 Então Jesus lhes dizia: Um profeta não fica sem honra senão na sua terra, entre os seus parentes, e na sua própria casa.
5 E não podia fazer ali nenhum milagre, a não ser curar alguns poucos enfermos, impondo-lhes as mãos.
6 E admirou-se da incredulidade deles. Em seguida percorria as aldeias circunvizinhas, ensinando.
7 E chamou a si os doze, e começou a enviá-los a dois e dois, e dava-lhes poder sobre os espíritos imundos;
8 ordenou-lhes que nada levassem para o caminho, senão apenas um bordão; nem pão, nem alforje, nem dinheiro no cinto;
9 mas que fossem calçados de sandálias, e que não vestissem duas túnicas.
10 Dizia-lhes mais: Onde quer que entrardes numa casa, ficai nela até sairdes daquele lugar.
11 E se qualquer lugar não vos receber, nem os homens vos ouvirem, saindo dali, sacudi o pó que estiver debaixo dos vossos pés, em testemunho conta eles.
12 Então saíram e pregaram que todos se arrependessem;
13 e expulsavam muitos demônios, e ungiam muitos enfermos com óleo, e os curavam.
14 E soube disso o rei Herodes {porque o nome de Jesus se tornara célebre}, e disse: João, o Batista, ressuscitou dos mortos; e por isso estes poderes milagrosos operam nele.
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
40 E reclinaram-se em grupos de cem e de cinqüenta.
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
11 Mas vós dizeis: Se um homem disser a seu pai ou a sua mãe: Aquilo que poderias aproveitar de mim é Corbã, isto é, oferta ao Senhor,
12 não mais lhe permitis fazer coisa alguma por seu pai ou por sua mãe,
13 invalidando assim a palavra de Deus pela vossa tradição que vós transmitistes; também muitas outras coisas semelhantes fazeis.
14 E chamando a si outra vez a multidão, disse-lhes: Ouvi-me vós todos, e entendei.
15 Nada há fora do homem que, entrando nele, possa contaminá-lo; mas o que sai do homem, isso é que o contamina.
16 {Se alguém tem ouvidos para ouvir, ouça.}
17 Depois, quando deixou a multidão e entrou em casa, os seus discípulos o interrogaram acerca da parábola.
18 Respondeu-lhes ele: Assim também vós estais sem entender? Não compreendeis que tudo o que de fora entra no homem não o pode contaminar,
19 porque não lhe entra no coração, mas no ventre, e é lançado fora? Assim declarou puros todos os alimentos.
20 E prosseguiu: O que sai do homem , isso é que o contamina.
21 Pois é do interior, do coração dos homens, que procedem os maus pensamentos, as prostituições, os furtos, os homicídios, os adultérios,
22 a cobiça, as maldades, o dolo, a libertinagem, a inveja, a blasfêmia, a soberba, a insensatez;
23 todas estas más coisas procedem de dentro e contaminam o homem.
24 Levantando-se dali, foi para as regiões de Tiro e Sidom. E entrando numa casa, não queria que ninguém o soubesse, mas não pode ocultar-se;
25 porque logo, certa mulher, cuja filha estava possessa de um espírito imundo, ouvindo falar dele, veio e prostrou-se-lhe aos pés;
26 {ora, a mulher era grega, de origem siro-fenícia} e rogava-lhe que expulsasse de sua filha o demônio.
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
37 Ou que diria o homem em troca da sua vida?
38 Porquanto, qualquer que, entre esta geração adúltera e pecadora, se envergonhar de mim e das minhas palavras, também dele se envergonhará o Filho do homem quando vier na glória de seu Pai com os santos anjos.'),
  ('44444444-4444-4444-8444-444444444444', 9, 'Marcos 9', '1 Disse-lhes mais: Em verdade vos digo que, dos que aqui estão, alguns há que de modo nenhum provarão a morte até que vejam o reino de Deus já chegando com poder.
2 Seis dias depois tomou Jesus consigo a Pedro, a Tiago, e a João, e os levou à parte sós, a um alto monte; e foi transfigurado diante deles;
3 as suas vestes tornaram-se resplandecentes, extremamente brancas, tais como nenhum lavandeiro sobre a terra as poderia branquear.
4 E apareceu-lhes Elias com Moisés, e falavam com Jesus.
5 Pedro, tomando a palavra, disse a Jesus: Mestre, bom é estarmos aqui; façamos, pois, três cabanas, uma para ti, outra para Moisés, e outra para Elias.
6 Pois não sabia o que havia de dizer, porque ficaram atemorizados.
7 Nisto veio uma nuvem que os cobriu, e dela saiu uma voz que dizia: Este é o meu Filho amado; a ele ouvi.
8 De repente, tendo olhado em redor, não viram mais a ninguém consigo, senão só a Jesus.
9 Enquanto desciam do monte, ordenou-lhes que a ninguém contassem o que tinham visto, até que o Filho do homem ressurgisse dentre os mortos.
10 E eles guardaram o caso em segredo, indagando entre si o que seria o ressurgir dentre os mortos.
11 Então lhe perguntaram: Por que dizem os escribas que é necessário que Elias venha primeiro?
12 Respondeu-lhes Jesus: Na verdade Elias havia de vir primeiro, a restaurar todas as coisas; e como é que está escrito acerca do Filho do homem que ele deva padecer muito a ser aviltado?
13 Digo-vos, porém, que Elias já veio, e fizeram-lhe tudo quanto quiseram, como dele está escrito.
14 Quando chegaram aonde estavam os discípulos, viram ao redor deles uma grande multidão, e alguns escribas a discutirem com eles.
15 E logo toda a multidão, vendo a Jesus, ficou grandemente surpreendida; e correndo todos para ele, o saudavam.
16 Perguntou ele aos escribas: Que é que discutis com eles?
17 Respondeu-lhe um dentre a multidão: Mestre, eu te trouxe meu filho, que tem um espírito mudo;
18 e este, onde quer que o apanha, convulsiona-o, de modo que ele espuma, range os dentes, e vai definhando; e eu pedi aos teus discípulos que o expulsassem, e não puderam.
19 Ao que Jesus lhes respondeu: ó geração incrédula! até quando estarei convosco? até quando vos hei de suportar? Trazei-mo.
20 Então lho trouxeram; e quando ele viu a Jesus, o espírito imediatamente o convulsionou; e o endemoninhado, caindo por terra, revolvia-se espumando.
21 E perguntou Jesus ao pai dele: Há quanto tempo sucede-lhe isto? Respondeu ele: Desde a infância;
22 e muitas vezes o tem lançado no fogo, e na água, para o destruir; mas se podes fazer alguma coisa, tem compaixão de nós e ajuda-nos.
23 Ao que lhe disse Jesus: Se podes!-tudo é possível ao que crê.
24 Imediatamente o pai do menino, clamando, {com lágrimas} disse: Creio! Ajuda a minha incredulidade.
25 E Jesus, vendo que a multidão, correndo, se aglomerava, repreendeu o espírito imundo, dizendo: Espírito mudo e surdo, eu te ordeno: Sai dele, e nunca mais entres nele.
26 E ele, gritando, e agitando-o muito, saiu; e ficou o menino como morto, de modo que a maior parte dizia: Morreu.
27 Mas Jesus, tomando-o pela mão, o ergueu; e ele ficou em pé.
28 E quando entrou em casa, seus discípulos lhe perguntaram à parte: Por que não pudemos nós expulsá-lo?
29 Respondeu-lhes: Esta casta não sai de modo algum, salvo à força de oração {e jejum.}
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
44 {onde o seu verme não morre, e o fogo não se apaga.}
45 Ou, se o teu pé te fizer tropeçar, corta-o; melhor é entrares coxo na vida, do que, tendo dois pés, seres lançado no inferno.
46 {onde o seu verme não morre, e o fogo não se apaga.}
47 Ou, se o teu olho te fizer tropeçar, lança-o fora; melhor é entrares no reino de Deus com um só olho, do que, tendo dois olhos, seres lançado no inferno.
48 onde o seu verme não morre, e o fogo não se apaga.
49 Porque cada um será salgado com fogo.
50 Bom é o sal; mas, se o sal se tornar insípido, com que o haveis de temperar? Tende sal em vós mesmos, e guardai a paz uns com os outros.'),
  ('44444444-4444-4444-8444-444444444444', 10, 'Marcos 10', '1 Levantando-se Jesus, partiu dali para os termos da Judéia, e para além do Jordão; e do novo as multidões se reuniram em torno dele; e tornou a ensiná-las, como tinha por costume.
2 Então se aproximaram dele alguns fariseus e, para o experimentarem, lhe perguntaram: É lícito ao homem repudiar sua mulher?
3 Ele, porém, respondeu-lhes: Que vos ordenou Moisés?
4 Replicaram eles: Moisés permitiu escrever carta de divórcio, e repudiar a mulher.
5 Disse-lhes Jesus: Pela dureza dos vossos corações ele vos deixou escrito esse mandamento.
6 Mas desde o princípio da criação, Deus os fez homem e mulher.
7 Por isso deixará o homem a seu pai e a sua mãe, {e unir-se-á à sua mulher,}
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
24 E os discípulos se maravilharam destas suas palavras; mas Jesus, tornando a falar, disse-lhes: Filhos, quão difícil é {para os que confiam nas riquezas} entrar no reino de Deus!
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
51 Perguntou-lhe o cego: Que queres que te faça? Respondeu-lhe o cego: Mestre, que eu veja.
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
24 Por isso vos digo que tudo o que pedirdes em oração, crede que o recebereis, e tê-lo-eis.
25 Quando estiverdes orando, perdoai, se tendes alguma coisa contra alguém, para que também vosso Pai que está no céu, vos perdoe as vossas ofensas.
26 {Mas, se vós não perdoardes, também vosso Pai, que está no céu, não vos perdoará as vossas ofensas.}
27 Vieram de novo a Jerusalém. E andando Jesus pelo templo, aproximaram-se dele os principais sacerdotes, os escribas e os anciãos,
28 que lhe perguntaram: Com que autoridade fazes tu estas coisas? ou quem te deu autoridade para fazê-las?
29 Respondeu-lhes Jesus: Eu vos perguntarei uma coisa; respondei-me, pois, e eu vos direi com que autoridade faço estas coisas.
30 O batismo de João era do céu, ou dos homens? respondei-me.
31 Ao que eles arrazoavam entre si: Se dissermos: Do céu, ele dirá: Então por que não o crestes?
32 Mas diremos, porventura: Dos homens?-É que temiam o povo; porque todos verdadeiramente tinham a João como profeta.
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
42 Vindo, porém, uma pobre viúva, lançou dois leptos, que valiam um quadrante.
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
14 Ora, quando vós virdes a abominação da desolação estar onde não deve estar {quem lê, entenda}, então os que estiverem na Judéia fujam para os montes;
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
  ('44444444-4444-4444-8444-444444444444', 14, 'Marcos 14', '1 Ora, dali a dois dias era a páscoa e a festa dos pães ázimos; e os principais sacerdotes e os escribas andavam buscando como prender Jesus a traição, para o matarem.
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
25 Em verdade vos digo que não beberei mais do fruto da videira, até aquele dia em que o beber, novo, no reino de Deus.
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
41 Ao voltar pela terceira vez, disse-lhes: Dormi agora e descansai.-Basta; é chegada a hora. Eis que o Filho do homem está sendo entregue nas mãos dos pecadores.
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
55 Os principais sacerdotes testemunho contra Jesus para o matar, e não o achavam.
56 Porque contra ele muitos depunham falsamente, mas os testemunhos não concordavam.
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
16 Os soldados, pois, levaram-no para dentro, ao pátio, que é o pretório, e convocaram toda a corte;
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
28 {E cumpriu-se a escritura que diz: E com os malfeitores foi contado.}
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
43 José de Arimatéia, ilustre membro do sinédrio, que também esperava o reino de Deus, cobrando ânimo foi Pilatos e pediu o corpo de Jesus.
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
