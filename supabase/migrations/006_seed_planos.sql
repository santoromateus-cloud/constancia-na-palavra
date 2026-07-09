-- ============ CONSTÂNCIA NA PALAVRA — seed dos planos de leitura ============
-- Texto bíblico: João Ferreira de Almeida — DOMÍNIO PÚBLICO.
-- Fonte: seven1m/open-bibles (por-almeida.usfx.xml). Extraído e formatado automaticamente.
-- Dois planos: Provérbios em 31 dias (Pv 1–31) e Evangelho de João em 21 dias (Jo 1–21).
-- Idempotente: on conflict atualiza. Escrita via service role (migration).

insert into reading_plans (id, slug, titulo, descricao, total_dias, ordem, ativo) values
  ('11111111-1111-4111-8111-111111111111', 'proverbios-31-dias', 'Provérbios em 31 dias', 'Um capítulo de Provérbios por dia — sabedoria prática pra cada dia do mês.', 31, 1, true),
  ('22222222-2222-4222-8222-222222222222', 'joao-21-dias', 'Evangelho de João em 21 dias', 'Um capítulo do Evangelho de João por dia — conhecer Jesus de perto.', 21, 2, true)
on conflict (slug) do update set titulo = excluded.titulo, descricao = excluded.descricao, total_dias = excluded.total_dias, ordem = excluded.ordem, ativo = excluded.ativo;

insert into reading_plan_days (plan_id, dia, referencia, texto) values
  ('11111111-1111-4111-8111-111111111111', 1, 'Provérbios 1', '1 Provérbios de Salomão, filho de Davi, rei de Israel:
2 Para se conhecer a sabedoria e a instrução; para se entenderem as palavras de inteligência;
3 para se instruir em sábio procedimento, em retidão, justiça e eqüidade;
4 para se dar aos simples prudência, e aos jovens conhecimento e bom siso.
5 Ouça também, o sábio e cresça em ciência, e o entendido adquira habilidade,
6 para entender provérbios e parábolas, as palavras dos sábios, e seus enigmas.
7 O temor do Senhor é o princípio do conhecimento; mas os insensatos desprezam a sabedoria e a instrução.
8 Filho meu, ouve a instrução de teu pai, e não deixes o ensino de tua mãe.
9 Porque eles serão uma grinalda de graça para a tua cabeça, e colares para o teu pescoço.
10 Filho meu, se os pecadores te quiserem seduzir, não consintas.
11 Se disserem: Vem conosco; embosquemo-nos para derramar sangue; espreitemos sem razão o inocente;
12 traguemo-los vivos, como o Seol, e inteiros como os que descem à cova;
13 acharemos toda sorte de bens preciosos; encheremos as nossas casas de despojos;
14 lançarás a tua sorte entre nós; teremos todos uma só bolsa;
15 filho meu, não andes no caminho com eles; guarda da sua vereda o teu pé,
16 porque os seus pés correm para o mal, e eles se apressam a derramar sangue.
17 Pois debalde se estende a rede à vista de qualquer ave.
18 Mas estes se põem em emboscadas contra o seu próprio sangue, e as suas próprias vidas espreitam.
19 Tais são as veredas de todo aquele que se entrega à cobiça; ela tira a vida dos que a possuem.
20 A suprema sabedoria altissonantemente clama nas ruas; nas praças levanta a sua voz.
21 Do alto dos muros clama; às entradas das portas e na cidade profere as suas palavras:
22 Até quando, ó estúpidos, amareis a estupidez? e até quando se deleitarão no escárnio os escarnecedores, e odiarão os insensatos o conhecimento?
23 Convertei-vos pela minha repreensão; eis que derramarei sobre vós o meu; espírito e vos farei saber as minhas palavras.
24 Mas, porque clamei, e vós recusastes; porque estendi a minha mão, e nao houve quem desse atenção;
25 antes desprezastes todo o meu conselho, e não fizestes caso da minha repreensão;
26 também eu me rirei no dia da vossa calamidade; zombarei, quando sobrevier o vosso terror,
27 quando o terror vos sobrevier como tempestade, e a vossa calamidade passar como redemoinho, e quando vos sobrevierem aperto e angústia.
28 Então a mim clamarão, mas eu não responderei; diligentemente me buscarão, mas não me acharão.
29 Porquanto aborreceram o conhecimento, e não preferiram o temor do Senhor;
30 não quiseram o meu conselho e desprezaram toda a minha repreensão;
31 portanto comerão do fruto do seu caminho e se fartarão dos seus próprios conselhos.
32 Porque o desvio dos néscios os matará, e a prosperidade dos loucos os destruirá.
33 Mas o que me der ouvidos habitará em segurança, e estará tranqüilo, sem receio do mal.'),
  ('11111111-1111-4111-8111-111111111111', 2, 'Provérbios 2', '1 Filho meu, se aceitares as minhas palavras, e entesourares contigo os meus mandamentos,
2 para fazeres atento à sabedoria o teu ouvido, e para inclinares o teu coração ao entendimento;
3 sim, se clamares por discernimento, e por entendimento alçares a tua voz;
4 se o buscares como a prata e o procurares como a tesouros escondidos;
5 então entenderás o temor do Senhor, e acharás o conhecimento de Deus.
6 Porque o Senhor dá a sabedoria; da sua boca procedem o conhecimento e o entendimento;
7 ele reserva a verdadeira sabedoria para os retos; e escudo para os que caminham em integridade,
8 guardando-lhes as veredas da justiça, e preservando o caminho dos seus santos.
9 Então entenderás a retidão, a justiça, a eqüidade, e todas as boas veredas.
10 Pois a sabedoria entrará no teu coração, e o conhecimento será aprazível à tua alma;
11 o bom siso te protegerá, e o discernimento e guardará;
12 para te livrar do mau caminho, e do homem que diz coisas perversas;
13 dos que deixam as veredas da retidão, para andarem pelos caminhos das trevas;
14 que se alegram de fazer o mal, e se deleitam nas perversidades dos maus;
15 dos que são tortuosos nas suas veredas; e iníquos nas suas carreiras;
16 e para te livrar da mulher estranha, da estrangeira que lisonjeia com suas palavras;
17 a qual abandona o companheiro da sua mocidade e se esquece do concerto do seu Deus;
18 pois a sua casa se inclina para a morte, e as suas veredas para as sombras.
19 Nenhum dos que se dirigirem a ela, tornara a sair, nem retomará as veredas da vida.
20 Assim andarás pelo caminho dos bons, e guardarás as veredas dos justos.
21 Porque os retos habitarão a terra, e os íntegros permanecerão nela.
22 Mas os ímpios serão exterminados da terra, e dela os aleivosos serão desarraigados.'),
  ('11111111-1111-4111-8111-111111111111', 3, 'Provérbios 3', '1 Filho meu, não te esqueças da minha instrução, e o teu coração guarde os meus mandamentos;
2 porque eles te darão longura de dias, e anos de vida e paz.
3 Não se afastem de ti a benignidade e a fidelidade; ata-as ao teu pescoço, escreve-as na tábua do teu coração;
4 assim acharás favor e bom entendimento à vista de Deus e dos homens.
5 Confia no Senhor de todo o teu coração, e não te estribes no teu próprio entendimento.
6 Reconhece-o em todos os teus caminhos, e ele endireitará as tuas veredas.
7 Não sejas sábio a teus próprios olhos; teme ao Senhor e aparta-te do mal.
8 Isso será saúde para a tua carne; e refrigério para os teus ossos.
9 Honra ao Senhor com os teus bens, e com as primícias de toda a tua renda;
10 assim se encherão de fartura os teus celeiros, e trasbordarão de mosto os teus lagares.
11 Filho meu, não rejeites a disciplina do Senhor, nem te enojes da sua repreensão;
12 porque o Senhor repreende aquele a quem ama, assim como o pai ao filho a quem quer bem.
13 Feliz é o homem que acha sabedoria, e o homem que adquire entendimento;
14 pois melhor é o lucro que ela dá do que o lucro da prata, e a sua renda do que o ouro.
15 Mais preciosa é do que as jóias, e nada do que possas desejar é comparável a ela.
16 Longura de dias há na sua mão direita; na sua esquerda riquezas e honra.
17 Os seus caminhos são caminhos de delícias, e todas as suas veredas são paz.
18 É árvore da vida para os que dela lançam mão, e bem-aventurado é todo aquele que a retém.
19 O Senhor pela sabedoria fundou a terra; pelo entendimento estabeleceu o céu.
20 Pelo seu conhecimento se fendem os abismos, e as nuvens destilam o orvalho.
21 Filho meu, não se apartem estas coisas dos teus olhos: guarda a verdadeira sabedoria e o bom siso;
22 assim serão elas vida para a tua alma, e adorno para o teu pescoço.
23 Então andarás seguro pelo teu caminho, e não tropeçará o teu pé.
24 Quando te deitares, não temerás; sim, tu te deitarás e o teu sono será suave.
25 Não temas o pavor repentino, nem a assolação dos ímpios quando vier.
26 Porque o Senhor será a tua confiança, e guardará os teus pés de serem presos.
27 Não negues o bem a quem de direito, estando no teu poder fazê-lo.
28 Não digas ao teu próximo: Vai, e volta, amanhã to darei; tendo-o tu contigo.
29 Não maquines o mal contra o teu próximo, que habita contigo confiadamente.
30 Não contendas com um homem, sem motivo, não te havendo ele feito o mal.
31 Não tenhas inveja do homem violento, nem escolhas nenhum de seus caminhos.
32 Porque o perverso é abominação para o Senhor, mas com os retos está o seu segredo.
33 A maldição do Senhor habita na casa do ímpio, mas ele abençoa a habitação dos justos.
34 Ele escarnece dos escarnecedores, mas dá graça aos humildes.
35 Os sábios herdarão honra, mas a exaltação dos loucos se converte em ignomínia.'),
  ('11111111-1111-4111-8111-111111111111', 4, 'Provérbios 4', '1 Ouvi, filhos, a instrução do pai, e estai atentos para conhecerdes o entendimento.
2 Pois eu vos dou boa doutrina; não abandoneis o meu ensino.
3 Quando eu era filho aos pés de meu, pai, tenro e único em estima diante de minha mãe,
4 ele me ensinava, e me dizia: Retenha o teu coração as minhas palavras; guarda os meus mandamentos, e vive.
5 Adquire a sabedoria, adquire o entendimento; não te esqueças nem te desvies das palavras da minha boca.
6 Não a abandones, e ela te guardará; ama-a, e ela te preservará.
7 A sabedoria é a coisa principal; adquire, pois, a sabedoria; sim, com tudo o que possuis adquire o entendimento.
8 Estima-a, e ela te exaltará; se a abraçares, ela te honrará.
9 Ela dará à tua cabeça uma grinalda de graça; e uma coroa de glória te entregará.
10 Ouve, filho meu, e aceita as minhas palavras, para que se multipliquem os anos da tua vida.
11 Eu te ensinei o caminho da sabedoria; guiei-te pelas veredas da retidão.
12 Quando andares, não se embaraçarão os teus passos; e se correres, não tropeçarás.
13 Apega-te à instrução e não a largues; guarda-a, porque ela é a tua vida.
14 Não entres na vereda dos ímpios, nem andes pelo caminho dos maus.
15 Evita-o, não passes por ele; desvia-te dele e passa de largo.
16 Pois não dormem, se não fizerem o mal, e foge deles o sono se não fizerem tropeçar alguém.
17 Porque comem o pão da impiedade, e bebem o vinho da violência.
18 Mas a vereda dos justos é como a luz da aurora que vai brilhando mais e mais até ser dia perfeito.
19 O caminho dos ímpios é como a escuridão: não sabem eles em que tropeçam.
20 Filho meu, atenta para as minhas palavras; inclina o teu ouvido às minhas instroções.
21 Não se apartem elas de diante dos teus olhos; guarda-as dentro do teu coração.
22 Porque são vida para os que as encontram, e saúde para todo o seu corpo.
23 Guarda com toda a diligência o teu coração, porque dele procedem as fontes da vida.
24 Desvia de ti a malignidade da boca, e alonga de ti a perversidade dos lábios.
25 Dirijam-se os teus olhos para a frente, e olhem as tuas pálpebras diretamente diante de ti.
26 Pondera a vereda de teus pés, e serão seguros todos os teus caminhos.
27 Não declines nem para a direita nem para a esquerda; retira o teu pé do mal.'),
  ('11111111-1111-4111-8111-111111111111', 5, 'Provérbios 5', '1 Filho meu, atende à minha sabedoria; inclinão teu ouvido à minha prudência;
2 para que observes a discrição, e os teus lábios guardem o conhecimento.
3 Porque os lábios da mulher licenciosa destilam mel, e a sua boca e mais macia do que o azeite;
4 mas o seu fim é amargoso como o absinto, agudo como a espada de dois gumes.
5 Os seus pés descem à morte; os seus passos seguem no caminho do Seol.
6 Ela não pondera a vereda da vida; incertos são os seus caminhos, e ela o ignora.
7 Agora, pois, filhos, dai-me ouvidos, e não vos desvieis das palavras da minha boca.
8 Afasta para longe dela o teu caminho, e não te aproximes da porta da sua casa;
9 para que não dês a outros a tua honra, nem os teus anos a cruéis;
10 para que não se fartem os estranhos dos teus bens, e não entrem os teus trabalhos na casa do estrangeiro,
11 e gemas no teu fim, quando se consumirem a tua carne e o teu corpo,
12 e digas: Como detestei a disciplina! e desprezou o meu coração a repreensão!
13 e não escutei a voz dos que me ensinavam, nem aos que me instruíam inclinei o meu ouvido!
14 Quase cheguei à ruína completa, no meio da congregação e da assembléia.
15 Bebe a água da tua própria cisterna, e das correntes do teu poço.
16 Derramar-se-iam as tuas fontes para fora, e pelas ruas os ribeiros de águas?
17 Sejam para ti só, e não para os estranhos juntamente contigo.
18 Seja bendito o teu manancial; e regozija-te na mulher da tua mocidade.
19 Como corça amorosa, e graciosa cabra montesa saciem-te os seus seios em todo o tempo; e pelo seu amor sê encantado perpetuamente.
20 E por que, filho meu, andarias atraído pela mulher licenciosa, e abraÇarias o seio da adúltera?
21 Porque os caminhos do homem estão diante dos olhos do Senhor, o qual observa todas as suas veredas.
22 Quanto ao ímpio, as suas próprias iniqüidades o prenderão, e pelas cordas do seu pecado será detido.
23 Ele morre pela falta de disciplina; e pelo excesso da sua loucura anda errado.'),
  ('11111111-1111-4111-8111-111111111111', 6, 'Provérbios 6', '1 Filho meu, se ficaste por fiador do teu próximo, se te empenhaste por um estranho,
2 estás enredado pelos teus lábios; estás preso pelas palavras da tua boca.
3 Faze pois isto agora, filho meu, e livra-te, pois já caíste nas mãos do teu próximo; vai, humilha-te, e importuna o teu próximo;
4 não dês sono aos teus olhos, nem adormecimento às tuas pálpebras;
5 livra-te como a gazela da mão do caçador, e como a ave da mão do passarinheiro.
6 Vai ter com a formiga, ó preguiçoso, considera os seus caminhos, e sê sábio;
7 a qual, não tendo chefe, nem superintendente, nem governador,
8 no verão faz a provisão do seu mantimento, e ajunta o seu alimento no tempo da ceifa.
9 o preguiçoso, até quando ficarás deitador? quando te levantarás do teu sono?
10 um pouco para dormir, um pouco para toscanejar, um pouco para cruzar as mãos em repouso;
11 assim te sobrevirá a tua pobreza como um ladrão, e a tua necessidade como um homem armado.
12 O homem vil, o homem iníquo, anda com a perversidade na boca,
13 pisca os olhos, faz sinais com os pés, e acena com os dedos;
14 perversidade há no seu coração; todo o tempo maquina o mal; anda semeando contendas.
15 Pelo que a sua destruição virá repentinamente; subitamente será quebrantado, sem que haja cura.
16 Há seis coisas que o Senhor detesta; sim, há sete que ele abomina:
17 olhos altivos, língua mentirosa, e mãos que derramam sangue inocente;
18 coração que maquina projetos iníquos, pés que se apressam a correr para o mal;
19 testemunha falsa que profere mentiras, e o que semeia contendas entre irmãos.
20 Filho meu, guarda o mandamento de, teu pai, e não abandones a instrução de tua mãe;
21 ata-os perpetuamente ao teu coração, e pendura-os ao teu pescoço.
22 Quando caminhares, isso te guiará; quando te deitares, te guardará; quando acordares, falará contigo.
23 Porque o mandamento é uma lâmpada, e a instrução uma luz; e as repreensões da disciplina são o caminho da vida,
24 para te guardarem da mulher má, e das lisonjas da língua da adúltera.
25 Não cobices no teu coração a sua formosura, nem te deixes prender pelos seus olhares.
26 Porque o preço da prostituta é apenas um bocado de pão, mas a adúltera anda à caça da própria vida do homem.
27 Pode alguém tomar fogo no seu seio, sem que os seus vestidos se queimem?
28 Ou andará sobre as brasas sem que se queimem os seus pés?
29 Assim será o que entrar à mulher do seu proximo; não ficará inocente quem a tocar.
30 Não é desprezado o ladrão, mesmo quando furta para saciar a fome?
31 E, se for apanhado, pagará sete vezes tanto, dando até todos os bens de sua casa.
32 O que adultera com uma mulher é falto de entendimento; destrói-se a si mesmo, quem assim procede.
33 Receberá feridas e ignomínia, e o seu opróbrio nunca se apagará;
34 porque o ciúme enfurece ao marido, que de maneira nenhuma poupará no dia da vingança.
35 Não aceitará resgate algum, nem se aplacará, ainda que multipliques os presentes.'),
  ('11111111-1111-4111-8111-111111111111', 7, 'Provérbios 7', '1 Filho meu, guarda as minhas palavras, e entesoura contigo os meus mandamentos.
2 Observa os meus mandamentos e vive; guarda a minha lei, como a menina dos teus olhos.
3 Ata-os aos teus dedos, escreve-os na tábua do teu coração.
4 Dize à sabedoria: Tu és minha irmã; e chama ao entendimento teu amigo íntimo,
5 para te guardarem da mulher alheia, da adúltera, que lisonjeia com as suas palavras.
6 Porque da janela da minha casa, por minhas grades olhando eu,
7 vi entre os simples, divisei entre os jovens, um mancebo falto de juízo,
8 que passava pela rua junto à esquina da mulher adúltera e que seguia o caminho da sua casa,
9 no crepúsculo, à tarde do dia, à noite fechada e na escuridão;
10 e eis que uma mulher lhe saiu ao encontro, ornada à moda das prostitutas, e astuta de coração.
11 Ela é turbulenta e obstinada; não param em casa os seus pés;
12 ora está ela pelas ruas, ora pelas praças, espreitando por todos os cantos.
13 Pegou dele, pois, e o beijou; e com semblante impudico lhe disse:
14 Sacrifícios pacíficos tenho comigo; hoje paguei os meus votos.
15 Por isso saí ao teu encontro a buscar-te diligentemente, e te achei.
16 Já cobri a minha cama de cobertas, de colchas de linho do Egito.
17 Já perfumei o meu leito com mirra, aloés e cinamomo.
18 Vem, saciemo-nos de amores até pela manhã; alegremo-nos com amores.
19 Porque meu marido não está em casa; foi fazer uma jornada ao longe;
20 um saquitel de dinheiro levou na mão; só lá para o dia da lua cheia voltará para casa.
21 Ela o faz ceder com a multidão das suas palavras sedutoras, com as lisonjas dos seus lábios o arrasta.
22 Ele a segue logo, como boi que vai ao matadouro, e como o louco ao castigo das prisões;
23 até que uma flecha lhe atravesse o fígado, como a ave que se apressa para o laço, sem saber que está armado contra a sua vida.
24 Agora, pois, filhos, ouvi-me, e estai atentos às palavras da minha boca.
25 Não se desvie para os seus caminhos o teu coração, e não andes perdido nas suas veredas.
26 Porque ela a muitos tem feito cair feridos; e são muitíssimos os que por ela foram mortos.
27 Caminho de Seol é a sua casa, o qual desce às câmaras da morte.'),
  ('11111111-1111-4111-8111-111111111111', 8, 'Provérbios 8', '1 Não clama porventura a sabedoria, e não faz o entendimento soar a sua voz?
2 No cume das alturas, junto ao caminho, nas encruzilhadas das veredas ela se coloca.
3 Junto às portas, à entrada da cidade, e à entrada das portas está clamando:
4 A vós, ó homens, clamo; e a minha voz se dirige aos filhos dos homens.
5 Aprendei, ó simples, a prudência; entendei, ó loucos, a sabedoria.
6 Ouvi vós, porque profiro coisas excelentes; os meus lábios se abrem para a eqüidade.
7 Porque a minha boca profere a verdade, os meus lábios abominam a impiedade.
8 Justas são todas as palavras da minha boca; não há nelas nenhuma coisa tortuosa nem perversa.
9 Todas elas são retas para o que bem as entende, e justas para os que acham o conhecimento.
10 Aceitai antes a minha correção, e não a prata; e o conhecimento, antes do que o ouro escolhido.
11 Porque melhor é a sabedoria do que as jóias; e de tudo o que se deseja nada se pode comparar com ela.
12 Eu, a sabedoria, habito com a prudência, e possuo o conhecimento e a discrição.
13 O temor do Senhor é odiar o mal; a soberba, e a arrogância, e o mau caminho, e a boca perversa, eu os odeio.
14 Meu é o conselho, e a verdadeira sabedoria; eu sou o entendimento; minha é a fortaleza.
15 Por mim reinam os reis, e os príncipes decretam o que justo.
16 Por mim governam os príncipes e os nobres, sim, todos os juízes da terra.
17 Eu amo aos que me amam, e os que diligentemente me buscam me acharão.
18 Riquezas e honra estão comigo; sim, riquezas duráveis e justiça.
19 Melhor é o meu fruto do que o ouro, sim, do que o ouro refinado; e a minha renda melhor do que a prata escolhida.
20 Ando pelo caminho da retidão, no meio das veredas da justiça,
21 dotando de bens permanentes os que me amam, e enchendo os seus tesouros.
22 O Senhor me criou como a primeira das suas obras, o princípio dos seus feitos mais antigos.
23 Desde a eternidade fui constituída, desde o princípio, antes de existir a terra.
24 Antes de haver abismos, fui gerada, e antes ainda de haver fontes cheias d''água.
25 Antes que os montes fossem firmados, antes dos outeiros eu nasci,
26 quando ele ainda não tinha feito a terra com seus campos, nem sequer o princípio do pó do mundo.
27 Quando ele preparava os céus, aí estava eu; quando traçava um círculo sobre a face do abismo,
28 quando estabelecia o firmamento em cima, quando se firmavam as fontes do abismo,
29 quando ele fixava ao mar o seu termo, para que as águas não traspassassem o seu mando, quando traçava os fundamentos da terra,
30 então eu estava ao seu lado como arquiteto; e era cada dia as suas delícias, alegrando-me perante ele em todo o tempo;
31 folgando no seu mundo habitável, e achando as minhas delícias com os filhos dos homens.
32 Agora, pois, filhos, ouvi-me; porque felizes são os que guardam os meus caminhos.
33 Ouvi a correção, e sede sábios; e não a rejeiteis.
34 Feliz é o homem que me dá ouvidos, velando cada dia às minhas entradas, esperando junto às ombreiras da minha porta.
35 Porque o que me achar achará a vida, e alcançará o favor do Senhor.
36 Mas o que pecar contra mim fará mal à sua própria alma; todos os que me odeiam amam a morte.'),
  ('11111111-1111-4111-8111-111111111111', 9, 'Provérbios 9', '1 A sabedoria já edificou a sua casa, já lavrou as suas sete colunas;
2 já imolou as suas vítimas, misturou o seu vinho, e preparou a sua mesa.
3 Já enviou as suas criadas a clamar sobre as alturas da cidade, dizendo:
4 Quem é simples, volte-se para cá. Aos faltos de entendimento diz:
5 Vinde, comei do meu pão, e bebei do vinho que tenho misturado.
6 Deixai a insensatez, e vivei; e andai pelo caminho do entendimento.
7 O que repreende ao escarnecedor, traz afronta sobre si; e o que censura ao ímpio, recebe a sua mancha.
8 Não repreendas ao escarnecedor, para que não te odeie; repreende ao sábio, e amar-te-á.
9 Instrui ao sábio, e ele se fará mais, sábio; ensina ao justo, e ele crescerá em entendimento.
10 O temor do Senhor é o princípio sabedoria; e o conhecimento do Santo é o entendimento.
11 Porque por mim se multiplicam os teus dias, e anos de vida se te acrescentarão.
12 Se fores sábio, para ti mesmo o serás; e, se fores escarnecedor, tu só o suportarás.
13 A mulher tola é alvoroçadora; é insensata, e não conhece o pudor.
14 Senta-se à porta da sua casa ou numa cadeira, nas alturas da cidade,
15 chamando aos que passam e seguem direitos o seu caminho:
16 Quem é simples, volte-se para cá! E aos faltos de entendimento diz:
17 As águas roubadas são doces, e o pão comido às ocultas é agradável.
18 Mas ele não sabe que ali estão os mortos; que os seus convidados estão nas profundezas do Seol.'),
  ('11111111-1111-4111-8111-111111111111', 10, 'Provérbios 10', '1 Provérbios de Salomão. Um filho sábio alegra a seu pai; mas um filho insensato é a tristeza de sua mae.
2 Os tesouros da impiedade de nada aproveitam; mas a justiça livra da morte.
3 O Senhor não deixa o justo passar fome; mas o desejo dos ímpios ele rechaça.
4 O que trabalha com mão remissa empobrece; mas a mão do diligente enriquece.
5 O que ajunta no verão é filho prudente; mas o que dorme na sega é filho que envergonha.
6 Bênçãos caem sobre a cabeça do justo; porém a boca dos ímpios esconde a violência.
7 A memória do justo é abençoada; mas o nome dos ímpios apodrecerá.
8 O sábio de coração aceita os mandamentos; mas o insensato palra dor cairá.
9 Quem anda em integridade anda seguro; mas o que perverte os seus caminhos será conhecido.
10 O que acena com os olhos dá dores; e o insensato palrador cairá.
11 A boca do justo é manancial de vida, porém a boca dos ímpios esconde a violência.
12 O ódio excita contendas; mas o amor cobre todas as transgressões.
13 Nos lábios do entendido se acha a sabedoria; mas a vara é para as costas do que é falto de entendimento.
14 Os sábios entesouram o conhecimento; porém a boca do insensato é uma destruição iminente.
15 Os bens do rico são a sua cidade forte; a ruína dos pobres é a sua pobreza.
16 O trabalho do justo conduz à vida; a renda do ímpio, para o pecado.
17 O que atende à instrução está na vereda da vida; mas o que rejeita a repreensão anda errado.
18 O que encobre o ódio tem lábios falsos; e o que espalha a calúnia é um insensato.
19 Na multidão de palavras não falta transgressão; mas o que refreia os seus lábios é prudente.
20 A língua do justo é prata escolhida; o coração dos ímpios é de pouco valor.
21 Os lábios do justo apascentam a muitos; mas os insensatos, por falta de entendimento, morrem.
22 A bênção do Senhor é que enriquece; e ele não a faz seguir de dor alguma.
23 E um divertimento para o insensato o praticar a iniqüidade; mas a conduta sábia é o prazer do homem entendido.
24 O que o ímpio teme, isso virá sobre ele; mas aos justos se lhes concederá o seu desejo.
25 Como passa a tempestade, assim desaparece o impio; mas o justo tem fundamentos eternos.
26 Como vinagre para os dentes, como fumaça para os olhos, assim é o preguiçoso para aqueles que o mandam.
27 O temor do Senhor aumenta os dias; mas os anos os impios serão abreviados.
28 A esperança dos justos é alegria; mas a expectação dos ímpios perecerá.
29 O caminho do Senhor é fortaleza para os retos; mas é destruição para os que praticam a iniqüidade.
30 O justo nunca será abalado; mas os ímpios não habitarão a terra.
31 A boca do justo produz sabedoria; porém a língua perversa será desarraigada.
32 Os lábios do justo sabem o que agrada; porém a boca dos ímpios fala perversidades.'),
  ('11111111-1111-4111-8111-111111111111', 11, 'Provérbios 11', '1 A balança enganosa é abominação para o Senhor; mas o peso justo é o seu prazer.
2 Quando vem a soberba, então vem a desonra; mas com os humildes está a sabedoria.
3 A integridade dos retos os guia; porém a perversidade dos desleais os destrói.
4 De nada aproveitam as riquezas no dia da ira; porém a justiça livra da morte.
5 A justiça dos perfeitos endireita o seu caminho; mas o ímpio cai pela sua impiedade.
6 A justiça dos retos os livra; mas os traiçoeiros são apanhados nas, suas próprias cobiças.
7 Morrendo o ímpio, perece a sua esperança; e a expectativa da iniqüidade.
8 O justo é libertado da angústia; e o ímpio fica em seu lugar.
9 O hipócrita com a boca arruína o seu proximo; mas os justos são libertados pelo conhecimento.
10 Quando os justos prosperam, exulta a cidade; e quando perecem os ímpios, há júbilo.
11 Pela bênção dos retos se exalta a cidade; mas pela boca dos ímpios é derrubada.
12 Quem despreza o seu próximo é falto de senso; mas o homem de entendimento se cala.
13 O que anda mexericando revela segredos; mas o fiel de espírito encobre o negócio.
14 Quando não há sábia direção, o povo cai; mas na multidão de conselheiros há segurança.
15 Decerto sofrerá prejuízo aquele que fica por fiador do estranho; mas o que aborrece a fiança estará seguro.
16 A mulher aprazível obtém honra, e os homens violentos obtêm riquezas.
17 O homem bondoso faz bem à sua, própria alma; mas o cruel faz mal a si mesmo.
18 O ímpio recebe um salário ilusório; mas o que semeia justiça recebe galardão seguro.
19 Quem é fiel na retidão encaminha, para a vida, e aquele que segue o mal encontra a morte.
20 Abominação para o Senhor são os perversos de coração; mas os que são perfeitos em seu caminho são o seu deleite.
21 Decerto o homem mau não ficará sem castigo; porém a descendência dos justos será livre.
22 Como jóia de ouro em focinho de porca, assim é a mulher formosa que se aparta da discrição.
23 O desejo dos justos é somente o bem; porém a expectativa dos ímpios é a ira.
24 Um dá liberalmente, e se torna mais rico; outro retém mais do que é justo, e se empobrece.
25 A alma generosa prosperará, e o que regar também será regado.
26 Ao que retém o trigo o povo o amaldiçoa; mas bênção haverá sobre a cabeça do que o vende.
27 O que busca diligentemente o bem, busca favor; mas ao que procura o mal, este lhe sobrevirá.
28 Aquele que confia nas suas riquezas, cairá; mas os justos reverdecerão como a folhagem.
29 O que perturba a sua casa herdará o vento; e o insensato será servo do entendido de coração.
30 O fruto do justo é árvore de vida; e o que ganha almas sábio é.
31 Eis que o justo é castigado na terra; quanto mais o ímpio e o pecador!'),
  ('11111111-1111-4111-8111-111111111111', 12, 'Provérbios 12', '1 O que ama a correção ama o conhecimento; mas o que aborrece a repreensão é insensato.
2 O homem de bem alcançará o favor do Senhor; mas ao homem de perversos desígnios ele condenará.
3 O homem não se estabelece pela impiedade; a raiz dos justos, porém, nunca será, removida.
4 A mulher virtuosa é a coroa do seu marido; porém a que procede vergonhosamente é como apodrecimento nos seus ossos.
5 Os pensamentos do justo são retos; mas os conselhos do ímpio são falsos.
6 As palavras dos ímpios são emboscadas para derramarem sangue; a boca dos retos, porém, os livrará.
7 Transtornados serão os ímpios, e não serão mais; porém a casa dos justos permanecerá.
8 Segundo o seu entendimento é louvado o homem; mas o perverso decoração é desprezado.
9 Melhor é o que é estimado em pouco e tem servo, do que quem se honra a si mesmo e tem falta de pão.
10 O justo olha pela vida dos seus animais; porém as entranhas dos ímpios são crueis.
11 O que lavra a sua terra se fartará de pão; mas o que segue os ociosos é falto de entendimento.
12 Deseja o ímpio o despojo dos maus; porém a raiz dos justos produz o seu próprio fruto.
13 Pela transgressão dos lábios se enlaça o mau; mas o justo escapa da angústia.
14 Do fruto das suas palavras o homem se farta de bem; e das obras das suas mãos se lhe retribui.
15 O caminho do insensato é reto aos seus olhos; mas o que dá ouvidos ao conselho é sábio.
16 A ira do insensato logo se revela; mas o prudente encobre a afronta.
17 Quem fala a verdade manifesta a justiça; porém a testemunha falsa produz a fraude.
18 Há palrador cujas palavras ferem como espada; porém a língua dos sábios traz saúde.
19 O lábio veraz permanece para sempre; mas a língua mentirosa dura só um momento.
20 Engano há no coração dos que maquinam o mal; mas há gozo para os que aconselham a paz.
21 Nenhuma desgraça sobrevém ao justo; mas os ímpios ficam cheios de males.
22 Os lábios mentirosos são abomináveis ao Senhor; mas os que praticam a verdade são o seu deleite.
23 O homem prudente encobre o conhecimento; mas o coração dos tolos proclama a estultícia.
24 A mão dos diligentes dominará; mas o indolente será tributário servil.
25 A ansiedade no coração do homem o abate; mas uma boa palavra o alegra.
26 O justo é um guia para o seu próximo; mas o caminho dos ímpios os faz errar.
27 O preguiçoso não apanha a sua caça; mas o bem precioso do homem é para o diligente.
28 Na vereda da justiça está a vida; e no seu caminho não há morte.'),
  ('11111111-1111-4111-8111-111111111111', 13, 'Provérbios 13', '1 O filho sábio ouve a instrução do pai; mas o escarnecedor não escuta a repreensão.
2 Do fruto da boca o homem come o bem; mas o apetite dos prevaricadores alimenta-se da violência.
3 O que guarda a sua boca preserva a sua vida; mas o que muito abre os seus lábios traz sobre si a ruína.
4 O preguiçoso deseja, e coisa nenhuma alcança; mas o desejo do diligente será satisfeito.
5 O justo odeia a palavra mentirosa, mas o ímpio se faz odioso e se cobre de vergonha.
6 A justiça guarda ao que é reto no seu caminho; mas a perversidade transtorna o pecador.
7 Há quem se faça rico, não tendo coisa alguma; e quem se faça pobre, tendo grande riqueza.
8 O resgate da vida do homem são as suas riquezas; mas o pobre não tem meio de se resgatar.
9 A luz dos justos alegra; porem a lâmpada dos impios se apagará.
10 Da soberba só provém a contenda; mas com os que se aconselham se acha a sabedoria.
11 A riqueza adquirida às pressas diminuira; mas quem a ajunta pouco a pouco terá aumento.
12 A esperança adiada entristece o coração; mas o desejo cumprido é árvore devida.
13 O que despreza a palavra traz sobre si a destruição; mas o que teme o mandamento será galardoado.
14 O ensino do sábio é uma fonte devida para desviar dos laços da morte.
15 O bom senso alcança favor; mas o caminho dos prevaricadores é aspero:
16 Em tudo o homem prudente procede com conhecimento; mas o tolo espraia a sua insensatez.
17 O mensageiro perverso faz cair no mal; mas o embaixador fiel traz saúde.
18 Pobreza e afronta virão ao que rejeita a correção; mas o que guarda a repreensão será honrado.
19 O desejo que se cumpre deleita a alma; mas apartar-se do ma e abominação para os tolos.
20 Quem anda com os sábios será sábio; mas o companheiro dos tolos sofre aflição.
21 O mal persegue os pecadores; mas os justos são galardoados com o bem.
22 O homem de bem deixa uma herança aos filhos de seus filhos; a riqueza do pecador, porém, é reservada para o justo.
23 Abundância de mantimento há, na lavoura do pobre; mas se perde por falta de juízo.
24 Aquele que poupa a vara aborrece a seu filho; mas quem o ama, a seu tempo o castiga.
25 O justo come e fica satisfeito; mas o apetite dos ímpios nunca se satisfaz.'),
  ('11111111-1111-4111-8111-111111111111', 14, 'Provérbios 14', '1 Toda mulher sábia edifica a sua casa; a insensata, porém, derruba-a com as suas mãos.
2 Quem anda na sua retidão teme ao Senhor; mas aquele que é perverso nos seus caminhos despreza-o.
3 Na boca do tolo está a vara da soberba, mas os lábios do sábio preservá-lo-ão.
4 Onde não há bois, a manjedoura está vazia; mas pela força do boi há abundância de colheitas.
5 A testemunha verdadeira não mentirá; a testemunha falsa, porém, se desboca em mentiras.
6 O escarnecedor busca sabedoria, e não a encontra; mas para o prudente o conhecimento é fácil.
7 Vai-te da presença do homem insensato, pois nele não acharás palavras de ciência.
8 A sabedoria do prudente é entender o seu caminho; porém a estultícia dos tolos é enganar.
9 A culpa zomba dos insensatos; mas os retos têm o favor de Deus.
10 O coração conhece a sua própria amargura; e o estranho não participa da sua alegria.
11 A casa dos ímpios se desfará; porém a tenda dos retos florescerá.
12 Há um caminho que ao homem parece direito, mas o fim dele conduz à morte.
13 Até no riso terá dor o coração; e o fim da alegria é tristeza.
14 Dos seus próprios caminhos se fartará o infiel de coração, como também o homem bom se contentará dos seus.
15 O simples dá crédito a tudo; mas o prudente atenta para os seus passos.
16 O sábio teme e desvia-se do mal, mas o tolo é arrogante e dá-se por seguro.
17 Quem facilmente se ira fará doidices; mas o homem discreto é paciente;
18 Os simples herdam a estultícia; mas os prudentes se coroam de conhecimento.
19 Os maus inclinam-se perante os bons; e os ímpios diante das portas dos justos.
20 O pobre é odiado até pelo seu vizinho; mas os amigos dos ricos são muitos.
21 O que despreza ao seu vizinho peca; mas feliz é aquele que se compadece dos pobres.
22 Porventura não erram os que maquinam o mal? mas há beneficência e fidelidade para os que planejam o bem.
23 Em todo trabalho há proveito; meras palavras, porém, só encaminham para a penúria.
24 A coroa dos sábios é a sua riqueza; porém a estultícia dos tolos não passa de estultícia.
25 A testemunha verdadeira livra as almas; mas o que fala mentiras é traidor.
26 No temor do Senhor há firme confiança; e os seus filhos terão um lugar de refúgio.
27 O temor do Senhor é uma fonte de vida, para o homem se desviar dos laços da morte.
28 Na multidão do povo está a glória do rei; mas na falta de povo está a ruína do príncipe.
29 Quem é tardio em irar-se é grande em entendimento; mas o que é de ânimo precipitado exalta a loucura.
30 O coração tranqüilo é a vida da carne; a inveja, porém, é a podridão dos ossos.
31 O que oprime ao pobre insulta ao seu Criador; mas honra-o aquele que se compadece do necessitado.
32 O ímpio é derrubado pela sua malícia; mas o justo até na sua morte acha refúgio.
33 No coração do prudente repousa a sabedoria; mas no coração dos tolos não é conhecida.
34 A justiça exalta as nações; mas o pecado é o opróbrio dos povos.
35 O favor do rei é concedido ao servo que procede sabiamente; mas sobre o que procede indignamente cairá o seu furor.'),
  ('11111111-1111-4111-8111-111111111111', 15, 'Provérbios 15', '1 A resposta branda desvia o furor, mas a palavra dura suscita a ira.
2 A língua dos sábios destila o conhecimento; porém a boca dos tolos derrama a estultícia.
3 Os olhos do Senhor estão em todo lugar, vigiando os maus e os bons.
4 Uma língua suave é árvore de vida; mas a língua perversa quebranta o espírito.
5 O insensato despreza a correção e seu pai; mas o que atende à admoestação prudentemente se haverá.
6 Na casa do justo há um grande tesouro; mas nos lucros do ímpio há perturbação.
7 Os lábios dos sábios difundem conhecimento; mas não o faz o coração dos tolos.
8 O sacrifício dos ímpios é abominável ao Senhor; mas a oração dos retos lhe é agradável.
9 O caminho do ímpio é abominável ao Senhor; mas ele ama ao que segue a justiça.
10 Há disciplina severa para o que abandona a vereda; e o que aborrece a repreensão morrerá.
11 O Seol e o Abadom estão abertos perante o Senhor; quanto mais o coração dos filhos dos homens!
12 O escarnecedor não gosta daquele que o repreende; não irá ter com os sábios.
13 O coração alegre aformoseia o rosto; mas pela dor do coração o espírito se abate.
14 O coração do inteligente busca o conhecimento; mas a boca dos tolos se apascenta de estultícia.
15 Todos os dias do aflito são maus; mas o coração contente tem um banquete contínuo.
16 Melhor é o pouco com o temor do Senhor, do que um grande tesouro, e com ele a inquietação.
17 Melhor é um prato de hortaliça, onde há amor, do que o boi gordo, e com ele o ódio.
18 O homem iracundo suscita contendas; mas o longânimo apazigua a luta.
19 O caminho do preguiçoso é como a sebe de espinhos; porém a vereda dos justos é uma estrada real.
20 O filho sábio alegra a seu pai; mas o homem insensato despreza a sua mãe.
21 A estultícia é alegria para o insensato; mas o homem de entendimento anda retamente.
22 Onde não há conselho, frustram-se os projetos; mas com a multidão de conselheiros se estabelecem.
23 O homem alegra-se em dar uma resposta adequada; e a palavra a seu tempo quão boa é!
24 Para o sábio o caminho da vida é para cima, a fim de que ele se desvie do Seol que é em baixo.
25 O Senhor desarraiga a casa dos soberbos, mas estabelece a herança da viúva.
26 Os desígnios dos maus são abominação para o Senhor; mas as palavras dos limpos lhe são aprazíveis.
27 O que se dá à cobiça perturba a sua própria casa; mas o que aborrece a peita viverá.
28 O coração do justo medita no que há de responder; mas a boca dos ímpios derrama coisas más.
29 Longe está o Senhor dos ímpios, mas ouve a oração dos justos.
30 A luz dos olhos alegra o coração, e boas-novas engordam os ossos.
31 O ouvido que escuta a advertência da vida terá a sua morada entre os sábios.
32 Quem rejeita a correção menospreza a sua alma; mas aquele que escuta a advertência adquire entendimento.
33 O temor do Senhor é a instrução da sabedoria; e adiante da honra vai a humildade.'),
  ('11111111-1111-4111-8111-111111111111', 16, 'Provérbios 16', '1 Ao homem pertencem os planos do coração; mas a resposta da língua é do Senhor.
2 Todos os caminhos do homem são limpos aos seus olhos; mas o Senhor pesa os espíritos.
3 Entrega ao Senhor as tuas obras, e teus desígnios serão estabelecidos.
4 O Senhor fez tudo para um fim; sim, até o ímpio para o dia do mal.
5 Todo homem arrogante é abominação ao Senhor; certamente não ficará impune.
6 Pela misericórdia e pela verdade expia-se a iniqüidade; e pelo temor do Senhor os homens se desviam do mal.
7 Quando os caminhos do homem agradam ao Senhor, faz que até os seus inimigos tenham paz com ele.
8 Melhor é o pouco com justiça, do que grandes rendas com injustiça.
9 O coração do homem propõe o seu caminho; mas o Senhor lhe dirige os passos.
10 Nos lábios do rei acham-se oráculos; em juízo a sua boca não prevarica.
11 O peso e a balança justos são do Senhor; obra sua são todos os pesos da bolsa.
12 Abominação é para os reis o praticarem a impiedade; porque com justiça se estabelece o trono.
13 Lábios justos são o prazer dos reis; e eles amam aquele que fala coisas retas.
14 O furor do rei é mensageiro da morte; mas o homem sábio o aplacará.
15 Na luz do semblante do rei está a vida; e o seu favor é como a nuvem de chuva serôdia.
16 Quanto melhor é adquirir a sabedoria do que o ouro! e quanto mais excelente é escolher o entendimento do que a prata!
17 A estrada dos retos desvia-se do mal; o que guarda o seu caminho preserva a sua vida.
18 A soberba precede a destruição, e a altivez do espírito precede a queda.
19 Melhor é ser humilde de espírito com os mansos, do que repartir o despojo com os soberbos.
20 O que atenta prudentemente para a palavra prosperará; e feliz é aquele que confia no Senhor.
21 O sábio de coração será chamado prudente; e a doçura dos lábios aumenta o saber.
22 O entendimento, para aquele que o possui, é uma fonte de vida, porém a estultícia é o castigo dos insensatos.
23 O coração do sábio instrui a sua boca, e aumenta o saber nos seus lábios.
24 Palavras suaves são como favos de mel, doçura para a alma e saúde para o corpo.
25 Há um caminho que ao homem parece direito, mas o fim dele conduz à morte.
26 O apetite do trabalhador trabalha por ele, porque a sua fome o incita a isso.
27 O homem vil suscita o mal; e nos seus lábios há como que um fogo ardente.
28 O homem perverso espalha contendas; e o difamador separa amigos íntimos.
29 O homem violento alicia o seu vizinho, e guia-o por um caminho que não é bom.
30 Quando fecha os olhos fá-lo para maquinar perversidades; quando morde os lábios, efetua o mal.
31 Coroa de honra são as cãs, a qual se obtém no caminho da justiça.
32 Melhor é o longânimo do que o valente; e o que domina o seu espírito do que o que toma uma cidade.
33 A sorte se lança no regaço; mas do Senhor procede toda a disposição dela.'),
  ('11111111-1111-4111-8111-111111111111', 17, 'Provérbios 17', '1 Melhor é um bocado seco, e com ele a tranqüilidade, do que a casa cheia de festins, com rixas.
2 O servo prudente dominará sobre o filho que procede indignamente; e entre os irmãos receberá da herança.
3 O crisol é para a prata, e o forno para o ouro; mas o Senhor é que prova os corações.
4 O malfazejo atenta para o lábio iníquo; o mentiroso inclina os ouvidos para a língua maligna.
5 O que escarnece do pobre insulta ao seu Criador; o que se alegra da calamidade não ficará impune.
6 Coroa dos velhos são os filhos dos filhos; e a glória dos filhos são seus pais.
7 Não convém ao tolo a fala excelente; quanto menos ao príncipe o lábio mentiroso!
8 Pedra preciosa é a peita aos olhos de quem a oferece; para onde quer que ele se volte, serve-lhe de proveito.
9 O que perdoa a transgressão busca a amizade; mas o que renova a questão, afastam amigos íntimos.
10 Mais profundamente entra a repreensão no prudente, do que cem açoites no insensato.
11 O rebelde não busca senão o mal; portanto um mensageiro cruel será enviado contra ele.
12 Encontre-se o homem com a ursa roubada dos filhotes, mas não com o insensato na sua estultícia.
13 Quanto àquele que torna mal por bem, não se apartará o mal da sua casa.
14 O princípio da contenda é como o soltar de águas represadas; deixa por isso a porfia, antes que haja rixas.
15 O que justifica o ímpio, e o que condena o justo, são abomináveis ao Senhor, tanto um como o outro.
16 De que serve o preço na mão do tolo para comprar a sabedoria, visto que ele não tem entendimento?
17 O amigo ama em todo o tempo; e para a angústia nasce o irmão.
18 O homem falto de entendimento compromete-se, tornando-se fiador na presença do seu vizinho.
19 O que ama a contenda ama a transgressao; o que faz alta a sua porta busca a ruína.
20 O perverso de coração nunca achará o bem; e o que tem a língua dobre virá a cair no mal.
21 O que gera um tolo, para sua tristeza o faz; e o pai do insensato não se alegrará.
22 O coração alegre serve de bom remédio; mas o espírito abatido seca os ossos.
23 O ímpio recebe do regaço a peita, para perverter as veredas da justiça.
24 O alvo do inteligente é a sabedoria; mas os olhos do insensato estão nas extremidades da terra.
25 O filho insensato é tristeza para seu, pai, e amargura para quem o deu à luz.
26 Não é bom punir ao justo, nem ferir aos nobres por causa da sua retidão.
27 Refreia as suas palavras aquele que possui o conhecimento; e o homem de entendimento é de espírito sereno.
28 Até o tolo, estando calado, é tido por sábio; e o que cerra os seus lábios, por entendido.'),
  ('11111111-1111-4111-8111-111111111111', 18, 'Provérbios 18', '1 Aquele que vive isolado busca seu próprio desejo; insurge-se contra a verdadeira sabedoria.
2 O tolo não toma prazer no entendimento, mas tão somente em revelar a sua opinião.
3 Quando vem o ímpio, vem também o desprezo; e com a desonra vem o opróbrio.
4 Aguas profundas são as palavras da boca do homem; e a fonte da sabedoria é um ribeiro que corre.
5 Não é bom ter respeito à pessoa do impio, nem privar o justo do seu direito.
6 Os lábios do tolo entram em contendas, e a sua boca clama por açoites.
7 A boca do tolo é a sua própria destruição, e os seus lábios um laço para a sua alma.
8 As palavras do difamador são como bocados doces, que penetram até o íntimo das entranhas.
9 Aquele que é remisso na sua obra é irmão do que é destruidor.
10 Torre forte é o nome do Senhor; para ela corre o justo, e está seguro.
11 Os bens do rico são a sua cidade forte, e como um muro alto na sua imaginação.
12 Antes da ruína eleva-se o coração do homem; e adiante da honra vai a humildade.
13 Responder antes de ouvir, é estultícia e vergonha.
14 O espírito do homem o sustentará na sua enfermidade; mas ao espírito abatido quem o levantará?
15 O coração do entendido adquire conhecimento; e o ouvido dos sábios busca conhecimento;
16 O presente do homem alarga-lhe o caminho, e leva-o à presença dos grandes.
17 O que primeiro começa o seu pleito parece justo; até que vem o outro e o examina.
18 A sorte faz cessar os pleitos, e decide entre os poderosos.
19 um irmão ajudado pelo irmão é como uma cidade fortificada; é forte como os ferrolhos dum castelo.
20 O homem se fartará do fruto da sua boca; dos renovos dos seus lábios se fartará.
21 A morte e a vida estão no poder da língua; e aquele que a ama comerá do seu fruto.
22 Quem encontra uma esposa acha uma coisa boa; e alcança o favor do Senhor.
23 O pobre fala com rogos; mas o rico responde com durezas.
24 O homem que tem muitos amigos, tem-nos para a sua ruína; mas há um amigo que é mais chegado do que um irmão.'),
  ('11111111-1111-4111-8111-111111111111', 19, 'Provérbios 19', '1 Melhor é o pobre que anda na sua integridade, do que aquele que é perverso de lábios e tolo.
2 Não é bom agir sem refletir; e o que se apressa com seus pés erra o caminho.
3 A estultícia do homem perverte o seu caminho, e o seu coração se irrita contra o Senhor.
4 As riquezas granjeiam muitos amigos; mas do pobre o seu próprio amigo se separa.
5 A testemunha falsa não ficará impune; e o que profere mentiras não escapará.
6 Muitos procurarão o favor do liberal; e cada um é amigo daquele que dá presentes.
7 Todos os irmãos do pobre o aborrecem; quanto mais se afastam dele os seus amigos! persegue-os com súplicas, mas eles já se foram.
8 O que adquire a sabedoria é amigo de si mesmo; o que guarda o entendimento prosperará.
9 A testemunha falsa não ficará impune, e o que profere mentiras perecerá.
10 Ao tolo não convém o luxo; quanto menos ao servo dominar os príncipes!
11 A discrição do homem fá-lo tardio em irar-se; e sua glória está em esquecer ofensas.
12 A ira do rei é como o bramido o leão; mas o seu favor é como o orvalho sobre a erva.
13 O filho insensato é a calamidade do pai; e as rixas da mulher são uma goteira contínua.
14 Casa e riquezas são herdadas dos pais; mas a mulher prudente vem do Senhor.
15 A preguiça faz cair em profundo sono; e o ocioso padecerá fome.
16 Quem guarda o mandamento guarda a sua alma; mas aquele que não faz caso dos seus caminhos morrerá.
17 O que se compadece do pobre empresta ao Senhor, que lhe retribuirá o seu benefício.
18 Corrige a teu filho enquanto há esperança; mas não te incites a destruí-lo.
19 Homem de grande ira tem de sofrer o castigo; porque se o livrares, terás de o fazer de novo.
20 Ouve o conselho, e recebe a correção, para que sejas sábio nos teus últimos dias.
21 Muitos são os planos no coração do homem; mas o desígnio do Senhor, esse prevalecerá.
22 O que faz um homem desejável é a sua benignidade; e o pobre é melhor do que o mentiroso.
23 O temor do Senhor encaminha para a vida; aquele que o tem ficará satisfeito, e mal nenhum o visitará.
24 O preguiçoso esconde a sua mão no prato, e nem ao menos quer levá-la de novo à boca.
25 Fere ao escarnecedor, e o simples aprenderá a prudência; repreende ao que tem entendimento, e ele crescerá na ciencia.
26 O que aflige a seu pai, e faz fugir a sua mãe, é filho que envergonha e desonra.
27 Cessa, filho meu, de ouvir a instrução, e logo te desviarás das palavras do conhecimento.
28 A testemunha vil escarnece da justiça; e a boca dos ímpios engole a iniqüidade.
29 A condenação está preparada para os escarnecedores, e os açoites para as costas dos tolos.'),
  ('11111111-1111-4111-8111-111111111111', 20, 'Provérbios 20', '1 O vinho é escarnecedor, e a bebida forte alvoroçadora; e todo aquele que neles errar não e sábio.
2 Como o bramido do leão é o terror do rei; quem o provoca a ira peca contra a sua própria vida.
3 Honroso é para o homem o desviar-se de questões; mas todo insensato se entremete nelas.
4 O preguiçoso não lavra no outono; pelo que mendigará na sega, e nada receberá.
5 Como águas profundas é o propósito no coração do homem; mas o homem inteligente o descobrirá.
6 Muitos há que proclamam a sua própria bondade; mas o homem fiel, quem o achará?
7 O justo anda na sua integridade; bem-aventurados serão os seus filhos depois dele.
8 Assentando-se o rei no trono do juízo, com os seus olhos joeira a todo malfeitor.
9 Quem pode dizer: Purifiquei o meu coração, limpo estou de meu pecado?
10 O peso fraudulento e a medida falsa são abominação ao Senhor, tanto uma como outra coisa.
11 Até a criança se dá a conhecer pelas suas ações, se a sua conduta é pura e reta.
12 O ouvido que ouve, e o olho que vê, o Senhor os fez a ambos.
13 Não ames o sono, para que não empobreças; abre os teus olhos, e te fartarás de pão.
14 Nada vale, nada vale, diz o comprador; mas, depois de retirar-se, então se gaba.
15 Há ouro e abundância de pedras preciosas; mas os lábios do conhecimento são jóia de grande valor.
16 Tira a roupa àquele que fica por fiador do estranho; e toma penhor daquele que se obriga por estrangeiros.
17 Suave é ao homem o pão da mentira; mas depois a sua boca se enche de pedrinhas.
18 Os projetos se confirmam pelos conselhos; assim, pois, com prudencia faze a guerra.
19 O que anda mexericando revela segredos; pelo que não te metas com quem muito abre os seus lábios.
20 O que amaldiçoa a seu pai ou a sua mãe, apagar-se-lhe-á a sua lâmpada nas, mais densas trevas.
21 A herança que no princípio é adquirida às pressas, não será abençoada no seu fim.
22 Não digas: vingar-me-ei do mal; espera pelo Senhor e ele te livrará.
23 Pesos fraudulentos são abomináveis ao Senhor; e balanças enganosas não são boas.
24 Os passos do homem são dirigidos pelo Senhor; como, pois, poderá o homem entender o seu caminho?
25 Laço é para o homem dizer precipitadamente: É santo; e, feitos os votos, então refletir.
26 O rei sábio joeira os ímpios e faz girar sobre eles a roda.
27 O espírito do homem é a lâmpada do Senhor, a qual esquadrinha todo o mais íntimo do coração.
28 A benignidade e a verdade guardam o rei; e com a benignidade sustém ele o seu trono.
29 A glória dos jovens é a sua força; e a beleza dos velhos são as cãs.
30 Os açoites que ferem purificam do mal; e as feridas penetram até o mais íntimo do corpo.'),
  ('11111111-1111-4111-8111-111111111111', 21, 'Provérbios 21', '1 Como corrente de águas é o coração do rei na mão do Senhor; ele o inclina para onde quer.
2 Todo caminho do homem é reto aos seus olhos; mas o Senhor pesa os corações.
3 Fazer justiça e julgar com retidão é mais aceitável ao Senhor do que oferecer-lhe sacrifício.
4 Olhar altivo e coração orgulhoso, tal lâmpada dos ímpios é pecado.
5 Os planos do diligente conduzem à abundância; mas todo precipitado apressa-se para a penúria.
6 Ajuntar tesouros com língua falsa é uma vaidade fugitiva; aqueles que os buscam, buscam a morte.
7 A violência dos ímpios arrebatá-los-á, porquanto recusam praticar a justiça.
8 O caminho do homem perverso é tortuoso; mas o proceder do puro é reto.
9 Melhor é morar num canto do eirado, do que com a mulher rixosa numa casa ampla.
10 A alma do ímpio deseja o mal; o seu próximo não agrada aos seus olhos.
11 Quando o escarnecedor é castigado, o simples torna-se sábio; e, quando o sábio é instruído, recebe o conhecimento.
12 O justo observa a casa do ímpio; precipitam-se os ímpios na ruína.
13 Quem tapa o seu ouvido ao clamor do pobre, também clamará e não será ouvido.
14 O presente que se dá em segredo aplaca a ira; e a dádiva às escondidas, a forte indignação.
15 A execução da justiça é motivo de alegria para o justo; mas é espanto para os que praticam a iniqüidade.
16 O homem que anda desviado do caminho do entendimento repousará na congregação dos mortos.
17 Quem ama os prazeres empobrecerá; quem ama o vinho e o azeite nunca enriquecera.
18 Resgate para o justo é o ímpio; e em lugar do reto ficará o prevaricador.
19 Melhor é morar numa terra deserta do que com a mulher rixosa e iracunda.
20 Há tesouro precioso e azeite na casa do sábio; mas o homem insensato os devora.
21 Aquele que segue a justiça e a bondade achará a vida, a justiça e a honra.
22 O sábio escala a cidade dos valentes, e derriba a fortaleza em que ela confia.
23 O que guarda a sua boca e a sua língua, guarda das angústias a sua alma.
24 Quanto ao soberbo e presumido, zombador é seu nome; ele procede com insolente orgulho.
25 O desejo do preguiçoso o mata; porque as suas mãos recusam-se a trabalhar.
26 Todo o dia o ímpio cobiça; mas o justo dá, e não retém.
27 O sacrifício dos ímpios é abominaçao; quanto mais oferecendo-o com intenção maligna!
28 A testemunha mentirosa perecerá; mas o homem que ouve falará sem ser contestado.
29 O homem ímpio endurece o seu rosto; mas o reto considera os seus caminhos.
30 Não há sabedoria, nem entendimento, nem conselho contra o Senhor.
31 O cavalo prepara-se para o dia da batalha; mas do Senhor vem a vitória.'),
  ('11111111-1111-4111-8111-111111111111', 22, 'Provérbios 22', '1 Mais digno de ser escolhido é o bom nome do que as muitas riquezas; e o favor é melhor do que a prata e o ouro.
2 O rico e o pobre se encontram; quem os faz a ambos é o Senhor.
3 O prudente vê o perigo e esconde-se; mas os simples passam adiante e sofrem a pena.
4 O galardão da humildade e do temor do Senhor é riquezas, e honra e vida.
5 Espinhos e laços há no caminho do perverso; o que guarda a sua alma retira-se para longe deles.
6 Instrui o menino no caminho em que deve andar, e até quando envelhecer não se desviará dele.
7 O rico domina sobre os pobres; e o que toma emprestado é servo do que empresta.
8 O que semear a perversidade segará males; e a vara da sua indignação falhará.
9 Quem vê com olhos bondosos será abençoado; porque dá do seu pão ao pobre.
10 Lança fora ao escarnecedor, e a contenda se irá; cessarao a rixa e a injúria.
11 O que ama a pureza do coração, e que tem graça nos seus lábios, terá por seu amigo o rei.
12 Os olhos do Senhor preservam o que tem conhecimento; mas ele transtorna as palavras do prevaricador.
13 Diz o preguiçoso: um leão está lá fora; serei morto no meio das ruas.
14 Cova profunda é a boca da adúltera; aquele contra quem o Senhor está irado cairá nela.
15 A estultícia está ligada ao coração do menino; mas a vara da correção a afugentará dele.
16 O que para aumentar o seu lucro oprime o pobre, e dá ao rico, certamente chegará à: penuria.
17 Inclina o teu ouvido e ouve as palavras dos sábios, e aplica o teu coração ao meu conhecimento.
18 Porque será coisa suave, se os guardares no teu peito, se estiverem todos eles prontos nos teus lábios.
19 Para que a tua confiança esteja no senhor, a ti tos fiz saber hoje, sim, a ti mesmo.
20 Porventura não te escrevi excelentes coisas acerca dos conselhos e do conhecimento,
21 para te fazer saber a certeza das palavras de verdade, para que possas responder com palavras de verdade aos que te enviarem?
22 Não roubes ao pobre, porque é pobre; nem oprimas ao aflito na porta;
23 porque o Senhor defenderá a sua causa em juízo, e aos que os roubam lhes tirará a vida.
24 Não faças amizade com o iracundo; nem andes com o homem colérico;
25 para que não aprendas as suas veredas, e tomes um laço para a tua alma.
26 Não estejas entre os que se comprometem, que ficam por fiadores de dívidas.
27 Se não tens com que pagar, por que tirariam a tua cama de debaixo de ti?
28 Não removas os limites antigos que teus pais fixaram.
29 Vês um homem hábil na sua obrar? esse perante reis assistirá; e não assistirá perante homens obscuros.'),
  ('11111111-1111-4111-8111-111111111111', 23, 'Provérbios 23', '1 Quando te assentares a comer com um governador, atenta bem para aquele que está diante de ti;
2 e põe uma faca à tua garganta, se fores homem de grande apetite.
3 Não cobices os seus manjares gostosos, porque é comida enganadora.
4 Não te fatigues para seres rico; dá de mão à tua própria sabedoria:
5 Fitando tu os olhos nas riquezas, elas se vão; pois fazem para si asas, como a águia, voam para o céu.
6 Não comas o pão do avarento, nem cobices os seus manjares gostosos.
7 Porque, como ele pensa consigo mesmo, assim é; ele te diz: Come e bebe; mas o seu coração não está contigo.
8 Vomitarás o bocado que comeste, e perderás as tuas suaves palavras.
9 Não fales aos ouvidos do tolo; porque desprezará a sabedoria das tuas palavras.
10 Não removas os limites antigos; nem entres nos campos dos órfãos,
11 porque o seu redentor é forte; ele lhes pleiteará a causa contra ti.
12 Aplica o teu coração à instrução, e os teus ouvidos às palavras do conhecimento.
13 Não retires da criança a disciplina; porque, fustigando-a tu com a vara, nem por isso morrerá.
14 Tu a fustigarás com a vara e livrarás a sua alma do Seol.
15 Filho meu, se o teu coração for sábio, alegrar-se-á o meu coração, sim, ó, meu próprio;
16 e exultará o meu coração, quando os teus lábios falarem coisas retas.
17 Não tenhas inveja dos pecadores; antes conserva-te no temor do Senhor todo o dia.
18 Porque deveras terás uma recompensa; não será malograda a tua esperança.
19 Ouve tu, filho meu, e sê sábio; e dirige no caminho o teu coração.
20 Não estejas entre os beberrões de vinho, nem entre os comilões de carne.
21 Porque o beberrão e o comilão caem em pobreza; e a sonolência cobrirá de trapos o homem.
22 Ouve a teu pai, que te gerou; e não desprezes a tua mãe, quando ela envelhecer.
23 Compra a verdade, e não a vendas; sim, a sabedoria, a disciplina, e o entendimento.
24 Grandemente se regozijará o pai do justo; e quem gerar um filho sábio, nele se alegrará.
25 Alegrem-se teu pai e tua mãe, e regozije-se aquela que te deu à luz.
26 Filho meu, dá-me o teu coração; e deleitem-se os teus olhos nos meus caminhos.
27 Porque cova profunda é a prostituta; e poço estreito é a aventureira.
28 Também ela, como o salteador, se põe a espreitar; e multiplica entre os homens os prevaricadores.
29 Para quem são os ais? para quem os pesares? para quem as pelejas, para quem as queixas? para quem as feridas sem causa? e para quem os olhos vermelhos?
30 Para os que se demoram perto do vinho, para os que andam buscando bebida misturada.
31 Não olhes para o vinho quando se mostra vermelho, quando resplandece no copo e se escoa suavemente.
32 No seu fim morderá como a cobra, e como o basilisco picará.
33 Os teus olhos verão coisas estranhas, e tu falarás perversidades.
34 o serás como o que se deita no meio do mar, e como o que dorme no topo do mastro.
35 E diràs: Espancaram-me, e não me doeu; bateram-me, e não o senti; quando virei a despertar? ainda tornarei a buscá-lo outra vez.'),
  ('11111111-1111-4111-8111-111111111111', 24, 'Provérbios 24', '1 Não tenhas inveja dos homens malignos; nem desejes estar com eles;
2 porque o seu coração medita a violência; e os seus lábios falam maliciosamente.
3 Com a sabedoria se edifica a casa, e com o entendimento ela se estabelece;
4 e pelo conhecimento se encherão as câmaras de todas as riquezas preciosas e deleitáveis.
5 O sábio é mais poderoso do que o forte; e o inteligente do que o que possui a força.
6 Porque com conselhos prudentes tu podes fazer a guerra; e há vitória na multidão dos conselheiros.
7 A sabedoria é alta demais para o insensato; ele não abre a sua boca na porta.
8 Aquele que cuida em fazer o mal, mestre de maus intentos o chamarão.
9 O desígnio do insensato é pecado; e abominável aos homens é o escarnecedor.
10 Se enfraqueces no dia da angústia, a tua força é pequena.
11 Livra os que estão sendo levados à morte, detém os que vão tropeçando para a matança.
12 Se disseres: Eis que não o sabemos; porventura aquele que pesa os corações não o percebe? e aquele que guarda a tua vida não o sabe? e não retribuirá a cada um conforme a sua obra?
13 Come mel, filho meu, porque é bom, e do favo de mel, que é doce ao teu paladar.
14 Sabe que é assim a sabedoria para a tua alma: se a achares, haverá para ti recompensa, e não será malograda a tua esperança.
15 Não te ponhas de emboscada, ó ímpio, contra a habitação do justo; nem assoles a sua pousada.
16 Porque sete vezes cai o justo, e se levanta; mas os ímpios são derribados pela calamidade.
17 Quando cair o teu inimigo, não te alegres, e quando tropeçar, não se regozije o teu coração;
18 para que o Senhor não o veja, e isso seja mau aos seus olhos, e desvie dele, a sua ira.
19 Não te aflijas por causa dos malfeitores; nem tenhas inveja dos ímpios;
20 porque o maligno não tem futuro; e a lâmpada dos ímpios se apagará.
21 Filho meu, teme ao Senhor, e ao rei; e não te entremetas com os que gostam de mudanças.
22 Porque de repente se levantará a sua calamidade; e a ruína deles, quem a conhecerá?
23 Também estes são provérbios dos sábios: Fazer acepção de pessoas no juízo não é bom.
24 Aquele que disser ao ímpio: Justo és; os povos o amaldiçoarão, as nações o detestarão;
25 mas para os que julgam retamente haverá delícias, e sobre eles virá copiosa bênção.
26 O que responde com palavras retas beija os lábios.
27 Prepara os teus trabalhos de fora, apronta bem o teu campo; e depois edifica a tua casa.
28 Não sejas testemunha sem causa contra o teu próximo; e não enganes com os teus lábios.
29 Não digas: Como ele me fez a mim, assim lhe farei a ele; pagarei a cada um segundo a sua obra.
30 Passei junto ao campo do preguiçoso, e junto à vinha do homem falto de entendimento;
31 e eis que tudo estava cheio de cardos, e a sua superfície coberta de urtigas, e o seu muro de pedra estava derrubado.
32 O que tendo eu visto, o considerei; e, vendo-o, recebi instrução.
33 Um pouco para dormir, um pouco para toscanejar, um pouco para cruzar os braços em repouso;
34 assim sobrevirá a tua pobreza como um salteador, e a tua necessidade como um homem armado.'),
  ('11111111-1111-4111-8111-111111111111', 25, 'Provérbios 25', '1 Também estes são provérbios de Salomão, os quais transcreveram os homens de Ezequias, rei de Judá.
2 A glória de Deus é encobrir as coisas; mas a glória dos reis é esquadrinhá-las.
3 Como o céu na sua altura, e como a terra na sua profundidade, assim o coração dos reis é inescrutável.
4 Tira da prata a escória, e sairá um vaso para o fundidor.
5 Tira o ímpio da presença do rei, e o seu trono se firmará na justiça.
6 Não reclames para ti honra na presença do rei, nem te ponhas no lugar dos grandes;
7 porque melhor é que te digam: Sobe, para aqui; do que seres humilhado perante o príncipe.
8 O que os teus olhos viram, não te apresses a revelar, para depois, ao fim, não saberes o que hás de fazer, podendo-te confundir o teu próximo.
9 Pleiteia a tua causa com o teu próximo mesmo; e não reveles o segredo de outrem;
10 para que não te desonre aquele que o ouvir, não se apartando de ti a infâmia.
11 Como maçãs de ouro em salvas de prata, assim é a palavra dita a seu tempo.
12 Como pendentes de ouro e gargantilhas de ouro puro, assim é o sábio repreensor para o ouvido obediente.
13 Como o frescor de neve no tempo da sega, assim é o mensageiro fiel para com os que o enviam, porque refrigera o espírito dos seus senhores.
14 como nuvens e ventos que não trazem chuva, assim é o homem que se gaba de dádivas que não fez.
15 Pela longanimidade se persuade o príncipe, e a língua branda quebranta os ossos.
16 Se achaste mel, come somente o que te basta, para que porventura não te fartes dele, e o venhas a vomitar.
17 Põe raramente o teu pé na casa do teu próximo, para que não se enfade de ti, e te aborreça.
18 Malho, e espada, e flecha aguda é o homem que levanta falso testemunho contra o seu próximo.
19 Como dente quebrado, e pé deslocado, é a confiança no homem desleal, no dia da angústia.
20 O que entoa canções ao coração aflito é como aquele que despe uma peça de roupa num dia de frio, e como vinagre sobre a chaga.
21 Se o teu inimigo tiver fome, dá-lhe pão para comer, e se tiver sede, dá-lhe água para beber;
22 porque assim lhe amontoarás brasas sobre a cabeça, e o Senhor te recompensará.
23 O vento norte traz chuva, e a língua caluniadora, o rosto irado.
24 Melhor é morar num canto do eirado, do que com a mulher rixosa numa casa ampla.
25 Como água fresca para o homem sedento, tais são as boas-novas de terra remota.
26 Como fonte turva, e manancial poluído, assim é o justo que cede lugar diante do ímpio.
27 comer muito mel não é bom; não multipliques, pois, as palavras de lisonja.
28 Como a cidade derribada, que não tem muros, assim é o homem que não pode conter o seu espírito.'),
  ('11111111-1111-4111-8111-111111111111', 26, 'Provérbios 26', '1 Como a neve no verão, e como a chuva no tempo da ceifa, assim não convém ao tolo a honra.
2 Como o pássaro no seu vaguear, como a andorinha no seu voar, assim a maldição sem causa não encontra pouso.
3 O açoite é para o cavalo, o freio para o jumento, e a vara para as costas dos tolos.
4 Não respondas ao tolo segundo a sua estultícia, para que também não te faças semelhante a ele.
5 Responde ao tolo segundo a sua estultícia, para que ele não seja sábio aos seus próprios olhos.
6 Os pés decepa, e o dano bebe, quem manda mensagens pela mão dum tolo.
7 As pernas do coxo pendem frouxas; assim é o provérbio na boca dos tolos.
8 Como o que ata a pedra na funda, assim é aquele que dá honra ao tolo.
9 Como o espinho que entra na mão do ébrio, assim é o provérbio na mão dos tolos.
10 Como o flecheiro que fere a todos, assim é aquele que assalaria ao transeunte tolo, ou ao ébrio.
11 Como o cão que torna ao seu vômito, assim é o tolo que reitera a sua estultícia.
12 Vês um homem que é sábio a seus próprios olhos? Maior esperança há para o tolo do que para ele.
13 Diz o preguiçoso: Um leão está no caminho; um leão está nas ruas.
14 Como a porta se revolve nos seus gonzos, assim o faz o preguiçoso na sua cama.
15 O preguiçoso esconde a sua mão no prato, e nem ao menos quer levá-la de novo à boca.
16 Mais sábio é o preguiçoso a seus olhos do que sete homens que sabem responder bem.
17 O que, passando, se mete em questão alheia é como aquele que toma um cão pelas orelhas.
18 Como o louco que atira tições, flechas, e morte,
19 assim é o homem que engana o seu próximo, e diz: Fiz isso por brincadeira.
20 Faltando lenha, apaga-se o fogo; e não havendo difamador, cessa a contenda.
21 Como o carvão para as brasas, e a lenha para o fogo, assim é o homem contencioso para acender rixas.
22 As palavras do difamador são como bocados deliciosos, que descem ao íntimo do ventre.
23 Como o vaso de barro coberto de escória de prata, assim são os lábios ardentes e o coração maligno.
24 Aquele que odeia dissimula com os seus lábios; mas no seu interior entesoura o engano.
25 Quando te suplicar com voz suave, não o creias; porque sete abominações há no teu coração.
26 Ainda que o seu ódio se encubra com dissimulação, na congregação será revelada a sua malícia.
27 O que faz uma cova cairá nela; e a pedra voltará sobre aquele que a revolve.
28 A língua falsa odeia aqueles a quem ela tenha ferido; e a boca lisonjeira opera a ruína.'),
  ('11111111-1111-4111-8111-111111111111', 27, 'Provérbios 27', '1 Não te glories do dia de amanhã; porque não sabes o que produzirá o dia.
2 Seja outro o que te louve, e não a tua boca; o estranho, e não os teus lábios.
3 Pesada é a pedra, e a areia também; mas a ira do insensato é mais pesada do que elas ambas.
4 Cruel é o furor, e impetuosa é a ira; mas quem pode resistir à inveja?
5 Melhor é a repreensão aberta do que o amor encoberto.
6 Fiéis são as feridas dum amigo; mas os beijos dum inimigo são enganosos.
7 O que está farto despreza o favo de mel; mas para o faminto todo amargo é doce.
8 Qual a ave que vagueia longe do seu ninho, tal é o homem que anda vagueando longe do seu lugar.
9 O óleo e o perfume alegram o coração; assim é o doce conselho do homem para o seu amigo.
10 Não abandones o teu amigo, nem o amigo de teu pai; nem entres na casa de teu irmão no dia de tua adversidade. Mais vale um vizinho que está perto do que um irmão que está longe.
11 Sê sábio, filho meu, e alegra o meu coração, para que eu tenha o que responder àquele que me vituperar.
12 O prudente vê o mal e se esconde; mas os insensatos passam adiante e sofrem a pena.
13 Tira a roupa àquele que fica por fiador do estranho, e toma penhor daquele que se obriga por uma estrangeira.
14 O que bendiz ao seu amigo em alta voz, levantando-se de madrugada, isso lhe será contado como maldição.
15 A goteira contínua num dia chuvoso e a mulher rixosa são semelhantes;
16 retê-la é reter o vento, ou segurar o óleo com a destra.
17 Afia-se o ferro com o ferro; assim o homem afia o rosto do seu amigo.
18 O que cuida da figueira comerá do fruto dela; e o que vela pelo seu senhor será honrado.
19 Como na água o rosto corresponde ao rosto, assim o coração do homem ao homem.
20 O Seol e o Abadom nunca se fartam, e os olhos do homem nunca se satisfazem.
21 O crisol é para a prata, e o forno para o ouro, e o homem é provado pelos louvores que recebe.
22 Ainda que pisasses o insensato no gral entre grãos pilados, contudo não se apartaria dele a sua estultícia.
23 Procura conhecer o estado das tuas ovelhas; cuida bem dos teus rebanhos;
24 porque as riquezas não duram para sempre; e duraria a coroa de geração em geração?
25 Quando o feno é removido, e aparece a erva verde, e recolhem-se as ervas dos montes,
26 os cordeiros te proverão de vestes, e os bodes, do preço do campo.
27 E haverá bastante leite de cabras para o teu sustento, para o sustento da tua casa e das tuas criadas.'),
  ('11111111-1111-4111-8111-111111111111', 28, 'Provérbios 28', '1 Fogem os ímpios, sem que ninguém os persiga; mas os justos são ousados como o leão.
2 Por causa da transgressão duma terra são muitos os seus príncipes; mas por virtude de homens prudentes e entendidos, ela subsistirá por longo tempo.
3 O homem pobre que oprime os pobres, é como chuva impetuosa, que não deixa trigo nenhum.
4 Os que abandonam a lei louvam os ímpios; mas os que guardam a lei pelejam contra eles.
5 Os homens maus não entendem a justiça; mas os que buscam ao Senhor a entendem plenamente.
6 Melhor é o pobre que anda na sua integridade, do que o rico perverso nos seus caminhos.
7 O que guarda a lei é filho sábio; mas o companheiro dos comilões envergonha a seu pai.
8 O que aumenta a sua riqueza com juros e usura, ajunta-a para o que se compadece do pobre.
9 O que desvia os seus ouvidos de ouvir a lei, até a sua oração é abominável.
10 O que faz com que os retos se desviem para um mau caminho, ele mesmo cairá na cova que abriu; mas os inocentes herdarão o bem.
11 O homem rico é sábio aos seus próprios olhos; mas o pobre que tem entendimento o esquadrinha.
12 Quando os justos triunfam há grande, glória; mas quando os ímpios sobem, escondem-se os homens.
13 O que encobre as suas transgressões nunca prosperará; mas o que as confessa e deixa, alcançará misericórdia.
14 Feliz é o homem que teme ao Senhor continuamente; mas o que endurece o seu coração virá a cair no mal.
15 Como leão bramidor, e urso faminto, assim é o ímpio que domina sobre um povo pobre.
16 O príncipe falto de entendimento é também opressor cruel; mas o que aborrece a avareza prolongará os seus dias.
17 O homem culpado do sangue de qualquer pessoa será fugitivo até a morte; ninguém o ajude.
18 O que anda retamente salvar-se-á; mas o perverso em seus caminhos cairá de repente.
19 O que lavra a sua terra se fartará de pão; mas o que segue os ociosos se encherá de pobreza.
20 O homem fiel gozará de abundantes bênçãos; mas o que se apressa a enriquecer não ficará impune.
21 Fazer acepção de pessoas não é bom; mas até por um bocado de pão prevaricará o homem.
22 Aquele que é cobiçoso corre atrás das riquezas; e não sabe que há de vir sobre ele a penúria.
23 O que repreende a um homem achará depois mais favor do que aquele que lisonjeia com a língua.
24 O que rouba a seu pai, ou a sua mãe, e diz: Isso não é transgressão; esse é companheiro do destruidor.
25 O cobiçoso levanta contendas; mas o que confia no senhor prosperará.
26 O que confia no seu próprio coração é insensato; mas o que anda sabiamente será livre.
27 O que dá ao pobre não terá falta; mas o que esconde os seus olhos terá muitas maldições.
28 Quando os ímpios sobem, escondem-se os homens; mas quando eles perecem, multiplicam-se os justos.'),
  ('11111111-1111-4111-8111-111111111111', 29, 'Provérbios 29', '1 Aquele que, sendo muitas vezes repreendido, endurece a cerviz, será quebrantado de repente sem que haja cura.
2 Quando os justos governam, alegra-se o povo; mas quando o ímpio domina, o povo geme.
3 O que ama a sabedoria alegra a seu pai; mas o companheiro de prostitutas desperdiça a sua riqueza.
4 O rei pela justiça estabelece a terra; mas o que exige presentes a transtorna.
5 O homem que lisonjeia a seu próximo arma-lhe uma rede aos passos.
6 Na transgressão do homem mau há laço; mas o justo canta e se regozija.
7 O justo toma conhecimento da causa dos pobres; mas o ímpio não tem entendimento para a conhecer.
8 Os escarnecedores abrasam a cidade; mas os sábios desviam a ira.
9 O sábio que pleiteia com o insensato, quer este se agaste quer se ria, não terá descanso.
10 Os homens sanguinários odeiam o íntegro; mas os retos procuram o seu bem.
11 O tolo derrama toda a sua ira; mas o sábio a reprime e aplaca.
12 O governador que dá atenção às palavras mentirosas achará que todos os seus servos são ímpios.
13 O pobre e o opressor se encontram; o Senhor alumia os olhos de ambos.
14 Se o rei julgar os pobres com eqüidade, o seu trono será estabelecido para sempre.
15 A vara e a repreensão dão sabedoria; mas a criança entregue a si mesma envergonha a sua mãe.
16 Quando os ímpios se multiplicam, multiplicam-se as transgressões; mas os justos verão a queda deles.
17 Corrige a teu filho, e ele te dará descanso; sim, deleitará o teu coração.
18 Onde não há profecia, o povo se corrompe; mas o que guarda a lei esse é bem-aventurado.
19 O servo não se emendará com palavras; porque, ainda que entenda, não atenderá.
20 Vês um homem precipitado nas suas palavras? Maior esperança há para o tolo do que para ele.
21 Aquele que cria delicadamente o seu servo desde a meninice, no fim tê-lo-á por herdeiro.
22 O homem iracundo levanta contendas, e o furioso multiplica as transgressões.
23 A soberba do homem o abaterá; mas o humilde de espírito obterá honra.
24 O que é sócio do ladrão odeia a sua própria alma; sendo ajuramentado, nada denuncia.
25 O receio do homem lhe arma laços; mas o que confia no Senhor está seguro.
26 Muitos buscam o favor do príncipe; mas é do Senhor que o homem recebe a justiça.
27 O ímpio é abominação para os justos; e o que é reto no seu caminho é abominação para o ímpio.'),
  ('11111111-1111-4111-8111-111111111111', 30, 'Provérbios 30', '1 Palavras de Agur, filho de Jaqué de Massá. Diz o homem a Itiel, e a Ucal:
2 Na verdade que eu sou mais estúpido do que ninguém; não tenho o entendimento do homem;
3 não aprendi a sabedoria, nem tenho o conhecimento do Santo.
4 Quem subiu ao céu e desceu? quem encerrou os ventos nos seus punhos? mas amarrou as águas no seu manto? quem estabeleceu todas as extremidades da terra? qual é o seu nome, e qual é o nome de seu filho? Certamente o sabes!
5 Toda palavra de Deus é pura; ele é um escudo para os que nele confiam.
6 Nada acrescentes às suas palavras, para que ele não te repreenda e tu sejas achado mentiroso.
7 Duas coisas te peço; não mas negues, antes que morra:
8 Alonga de mim a falsidade e a mentira; não me dês nem a pobreza nem a riqueza: dá-me só o pão que me é necessário;
9 para que eu de farto não te negue, e diga: Quem é o Senhor? ou, empobrecendo, não venha a furtar, e profane o nome de Deus.
10 Não calunies o servo diante de seu senhor, para que ele não te amaldiçoe e fiques tu culpado.
11 Há gente que amaldiçoa a seu pai, e que não bendiz a sua mãe.
12 Há gente que é pura aos seus olhos, e contudo nunca foi lavada da sua imundícia.
13 Há gente cujos olhos são altivos, e cujas pálpebras são levantadas para cima.
14 Há gente cujos dentes são como espadas; e cujos queixais sao como facas, para devorarem da terra os aflitos, e os necessitados dentre os homens.
15 A sanguessuga tem duas filhas, a saber: Dá, Dá. Há três coisas que nunca se fartam; sim, quatro que nunca dizem: Basta;
16 o Seol, a madre estéril, a terra que não se farta d''água, e o fogo que nunca diz: Basta.
17 Os olhos que zombam do pai, ou desprezam a obediência à mãe, serão arrancados pelos corvos do vale e devorados pelos filhos da águia.
18 Há três coisas que são maravilhosas demais para mim, sim, há quatro que não conheço:
19 o caminho da águia no ar, o caminho da cobra na penha, o caminho do navio no meio do mar, e o caminho do homem com uma virgem.
20 Tal é o caminho da mulher adúltera: ela come, e limpa a sua boca, e diz: não pratiquei iniqüidade.
21 Por três coisas estremece a terra, sim, há quatro que não pode suportar:
22 o escravo quando reina; o tolo quando se farta de comer;
23 a mulher desdenhada quando se casa; e a serva quando fica herdeira da sua senhora.
24 Quatro coisas há na terra que são pequenas, entretanto são extremamente sábias;
25 as formigas são um povo sem força, todavia no verão preparam a sua comida;
26 os querogrilos são um povo débil, contudo fazem a sua casa nas rochas;
27 os gafanhotos não têm rei, contudo marcham todos enfileirados;
28 a lagartixa apanha-se com as mãos, contudo anda nos palácios dos reis.
29 Há três que andam com elegância, sim, quatro que se movem airosamente:
30 o leão, que é o mais forte entre os animais, e que não se desvia diante de ninguém;
31 o galo emproado, o bode, e o rei à frente do seu povo.
32 Se procedeste loucamente em te elevares, ou se maquinaste o mal, põe a mão sobre a boca.
33 Como o espremer do leite produz queijo verde, e o espremer do nariz produz sangue, assim o espremer da ira produz contenda.'),
  ('11111111-1111-4111-8111-111111111111', 31, 'Provérbios 31', '1 As palavras do rei Lemuel, rei de Massá, que lhe ensinou sua mãe.
2 Que te direi, filho meu? e que te direi, ó filho do meu ventre? e que te direi, ó filho dos meus votos?
3 Não dês às mulheres a tua força, nem os teus caminhos às que destroem os reis.
4 Não é dos reis, ó Lemuel, não é dos reis beber vinho, nem dos príncipes desejar bebida forte;
5 para que não bebam, e se esqueçam da lei, e pervertam o direito de quem anda aflito.
6 Dai bebida forte ao que está para perecer, e o vinho ao que está em amargura de espírito.
7 Bebam e se esqueçam da sua pobreza, e da sua miséria não se lembrem mais.
8 Abre a tua boca a favor do mudo, a favor do direito de todos os desamparados.
9 Abre a tua boca; julga retamente, e faze justiça aos pobres e aos necessitados.
10 Álefe. Mulher virtuosa, quem a pode achar? Pois o seu valor muito excede ao de jóias preciosas.
11 Bete. O coração do seu marido confia nela, e não lhe haverá falta de lucro.
12 Guímel. Ela lhe faz bem, e não mal, todos os dias da sua vida.
13 Dálete. Ela busca lã e linho, e trabalha de boa vontade com as mãos.
14 Hê. É como os navios do negociante; de longe traz o seu pão.
15 Vave. E quando ainda está escuro, ela se levanta, e dá mantimento à sua casa, e a tarefa às suas servas.
16 Zaine. Considera um campo, e compra-o; planta uma vinha com o fruto de suas maos.
17 Hete. Cinge os seus lombos de força, e fortalece os seus braços.
18 Tete. Prova e vê que é boa a sua mercadoria; e a sua lâmpada não se apaga de noite.
19 Iode. Estende as mãos ao fuso, e as suas mãos pegam na roca.
20 Cafe. Abre a mão para o pobre; sim, ao necessitado estende as suas mãos.
21 Lâmede. Não tem medo da neve pela sua família; pois todos os da sua casa estão vestidos de escarlate.
22 Meme. Faz para si cobertas; de linho fino e de púrpura é o seu vestido.
23 Nune. Conhece-se o seu marido nas portas, quando se assenta entre os anciãos da terra.
24 Sâmerue. Faz vestidos de linho, e vende-os, e entrega cintas aos mercadores.
25 Aine. A força e a dignidade são os seus vestidos; e ri-se do tempo vindouro.
26 Pê. Abre a sua boca com sabedoria, e o ensino da benevolência está na sua língua.
27 Tsadê. Olha pelo governo de sua casa, e não come o pão da preguiça.
28 Côfe. Levantam-se seus filhos, e lhe chamam bem-aventurada, como também seu marido, que a louva, dizendo:
29 Reche. Muitas mulheres têm procedido virtuosamente, mas tu a todas sobrepujas.
30 Chine. Enganosa é a graça, e vã é a formosura; mas a mulher que teme ao Senhor, essa será louvada.
31 Tau. Dai-lhe do fruto das suas mãos, e louvem-na nas portas as suas obras.')
on conflict (plan_id, dia) do update set referencia = excluded.referencia, texto = excluded.texto;

insert into reading_plan_days (plan_id, dia, referencia, texto) values
  ('22222222-2222-4222-8222-222222222222', 1, 'João 1', '1 No princípio era o Verbo, e o Verbo estava com Deus, e o Verbo era Deus.
2 Ele estava no princípio com Deus.
3 Todas as coisas foram feitas por intermédio dele, e sem ele nada do que foi feito se fez.
4 Nele estava a vida, e a vida era a luz dos homens;
5 a luz resplandece nas trevas, e as trevas não prevaleceram contra ela.
6 Houve um homem enviado de Deus, cujo nome era João.
7 Este veio como testemunha, a fim de dar testemunho da luz, para que todos cressem por meio dele.
8 Ele não era a luz, mas veio para dar testemunho da luz.
9 Pois a verdadeira luz, que alumia a todo homem, estava chegando ao mundo.
10 Estava ele no mundo, e o mundo foi feito por intermédio dele, e o mundo não o conheceu.
11 Veio para o que era seu, e os seus não o receberam.
12 Mas, a todos quantos o receberam, aos que crêem no seu nome, deu-lhes o poder de se tornarem filhos de Deus;
13 os quais não nasceram do sangue, nem da vontade da carne, nem da vontade do varão, mas de Deus.
14 E o Verbo se fez carne, e habitou entre nós, cheio de graça e de verdade; e vimos a sua glória, como a glória do unigênito do Pai.
15 João deu testemunho dele, e clamou, dizendo: Este é aquele de quem eu disse: O que vem depois de mim, passou adiante de mim; porque antes de mim ele já existia.
16 Pois todos nós recebemos da sua plenitude, e graça sobre graça.
17 Porque a lei foi dada por meio de Moisés; a graça e a verdade vieram por Jesus Cristo.
18 Ninguém jamais viu a Deus. O Deus unigênito, que está no seio do Pai, esse o deu a conhecer.
19 E este foi o testemunho de João, quando os judeus lhe enviaram de Jerusalém sacerdotes e levitas para que lhe perguntassem: Quem és tu?
20 Ele, pois, confessou e não negou; sim, confessou: Eu não sou o Cristo.
21 Ao que lhe perguntaram: Pois que? És tu Elias? Respondeu ele: Não sou. És tu o profeta? E respondeu: Não.
22 Disseram-lhe, pois: Quem és? para podermos dar resposta aos que nos enviaram; que dizes de ti mesmo?
23 Respondeu ele: Eu sou a voz do que clama no deserto: Endireitai o caminho do Senhor, como disse o profeta Isaías.
24 E os que tinham sido enviados eram dos fariseus.
25 Então lhe perguntaram: Por que batizas, pois, se tu não és o Cristo, nem Elias, nem o profeta?
26 Respondeu-lhes João: Eu batizo em água; no meio de vós está um a quem vós não conheceis.
27 aquele que vem depois de mim, de quem eu não sou digno de desatar a correia da alparca.
28 Estas coisas aconteceram em Betânia, além do Jordão, onde João estava batizando.
29 No dia seguinte João viu a Jesus, que vinha para ele, e disse: Eis o Cordeiro de Deus, que tira o pecado do mundo.
30 este é aquele de quem eu disse: Depois de mim vem um varão que passou adiante de mim, porque antes de mim ele já existia.
31 Eu não o conhecia; mas, para que ele fosse manifestado a Israel, é que vim batizando em água.
32 E João deu testemunho, dizendo: Vi o Espírito descer do céu como pomba, e repousar sobre ele.
33 Eu não o conhecia; mas o que me enviou a batizar em água, esse me disse: Aquele sobre quem vires descer o Espírito, e sobre ele permanecer, esse é o que batiza no Espírito Santo.
34 Eu mesmo vi e já vos dei testemunho de que este é o Filho de Deus.
35 No dia seguinte João estava outra vez ali, com dois dos seus discípulos
36 e, olhando para Jesus, que passava, disse: Eis o Cordeiro de Deus!
37 Aqueles dois discípulos ouviram-no dizer isto, e seguiram a Jesus.
38 Voltando-se Jesus e vendo que o seguiam, perguntou-lhes: Que buscais? Disseram-lhe eles: rabi (que, traduzido, quer dizer Mestre), onde pousas?
39 Respondeu-lhes: Vinde, e vereis. Foram, pois, e viram onde pousava; e passaram o dia com ele; era cerca da hora décima.
40 André, irmão de Simão Pedro, era um dos dois que ouviram João falar, e que seguiram a Jesus.
41 Ele achou primeiro a seu irmão Simão, e disse-lhe: Havemos achado o Messias (que, traduzido, quer dizer Cristo).
42 E o levou a Jesus. Jesus, fixando nele o olhar, disse: Tu és Simão, filho de João, tu serás chamado Cefas (que quer dizer Pedro).
43 No dia seguinte Jesus resolveu partir para a Galiléia, e achando a Felipe disse-lhe: Segue-me.
44 Ora, Felipe era de Betsaida, cidade de André e de Pedro.
45 Felipe achou a Natanael, e disse-lhe: Acabamos de achar aquele de quem escreveram Moisés na lei, e os profetas: Jesus de Nazaré, filho de José.
46 Perguntou-lhe Natanael: Pode haver coisa bem vinda de Nazaré? Disse-lhe Felipe: Vem e vê.
47 Jesus, vendo Natanael aproximar-se dele, disse a seu respeito: Eis um verdadeiro israelita, em quem não há dolo!
48 Perguntou-lhe Natanael: Donde me conheces? Respondeu-lhe Jesus: Antes que Felipe te chamasse, eu te vi, quando estavas debaixo da figueira.
49 Respondeu-lhe Natanael: Rabi, tu és o Filho de Deus, tu és rei de Israel.
50 Ao que lhe disse Jesus: Porque te disse: Vi-te debaixo da figueira, crês? coisas maiores do que estas verás.
51 E acrescentou: Em verdade, em verdade vos digo que vereis o céu aberto, e os anjos de Deus subindo e descendo sobre o Filho do homem.'),
  ('22222222-2222-4222-8222-222222222222', 2, 'João 2', '1 Três dias depois, houve um casamento em Caná da Galiléia, e estava ali a mãe de Jesus;
2 e foi também convidado Jesus com seus discípulos para o casamento.
3 E, tendo acabado o vinho, a mãe de Jesus lhe disse: Eles não têm vinho.
4 Respondeu-lhes Jesus: Mulher, que tenho eu contigo? Ainda não é chegada a minha hora.
5 Disse então sua mãe aos serventes: Fazei tudo quanto ele vos disser.
6 Ora, estavam ali postas seis talhas de pedra, para as purificações dos judeus, e em cada uma cabiam duas ou três metretas.
7 Ordenou-lhe Jesus: Enchei de água essas talhas. E encheram- nas até em cima.
8 Então lhes disse: Tirai agora, e levai ao mestre-sala. E eles o fizeram.
9 Quando o mestre-sala provou a água tornada em vinho, não sabendo donde era, se bem que o sabiam os serventes que tinham tirado a água, chamou o mestre-sala ao noivo
10 e lhe disse: Todo homem põe primeiro o vinho bom e, quando já têm bebido bem, então o inferior; mas tu guardaste até agora o bom vinho.
11 Assim deu Jesus início aos seus sinais em Caná da Galiléia, e manifestou a sua glória; e os seus discípulos creram nele.
12 Depois disso desceu a Cafarnaum, ele, sua mãe, seus irmãos, e seus discípulos; e ficaram ali não muitos dias.
13 Estando próxima a páscoa dos judeus, Jesus subiu a Jerusalém.
14 E achou no templo os que vendiam bois, ovelhas e pombas, e também os cambistas ali sentados;
15 e tendo feito um azorrague de cordas, lançou todos fora do templo, bem como as ovelhas e os bois; e espalhou o dinheiro dos cambistas, e virou-lhes as mesas;
16 e disse aos que vendiam as pombas: Tirai daqui estas coisas; não façais da casa de meu Pai casa de negócio.
17 Lembraram-se então os seus discípulos de que está escrito: O zelo da tua casa me devorará.
18 Protestaram, pois, os judeus, perguntando-lhe: Que sinal de autoridade nos mostras, uma vez que fazes isto?
19 Respondeu-lhes Jesus: Derribai este santuário, e em três dias o levantarei.
20 Disseram, pois, os judeus: Em quarenta e seis anos foi edificado este santuário, e tu o levantarás em três dias?
21 Mas ele falava do santuário do seu corpo.
22 Quando, pois ressurgiu dentre os mortos, seus discípulos se lembraram de que dissera isto, e creram na Escritura, e na palavra que Jesus havia dito.
23 Ora, estando ele em Jerusalém pela festa da páscoa, muitos, vendo os sinais que fazia, creram no seu nome.
24 Mas o próprio Jesus não confiava a eles, porque os conhecia a todos,
25 e não necessitava de que alguém lhe desse testemunho do homem, pois bem sabia o que havia no homem.'),
  ('22222222-2222-4222-8222-222222222222', 3, 'João 3', '1 Ora, havia entre os fariseus um homem chamado Nicodemos, um dos principais dos judeus.
2 Este foi ter com Jesus, de noite, e disse-lhe: Rabi, sabemos que és Mestre, vindo de Deus; pois ninguém pode fazer estes sinais que tu fazes, se Deus não estiver com ele.
3 Respondeu-lhe Jesus: Em verdade, em verdade te digo que se alguém não nascer de novo, não pode ver o reino de Deus.
4 Perguntou-lhe Nicodemos: Como pode um homem nascer, sendo velho? porventura pode tornar a entrar no ventre de sua mãe, e nascer?
5 Jesus respondeu: Em verdade, em verdade te digo que se alguém não nascer da água e do Espírito, não pode entrar no reino de Deus.
6 O que é nascido da carne é carne, e o que é nascido do Espírito é espírito.
7 Não te admires de eu te haver dito: Necessário vos é nascer de novo.
8 O vento sopra onde quer, e ouves a sua voz; mas não sabes donde vem, nem para onde vai; assim é todo aquele que é nascido do Espírito.
9 Perguntou-lhe Nicodemos: Como pode ser isto?
10 Respondeu-lhe Jesus: Tu és mestre em Israel, e não entendes estas coisas?
11 Em verdade, em verdade te digo que nós dizemos o que sabemos e testemunhamos o que temos visto; e não aceitais o nosso testemunho!
12 Se vos falei de coisas terrestres, e não credes, como crereis, se vos falar das celestiais?
13 Ora, ninguém subiu ao céu, senão o que desceu do céu, o Filho do homem.
14 E como Moisés levantou a serpente no deserto, assim importa que o Filho do homem seja levantado;
15 para que todo aquele que nele crê tenha a vida eterna.
16 Porque Deus amou o mundo de tal maneira que deu o seu Filho unigênito, para que todo aquele que nele crê não pereça, mas tenha a vida eterna.
17 Porque Deus enviou o seu Filho ao mundo, não para que julgasse o mundo, mas para que o mundo fosse salvo por ele.
18 Quem crê nele não é julgado; mas quem não crê, já está julgado; porquanto não crê no nome do unigênito Filho de Deus.
19 E o julgamento é este: A luz veio ao mundo, e os homens amaram antes as trevas que a luz, porque as suas obras eram más.
20 Porque todo aquele que faz o mal aborrece a luz, e não vem para a luz, para que as suas obras não sejam reprovadas.
21 Mas quem pratica a verdade vem para a luz, a fim de que seja manifesto que as suas obras são feitas em Deus.
22 Depois disto foi Jesus com seus discípulos para a terra da Judéia, onde se demorou com eles e batizava.
23 Ora, João também estava batizando em Enom, perto de Salim, porque havia ali muitas águas; e o povo ía e se batizava.
24 Pois João ainda não fora lançado no cárcere.
25 Surgiu então uma contenda entre os discípulos de João e um judeu acerca da purificação.
26 E foram ter com João e disseram-lhe: Rabi, aquele que estava contigo além do Jordão, do qual tens dado testemunho, eis que está batizando, e todos vão ter com ele.
27 Respondeu João: O homem não pode receber coisa alguma, se não lhe for dada do céu.
28 Vós mesmos me sois testemunhas de que eu disse: Não sou o Cristo, mas sou enviado adiante dele.
29 Aquele que tem a noiva é o noivo; mas o amigo do noivo, que está presente e o ouve, regozija-se muito com a voz do noivo. Assim, pois, este meu gozo está completo.
30 É necessário que ele cresça e que eu diminua.
31 Aquele que vem de cima é sobre todos; aquele que vem da terra é da terra, e fala da terra. Aquele que vem do céu é sobre todos.
32 Aquilo que ele tem visto e ouvido, isso testifica; e ninguém aceita o seu testemunho.
33 Mas o que aceitar o seu testemunho, esse confirma que Deus é verdadeiro.
34 Pois aquele que Deus enviou fala as palavras de Deus; porque Deus não dá o Espírito por medida.
35 O Pai ama ao Filho, e todas as coisas entregou nas suas mãos.
36 Quem crê no Filho tem a vida eterna; o que, porém, desobedece ao Filho não verá a vida, mas sobre ele permanece a ira de Deus.'),
  ('22222222-2222-4222-8222-222222222222', 4, 'João 4', '1 Quando, pois, o Senhor soube que os fariseus tinham ouvido dizer que ele, Jesus, fazia e batizava mais discípulos do que João
2 (ainda que Jesus mesmo não batizava, mas os seus discípulos)
3 deixou a Judéia, e foi outra vez para a Galiléia.
4 E era-lhe necessário passar por Samária.
5 Chegou, pois, a uma cidade de Samária, chamada Sicar, junto da herdade que Jacó dera a seu filho José;
6 achava-se ali o poço de Jacó. Jesus, pois, cansado da viagem, sentou-se assim junto do poço; era cerca da hora sexta.
7 Veio uma mulher de Samária tirar água. Disse-lhe Jesus: Dá- me de beber.
8 Pois seus discípulos tinham ido à cidade comprar comida.
9 Disse-lhe então a mulher samaritana: Como, sendo tu judeu, me pedes de beber a mim, que sou mulher samaritana? (Porque os judeus não se comunicavam com os samaritanos.)
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
25 Replicou-lhe a mulher: Eu sei que vem o Messias (que se chama o Cristo); quando ele vier há de nos anunciar todas as coisas.
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
  ('22222222-2222-4222-8222-222222222222', 5, 'João 5', '1 Depois disso havia uma festa dos judeus; e Jesus subiu a Jerusalém.
2 Ora, em Jerusalém, próximo à porta das ovelhas, há um tanque, chamado em hebraico Betesda, o qual tem cinco alpendres.
3 Nestes jazia grande multidão de enfermos, cegos, mancos e ressicados [esperando o movimento da água.]
4 [Porquanto um anjo descia em certo tempo ao tanque, e agitava a água; então o primeiro que ali descia, depois do movimento da água, sarava de qualquer enfermidade que tivesse.]
5 Achava-se ali um homem que, havia trinta e oito anos, estava enfermo.
6 Jesus, vendo-o deitado e sabendo que estava assim havia muito tempo, perguntou-lhe: Queres ficar são?
7 Respondeu-lhe o enfermo: Senhor, não tenho ninguém que, ao ser agitada a água, me ponha no tanque; assim, enquanto eu vou, desce outro antes de mim.
8 Disse-lhe Jesus: Levanta-te, toma o teu leito e anda.
9 Imediatamente o homem ficou são; e, tomando o seu leito, começou a andar. Ora, aquele dia era sábado.
10 Pelo que disseram os judeus ao que fora curado: Hoje é sábado, e não te é lícito carregar o leito.
11 Ele, porém, lhes respondeu: Aquele que me curou, esse mesmo me disse: Toma o teu leito e anda.
12 Perguntaram-lhe, pois: Quem é o homem que te disse: Toma o teu leito e anda?
13 Mas o que fora curado não sabia quem era; porque Jesus se retirara, por haver muita gente naquele lugar.
14 Depois Jesus o encontrou no templo, e disse-lhe: Olha, já estás curado; não peques mais, para que não te suceda coisa pior.
15 Retirou-se, então, o homem, e contou aos judeus que era Jesus quem o curara.
16 Por isso os judeus perseguiram a Jesus, porque fazia estas coisas no sábado.
17 Mas Jesus lhes respondeu: Meu Pai trabalha até agora, e eu trabalho também.
18 Por isso, pois, os judeus ainda mais procuravam matá-lo, porque não só violava o sábado, mas também dizia que Deus era seu próprio Pai, fazendo-se igual a Deus.
19 Disse-lhes, pois, Jesus: Em verdade, em verdade vos digo que o Filho de si mesmo nada pode fazer, senão o que vir o Pai fazer; porque tudo quanto ele faz, o Filho o faz igualmente.
20 Porque o Pai ama ao Filho, e mostra-lhe tudo o que ele mesmo faz; e maiores obras do que estas lhe mostrará, para que vos maravilheis.
21 Pois, assim como o Pai levanta os mortos e lhes dá vida, assim também o Filho dá vida a quem ele quer.
22 Porque o Pai a niguém julga, mas deu ao Filho todo o julgamento,
23 para que todos honrem o Filho, assim como honram o Pai. Quem não honra o Filho, não honra o Pai que o enviou.
24 Em verdade, em verdade vos digo que quem ouve a minha palavra, e crê naquele que me enviou, tem a vida eterna e não entra em juízo, mas já passou da morte para a vida.
25 Em verdade, em verdade vos digo que vem a hora, e agora é, em que os mortos ouvirão a voz do Filho de Deus, e os que a ouvirem viverão.
26 Pois assim como o Pai tem vida em si mesmo, assim também deu ao Filho ter vida em si mesmos;
27 e deu-lhe autoridade para julgar, porque é o Filho do homem.
28 Não vos admireis disso, porque vem a hora em que todos os que estão nos sepulcros ouvirão a sua voz e sairão:
29 os que tiverem feito o bem, para a ressurreição da vida, e os que tiverem praticado o mal, para a ressurreição do juízo.
30 Eu não posso de mim mesmo fazer coisa alguma; como ouço, assim julgo; e o meu juízo é justo, porque não procuro a minha vontade, mas a vontade daquele que me enviou.
31 Se eu der testemunho de mim mesmo, o meu testemunho não é verdadeiro.
32 Outro é quem dá testemunho de mim; e sei que o testemunho que ele dá de mim é verdadeiro.
33 Vós mandastes mensageiros a João, e ele deu testemunho da verdade;
34 eu, porém, não recebo testemunho de homem; mas digo isto para que sejais salvos.
35 Ele era a lâmpada que ardia e alumiava; e vós quisestes alegrar-vos por um pouco de tempo com a sua luz.
36 Mas o testemunho que eu tenho é maior do que o de João; porque as obras que o Pai me deu para realizar, as mesmas obras que faço dão testemunho de mim que o Pai me enviou.
37 E o Pai que me enviou, ele mesmo tem dado testemunho de mim. Vós nunca ouvistes a sua voz, nem vistes a sua forma;
38 e a sua palavra não permanece em vós; porque não credes naquele que ele enviou.
39 Examinais as Escrituras, porque julgais ter nelas a vida eterna; e são elas que dão testemunho de mim;
40 mas não quereis vir a mim para terdes vida!
41 Eu não recebo glória da parte dos homens;
42 mas bem vos conheço, que não tendes em vós o amor de Deus.
43 Eu vim em nome de meu Pai, e não me recebeis; se outro vier em seu próprio nome, a esse recebereis.
44 Como podeis crer, vós que recebeis glória uns dos outros e não buscais a glória que vem do único Deus?
45 Não penseis que eu vos hei de acusar perante o Pai. Há um que vos acusa, Moisés, em quem vós esperais.
46 Pois se crêsseis em Moisés, creríeis em mim; porque de mim ele escreveu.
47 Mas, se não credes nos escritos, como crereis nas minhas palavras?'),
  ('22222222-2222-4222-8222-222222222222', 6, 'João 6', '1 Depois disto partiu Jesus para o outro lado do mar da Galiléia, também chamado de Tiberíades.
2 E seguia-o uma grande multidão, porque via os sinais que operava sobre os enfermos.
3 Subiu, pois, Jesus ao monte e sentou-se ali com seus discípulos.
4 Ora, a páscoa, a festa dos judeus, estava próxima.
5 Então Jesus, levantando os olhos, e vendo que uma grande multidão vinha ter com ele, disse a Felipe: Onde compraremos pão, para estes comerem?
6 Mas dizia isto para o experimentar; pois ele bem sabia o que ia fazer.
7 Respondeu-lhe Felipe: Duzentos denários de pão não lhes bastam, para que cada um receba um pouco.
8 Ao que lhe disse um dos seus discípulos, André, irmão de Simão Pedro:
9 Está aqui um rapaz que tem cinco pães de cevada e dois peixinhos; mas que é isto para tantos?
10 Disse Jesus: Fazei reclinar-se o povo. Ora, naquele lugar havia muita relva. Reclinaram-se aí, pois, os homens em número de quase cinco mil.
11 Jesus, então, tomou os pães e, havendo dado graças, repartiu-os pelos que estavam reclinados; e de igual modo os peixes, quanto eles queriam.
12 E quando estavam saciados, disse aos seus discípulos: Recolhei os pedaços que sobejaram, para que nada se perca.
13 Recolheram-nos, pois e encheram doze cestos de pedaços dos cinco pães de cevada, que sobejaram aos que haviam comido.
14 Vendo, pois, aqueles homens o sinal que Jesus operara, diziam: este é verdadeiramente o profeta que havia de vir ao mundo.
15 Percebendo, pois, Jesus que estavam prestes a vir e levá-lo à força para o fazerem rei, tornou a retirar-se para o monte, ele sozinho.
16 Ao cair da tarde, desceram os seus discípulos ao mar;
17 e, entrando num barco, atravessavam o mar em direção a Cafarnaum; enquanto isso, escurecera e Jesus ainda não tinha vindo ter com eles;
18 ademais, o mar se empolava, porque soprava forte vento.
19 Tendo, pois, remado uns vinte e cinco ou trinta estádios, viram a Jesus andando sobre o mar e aproximando-se do barco; e ficaram atemorizados.
20 Mas ele lhes disse: Sou eu; não temais.
21 Então eles de boa mente o receberam no barco; e logo o barco chegou à terra para onde iam.
22 No dia seguinte, a multidão que ficara no outro lado do mar, sabendo que não houvera ali senão um barquinho, e que Jesus não embarcara nele com seus discípulos, mas que estes tinham ido sós
23 (contudo, outros barquinhos haviam chegado a Tiberíades para perto do lugar onde comeram o pão, havendo o Senhor dado graças);
24 quando, pois, viram que Jesus não estava ali nem os seus discípulos, entraram eles também nos barcos, e foram a Cafarnaum, em busca de Jesus.
25 E, achando-o no outro lado do mar, perguntaram-lhe: Rabi, quando chegaste aqui?
26 Respondeu-lhes Jesus: Em verdade, em verdade vos digo que me buscais, não porque vistes sinais, mas porque comestes do pão e vos saciastes.
27 Trabalhai, não pela comida que perece, mas pela comida que permanece para a vida eterna, a qual o Filho do homem vos dará; pois neste, Deus, o Pai, imprimiu o seu selo.
28 Pergutaram-lhe, pois: Que havemos de fazer para praticarmos as obras de Deus?
29 Jesus lhes respondeu: A obra de Deus é esta: Que creiais naquele que ele enviou.
30 Perguntaram-lhe, então: Que sinal, pois, fazes tu, para que o vejamos e te creiamos? Que operas tu?
31 Nossos pais comeram o maná no deserto, como está escrito: Do céu deu-lhes pão a comer.
32 Respondeu-lhes Jesus: Em verdade, em verdade vos digo: Não foi Moisés que vos deu o pão do céu; mas meu Pai vos dá o verdadeiro pão do céu.
33 Porque o pão de Deus é aquele que desce do céu e dá vida ao mundo.
34 Disseram-lhe, pois: Senhor, dá-nos sempre desse pão.
35 Declarou-lhes Jesus. Eu sou o pão da vida; aquele que vem a mim, de modo algum terá fome, e quem crê em mim jamais tará sede.
36 Mas como já vos disse, vós me tendes visto, e contudo não credes.
37 Todo o que o Pai me dá virá a mim; e o que vem a mim de maneira nenhuma o lançarei fora.
38 Porque eu desci do céu, não para fazer a minha vontade, mas a vontade daquele que me enviou.
39 E a vontade do que me enviou é esta: Que eu não perca nenhum de todos aqueles que me deu, mas que eu o ressuscite no último dia.
40 Porquanto esta é a vontade de meu Pai: Que todo aquele que vê o Filho e crê nele, tenha a vida eterna; e eu o ressuscitarei no último dia.
41 Murmuravam, pois, dele os judeus, porque dissera: Eu sou o pão que desceu do céu;
42 e perguntavam: Não é Jesus, o filho de José, cujo pai e mãe nós conhecemos? Como, pois, diz agora: Desci do céu?
43 Respondeu-lhes Jesus: Não murmureis entre vós.
44 Ninguém pode vir a mim, se o Pai que me enviou não o trouxer; e eu o ressuscitarei no último dia.
45 Está escrito nos profetas: E serão todos ensinados por Deus. Portanto todo aquele que do Pai ouviu e aprendeu vem a mim.
46 Não que alguém tenha visto o Pai, senão aquele que é vindo de Deus; só ele tem visto o Pai.
47 Em verdade, em verdade vos digo: Aquele que crê tem a vida eterna.
48 Eu sou o pão da vida.
49 Vossos pais comeram o maná no deserto e morreram.
50 Este é o pão que desce do céu, para que o que dele comer não morra.
51 Eu sou o pão vivo que desceu do céu; se alguém comer deste pão, viverá para sempre; e o pão que eu darei pela vida do mundo é a minha carne.
52 Disputavam, pois, os judeus entre si, dizendo: Como pode este dar-nos a sua carne a comer?
53 Disse-lhes Jesus: Em verdade, em verdade vos digo: Se não comerdes a carne do Filho do homem, e não beberdes o seu sangue, não tereis vida em vós mesmos.
54 Quem come a minha carne e bebe o meu sangue tem a vida eterna; e eu o ressuscitarei no último dia.
55 Porque a minha carne verdadeiramente é comida, e o meu sangue verdadeiramente é bebida.
56 Quem come a minha carne e bebe o meu sangue permanece em mim e eu nele.
57 Assim como o Pai, que vive, me enviou, e eu vivo pelo Pai, assim, quem de mim se alimenta, também viverá por mim.
58 Este é o pão que desceu do céu; não é como o caso de vossos pais, que comeram o maná e morreram; quem comer este pão viverá para sempre.
59 Estas coisas falou Jesus quando ensinava na sinagoga em Cafarnaum.
60 Muitos, pois, dos seus discípulos, ouvindo isto, disseram: Duro é este discurso; quem o pode ouvir?
61 Mas, sabendo Jesus em si mesmo que murmuravam disto os seus discípulos, disse-lhes: Isto vos escandaliza?
62 Que seria, pois, se vísseis subir o Filho do homem para onde primeiro estava?
63 O espírito é o que vivifica, a carne para nada aproveita; as palavras que eu vos tenho dito são espírito e são vida.
64 Mas há alguns de vós que não crêem. Pois Jesus sabia, desde o princípio, quem eram os que não criam, e quem era o que o havia de entregar.
65 E continuou: Por isso vos disse que ninguém pode vir a mim, se pelo Pai lhe não for concedido.
66 Por causa disso muitos dos seus discípulos voltaram para trás e não andaram mais com ele.
67 Perguntou então Jesus aos doze: Quereis vós também retirar-vos?
68 Respondeu-lhe Simão Pedro: Senhor, para quem iremos nós? Tu tens as palavras da vida eterna.
69 E nós já temos crido e bem sabemos que tu és o Santo de Deus.
70 Respondeu-lhes Jesus: Não vos escolhi a vós os doze? Contudo um de vós é o diabo.
71 Referia-se a Judas, filho de Simão Iscariotes; porque era ele o que o havia de entregar, sendo um dos doze.'),
  ('22222222-2222-4222-8222-222222222222', 7, 'João 7', '1 Depois disto andava Jesus pela Galiléia; pois não queria andar pela Judéia, porque os judeus procuravam matá-lo.
2 Ora, estava próxima a festa dos judeus, a dos tabernáculos.
3 Disseram-lhe, então, seus irmãos: Retira-te daqui e vai para a Judéia, para que também os teus discípulos vejam as obras que fazes.
4 Porque ninguém faz coisa alguma em oculto, quando procura ser conhecido. Já que fazes estas coisas, manifesta-te ao mundo.
5 Pois nem seus irmãos criam nele.
6 Disse-lhes, então, Jesus: Ainda não é chegado o meu tempo; mas o vosso tempo sempre está presente.
7 O mundo não vos pode odiar; mas ele me odeia a mim, porquanto dele testifico que as suas obras são más.
8 Subi vós à festa; eu não subo ainda a esta festa, porque ainda não é chegado o meu tempo.
9 E, havendo-lhes dito isto, ficou na Galiléia.
10 Mas quando seus irmãos já tinham subido à festa, então subiu ele também, não publicamente, mas como em secreto.
11 Ora, os judeus o procuravam na festa, e perguntavam: Onde está ele?
12 E era grande a murmuração a respeito dele entre as multidões. Diziam alguns: Ele é bom. Mas outros diziam: não, antes engana o povo.
13 Todavia ninguém falava dele abertamente, por medo dos judeus.
14 Estando, pois, a festa já em meio, subiu Jesus ao templo e começou a ensinar.
15 Então os judeus se admiravam, dizendo: Como sabe este letras, sem ter estudado?
16 Respondeu-lhes Jesus: A minha doutrina não é minha, mas daquele que me enviou.
17 Se alguém quiser fazer a vontade de Deus, há de saber se a doutrina é dele, ou se eu falo por mim mesmo.
18 Quem fala por si mesmo busca a sua própria glória; mas o que busca a glória daquele que o enviou, esse é verdadeiro, e não há nele injustiça.
19 Não vos deu Moisés a lei? no entanto nenhum de vós cumpre a lei. Por que procurais matar-me?
20 Respondeu a multidão: Tens demônio; quem procura matar-te?
21 Replicou-lhes Jesus: Uma só obra fiz, e todos vós admirais por causa disto.
22 Moisés vos ordenou a circuncisão (não que fosse de Moisés, mas dos pais), e no sábado circuncidais um homem.
23 Ora, se um homem recebe a circuncisão no sábado, para que a lei de Moisés não seja violada, como vos indignais contra mim, porque no sábado tornei um homem inteiramente são?
24 Não julgueis pela aparência mas julgai segundo o reto juízo.
25 Diziam então alguns dos de Jerusalém: Não é este o que procuram matar?
26 E eis que ele está falando abertamente, e nada lhe dizem. Será que as autoridades realmente o reconhecem como o Cristo?
27 Entretanto sabemos donde este é; mas, quando vier o Cristo, ninguém saberá donde ele é.
28 Jesus, pois, levantou a voz no templo e ensinava, dizendo: Sim, vós me conheceis, e sabeis donde sou; contudo eu não vim de mim mesmo, mas aquele que me enviou é verdadeiro, o qual vós não conheceis.
29 Mas eu o conheço, porque dele venho, e ele me enviou.
30 Procuravam, pois, prendê-lo; mas ninguém lhe deitou as mãos, porque ainda não era chegada a sua hora.
31 Contudo muitos da multidão creram nele, e diziam: Será que o Cristo, quando vier, fará mais sinais do que este tem feito?
32 Os fariseus ouviram a multidão murmurar estas coisas a respeito dele; e os principais sacerdotes e os fariseus mandaram guardas para o prenderem.
33 Disse, pois, Jesus: Ainda um pouco de tempo estou convosco, e depois vou para aquele que me enviou.
34 Vós me buscareis, e não me achareis; e onde eu estou, vós não podeis vir.
35 Disseram, pois, os judeus uns aos outros: Para onde irá ele, que não o acharemos? Irá, porventura, à Dispersão entre os gregos, e ensinará os gregos?
36 Que palavra é esta que disse: Buscar-me-eis, e não me achareis; e, Onde eu estou, vós não podeis vir?
37 Ora, no seu último dia, o grande dia da festa, Jesus pôs-se em pé e clamou, dizendo: Se alguém tem sede, venha a mim e beba.
38 Quem crê em mim, como diz a Escritura, do seu interior correrão rios de água viva.
39 Ora, isto ele disse a respeito do Espírito que haviam de receber os que nele cressem; pois o Espírito ainda não fora dado, porque Jesus ainda não tinha sido glorificado.
40 Então alguns dentre o povo, ouvindo essas palavras, diziam: Verdadeiramente este é o profeta.
41 Outros diziam: Este é o Cristo; mas outros replicavam: Vem, pois, o Cristo da Galiléia?
42 Não diz a Escritura que o Cristo vem da descendência de Davi, e de Belém, a aldeia donde era Davi?
43 Assim houve uma dissensão entre o povo por causa dele.
44 Alguns deles queriam prendê-lo; mas ninguém lhe pôs as mãos.
45 Os guardas, pois, foram ter com os principais dos sacerdotes e fariseus, e estes lhes perguntaram: Por que não o trouxestes?
46 Responderam os guardas: Nunca homem algum falou assim como este homem.
47 Replicaram-lhes, pois, os fariseus: Também vós fostes enganados?
48 Creu nele porventura alguma das autoridades, ou alguém dentre os fariseus?
49 Mas esta multidão, que não sabe a lei, é maldita.
50 Nicodemos, um deles, que antes fora ter com Jesus, perguntou-lhes:
51 A nossa lei, porventura, julga um homem sem primeiro ouvi-lo e ter conhecimento do que ele faz?
52 Responderam-lhe eles: És tu também da Galiléia? Examina e vê que da Galiléia não surge profeta.
53 [E cada um foi para sua casa.'),
  ('22222222-2222-4222-8222-222222222222', 8, 'João 8', '1 Mas Jesus foi para o Monte das Oliveiras.
2 Pela manhã cedo voltou ao templo, e todo o povo vinha ter com ele; e Jesus, sentando-se o ensinava.
3 Então os escribas e fariseus trouxeram-lhe uma mulher apanhada em adultério; e pondo-a no meio,
4 disseram-lhe: Mestre, esta mulher foi apanhada em flagrante adultério.
5 Ora, Moisés nos ordena na lei que as tais sejam apedrejadas. Tu, pois, que dizes?
6 Isto diziam eles, tentando-o, para terem de que o acusar. Jesus, porém, inclinando-se, começou a escrever no chão com o dedo.
7 Mas, como insistissem em perguntar-lhe, ergueu-se e disse- lhes: Aquele dentre vós que está sem pecado seja o primeiro que lhe atire uma pedra.
8 E, tornando a inclinar-se, escrevia na terra.
9 Quando ouviram isto foram saindo um a um, a começar pelos mais velhos, até os últimos; ficou só Jesus, e a mulher ali em pé.
10 Então, erguendo-se Jesus e não vendo a ninguém senão a mulher, perguntou-lhe: Mulher, onde estão aqueles teus acusadores? Ninguém te condenou?
11 Respondeu ela: Ninguém, Senhor. E disse-lhe Jesus: Nem eu te condeno; vai-te, e não peques mais.]
12 Então Jesus tornou a falar-lhes, dizendo: Eu sou a luz do mundo; quem me segue de modo algum andará em trevas, mas terá a luz da vida.
13 Disseram-lhe, pois, os fariseus: Tu dás testemunho de ti mesmo; o teu testemunho não é verdadeiro.
14 Respondeu-lhes Jesus: Ainda que eu dou testemunho de mim mesmo, o meu testemunho é verdadeiro; porque sei donde vim, e para onde vou; mas vós não sabeis donde venho, nem para onde vou.
15 Vós julgais segundo a carne; eu a ninguém julgo.
16 E, mesmo que eu julgue, o meu juízo é verdadeiro; porque não sou eu só, mas eu e o Pai que me enviou.
17 Ora, na vossa lei está escrito que o testemunho de dois homens é verdadeiro.
18 Sou eu que dou testemunho de mim mesmo, e o Pai que me enviou, também dá testemunho de mim.
19 Perguntavam-lhe, pois: Onde está teu pai? Jesus respondeu: Não me conheceis a mim, nem a meu Pai; se vós me conhecêsseis a mim, também conheceríeis a meu Pai.
20 Essas palavras proferiu Jesus no lugar do tesouro, quando ensinava no templo; e ninguém o prendeu, porque ainda não era chegada a sua hora.
21 Disse-lhes, pois, Jesus outra vez: Eu me retiro; buscar-me- eis, e morrereis no vosso pecado. Para onde eu vou, vós não podeis ir.
22 Então diziam os judeus: Será que ele vai suicidar-se, pois diz: Para onde eu vou, vós não podeis ir?
23 Disse-lhes ele: Vós sois de baixo, eu sou de cima; vós sois deste mundo, eu não sou deste mundo.
24 Por isso vos disse que morrereis em vossos pecados; porque, se não crerdes que eu sou, morrereis em vossos pecados.
25 Perguntavam-lhe então: Quem és tu? Respondeu-lhes Jesus: Exatamente o que venho dizendo que sou.
26 Muitas coisas tenho que dizer e julgar acerca de vós; mas aquele que me enviou é verdadeiro; e o que dele ouvi, isso falo ao mundo.
27 Eles não perceberam que lhes falava do Pai.
28 Prosseguiu, pois, Jesus: Quando tiverdes levantado o Filho do homem, então conhecereis que eu sou, e que nada faço de mim mesmo; mas como o Pai me ensinou, assim falo.
29 E aquele que me enviou está comigo; não me tem deixado só; porque faço sempre o que é do seu agrado.
30 Falando ele estas coisas, muitos creram nele.
31 Dizia, pois, Jesus aos judeus que nele creram: Se vós permanecerdes na minha palavra, verdadeiramente sois meus discípulos;
32 e conhecereis a verdade, e a verdade vos libertará.
33 Responderam-lhe: Somos descendentes de Abraão, e nunca fomos escravos de ninguém; como dizes tu: Sereis livres?
34 Replicou-lhes Jesus: Em verdade, em verdade vos digo que todo aquele que comete pecado é escravo do pecado.
35 Ora, o escravo não fica para sempre na casa; o filho fica para sempre.
36 Se, pois, o Filho vos libertar, verdadeiramente sereis livres.
37 Bem sei que sois descendência de Abraão; contudo, procurais matar-me, porque a minha palavra não encontra lugar em vós.
38 Eu falo do que vi junto de meu Pai; e vós fazeis o que também ouvistes de vosso pai.
39 Responderam-lhe: Nosso pai é Abraão. Disse-lhes Jesus: Se sois filhos de Abraão, fazei as obras de Abraão.
40 Mas agora procurais matar-me, a mim que vos falei a verdade que de Deus ouvi; isso Abraão não fez.
41 Vós fazeis as obras de vosso pai. Replicaram-lhe eles: Nós não somos nascidos de prostituição; temos um Pai, que é Deus.
42 Respondeu-lhes Jesus: Se Deus fosse o vosso Pai, vós me amaríeis, porque eu saí e vim de Deus; pois não vim de mim mesmo, mas ele me enviou.
43 Por que não compreendeis a minha linguagem? é porque não podeis ouvir a minha palavra.
44 Vós tendes por pai o Diabo, e quereis satisfazer os desejos de vosso pai; ele é homicida desde o princípio, e nunca se firmou na verdade, porque nele não há verdade; quando ele profere mentira, fala do que lhe é próprio; porque é mentiroso, e pai da mentira.
45 Mas porque eu digo a verdade, não me credes.
46 Quem dentre vós me convence de pecado? Se digo a verdade, por que não me credes?
47 Quem é de Deus ouve as palavras de Deus; por isso vós não as ouvis, porque não sois de Deus.
48 Responderam-lhe os judeus: Não dizemos com razão que és samaritano, e que tens demônio?
49 Jesus respondeu: Eu não tenho demônio; antes honro a meu Pai, e vós me desonrais.
50 Eu não busco a minha glória; há quem a busque, e julgue.
51 Em verdade, em verdade vos digo que, se alguém guardar a minha palavra, nunca verá a morte.
52 Disseram-lhe os judeus: Agora sabemos que tens demônios. Abraão morreu, e também os profetas; e tu dizes: Se alguém guardar a minha palavra, nunca provará a morte!
53 Porventura és tu maior do que nosso pai Abraão, que morreu? Também os profetas morreram; quem pretendes tu ser?
54 Respondeu Jesus: Se eu me glorificar a mim mesmo, a minha glória não é nada; quem me glorifica é meu Pai, do qual vós dizeis que é o vosso Deus;
55 e vós não o conheceis; mas eu o conheço; e se disser que não o conheço, serei mentiroso como vós; mas eu o conheço, e guardo a sua palavra.
56 Abraão, vosso pai, exultou por ver o meu dia; viu-o, e alegrou-se.
57 Disseram-lhe, pois, os judeus: Ainda não tens cinquenta anos, e viste Abraão?
58 Respondeu-lhes Jesus: Em verdade, em verdade vos digo que antes que Abraão existisse, eu sou.
59 Então pegaram em pedras para lhe atirarem; mas Jesus ocultou-se, e saiu do templo.'),
  ('22222222-2222-4222-8222-222222222222', 9, 'João 9', '1 E passando Jesus, viu um homem cego de nascença.
2 Perguntaram-lhe os seus discípulos: Rabi, quem pecou, este ou seus pais, para que nascesse cego?
3 Respondeu Jesus: Nem ele pecou nem seus pais; mas foi para que nele se manifestem as obras de Deus.
4 Importa que façamos as obras daquele que me enviou, enquanto é dia; vem a noite, quando ninguém pode trabalhar.
5 Enquanto estou no mundo, sou a luz do mundo.
6 Dito isto, cuspiu no chão e com a saliva fez lodo, e untou com lodo os olhos do cego,
7 e disse-lhe: Vai, lava-te no tanque de Siloé (que significa Enviado). E ele foi, lavou-se, e voltou vendo.
8 Então os vizinhos e aqueles que antes o tinham visto, quando mendigo, perguntavam: Não é este o mesmo que se sentava a mendigar?
9 Uns diziam: É ele. E outros: Não é, mas se parece com ele. Ele dizia: Sou eu.
10 Perguntaram-lhe, pois: Como se te abriram os olhos?
11 Respondeu ele: O homem que se chama Jesus fez lodo, untou-me os olhos, e disse-me: Vai a Siloé e lava-te. Fui, pois, lavei-me, e fiquei vendo.
12 E perguntaram-lhe: Onde está ele? Respondeu: Não sei.
13 Levaram aos fariseus o que fora cego.
14 Ora, era sábado o dia em que Jesus fez o lodo e lhe abriu os olhos.
15 Então os fariseus também se puseram a perguntar-lhe como recebera a vista. Respondeu-lhes ele: Pôs-me lodo sobre os olhos, lavei-me e vejo.
16 Por isso alguns dos fariseus diziam: Este homem não é de Deus; pois não guarda o sábado. Diziam outros: Como pode um homem pecador fazer tais sinais? E havia dissensão entre eles.
17 Tornaram, pois, a perguntar ao cego: Que dizes tu a respeito dele, visto que te abriu os olhos? E ele respondeu: É profeta.
18 Os judeus, porém, não acreditaram que ele tivesse sido cego e recebido a vista, enquanto não chamaram os pais do que fora curado,
19 e lhes perguntaram: É este o vosso filho, que dizeis ter nascido cego? Como, pois, vê agora?
20 Responderam seus pais: Sabemos que este é o nosso filho, e que nasceu cego;
21 mas como agora vê, não sabemos; ou quem lhe abriu os olhos, nós não sabemos; perguntai a ele mesmo; tem idade; ele falará por si mesmo.
22 Isso disseram seus pais, porque temiam os judeus, porquanto já tinham estes combinado que se alguém confessasse ser Jesus o Cristo, fosse expulso da sinagoga.
23 Por isso é que seus pais disseram: Tem idade, perguntai-lho a ele mesmo.
24 Então chamaram pela segunda vez o homem que fora cego, e lhe disseram: Dá glória a Deus; nós sabemos que esse homem é pecador.
25 Respondeu ele: Se é pecador, não sei; uma coisa sei: eu era cego, e agora vejo.
26 Perguntaram-lhe pois: Que foi que te fez? Como te abriu os olhos?
27 Respondeu-lhes: Já vo-lo disse, e não atendestes; para que o quereis tornar a ouvir? Acaso também vós quereis tornar-vos discípulos dele?
28 Então o injuriaram, e disseram: Discípulo dele és tu; nós porém, somos discípulos de Moisés.
29 Sabemos que Deus falou a Moisés; mas quanto a este, não sabemos donde é.
30 Respondeu-lhes o homem: Nisto, pois, está a maravilha: não sabeis donde ele é, e entretanto ele me abriu os olhos;
31 sabemos que Deus não ouve a pecadores; mas, se alguém for temente a Deus, e fizer a sua vontade, a esse ele ouve.
32 Desde o princípio do mundo nunca se ouviu que alguém abrisse os olhos a um cego de nascença.
33 Se este não fosse de Deus, nada poderia fazer.
34 Replicaram-lhe eles: Tu nasceste todo em pecados, e vens nos ensinar a nós? E expulsaram-no.
35 Soube Jesus que o haviam expulsado; e achando-o perguntou- lhe: Crês tu no Filho do homem?
36 Respondeu ele: Quem é, senhor, para que nele creia?
37 Disse-lhe Jesus: Já o viste, e é ele quem fala contigo.
38 Disse o homem: Creio, Senhor! E o adorou.
39 Prosseguiu então Jesus: Eu vim a este mundo para juízo, a fim de que os que não vêem vejam, e os que vêem se tornem cegos.
40 Alguns fariseus que ali estavam com ele, ouvindo isso, perguntaram-lhe: Porventura somos nós também cegos?
41 Respondeu-lhes Jesus: Se fosseis cegos, não teríeis pecado; mas como agora dizeis: Nós vemos, permanece o vosso pecado.'),
  ('22222222-2222-4222-8222-222222222222', 10, 'João 10', '1 Em verdade, em verdade vos digo: quem não entra pela porta no aprisco das ovelhas, mas sobe por outra parte, esse é ladrão e salteador.
2 Mas o que entra pela porta é o pastor das ovelhas.
3 A este o porteiro abre; e as ovelhas ouvem a sua voz; e ele chama pelo nome as suas ovelhas, e as conduz para fora.
4 Depois de conduzir para fora todas as que lhe pertencem, vai adiante delas, e as ovelhas o seguem, porque conhecem a sua voz;
5 mas de modo algum seguirão o estranho, antes fugirão dele, porque não conhecem a voz dos estranhos.
6 Jesus propôs-lhes esta parábola, mas eles não entenderam o que era que lhes dizia.
7 Tornou, pois, Jesus a dizer-lhes: Em verdade, em verdade vos digo: eu sou a porta das ovelhas.
8 Todos quantos vieram antes de mim são ladrões e salteadores; mas as ovelhas não os ouviram.
9 Eu sou a porta; se alguém entrar a casa; o filho fica entrará e sairá, e achará pastagens.
10 O ladrão não vem senão para roubar, matar e destruir; eu vim para que tenham vida e a tenham em abundância.
11 Eu sou o bom pastor; o bom pastor dá a sua vida pelas ovelhas.
12 Mas o que é mercenário, e não pastor, de quem não são as ovelhas, vendo vir o lobo, deixa as ovelhas e foge; e o lobo as arrebata e dispersa.
13 Ora, o mercenário foge porque é mercenário, e não se importa com as ovelhas.
14 Eu sou o bom pastor; conheço as minhas ovelhas, e elas me conhecem,
15 assim como o Pai me conhece e eu conheço o Pai; e dou a minha vida pelas ovelhas.
16 Tenho ainda outras ovelhas que não são deste aprisco; a essas também me importa conduzir, e elas ouvirão a minha voz; e haverá um rebanho e um pastor.
17 Por isto o Pai me ama, porque dou a minha vida para a retomar.
18 Ninguém ma tira de mim, mas eu de mim mesmo a dou; tenho autoridade para a dar, e tenho autoridade para retomá-la. Este mandamento recebi de meu Pai.
19 Por causa dessas palavras, houve outra dissensão entre os judeus.
20 E muitos deles diziam: Tem demônio, e perdeu o juízo; por que o escutais?
21 Diziam outros: Essas palavras não são de quem está endemoninhado; pode porventura um demônio abrir os olhos aos cegos?
22 Celebrava-se então em Jerusalém a festa da dedicação. E era inverno.
23 Andava Jesus passeando no templo, no pórtico de Salomão.
24 Rodearam-no, pois, os judeus e lhe perguntavam: Até quando nos deixarás perplexos? Se tu és o Cristo, dize-no-lo abertamente.
25 Respondeu-lhes Jesus: Já vo-lo disse, e não credes. As obras que eu faço em nome de meu Pai, essas dão testemunho de mim.
26 Mas vós não credes, porque não sois das minhas ovelhas.
27 As minhas ovelhas ouvem a minha voz, e eu as conheço, e elas me seguem;
28 eu lhes dou a vida eterna, e jamais perecerão; e ninguém as arrebatará da minha mão.
29 Meu Pai, que mas deu, é maior do que todos; e ninguém pode arrebatá-las da mão de meu Pai.
30 Eu e o Pai somos um.
31 Os judeus pegaram então outra vez em pedras para o apedrejar.
32 Disse-lhes Jesus: Muitas obras boas da parte de meu Pai vos tenho mostrado; por qual destas obras ides apedrejar-me?
33 Responderam-lhe os judeus: Não é por nenhuma obra boa que vamos apedrejar-te, mas por blasfêmia; e porque, sendo tu homem, te fazes Deus.
34 Tornou-lhes Jesus: Não está escrito na vossa lei: Eu disse: Vós sois deuses?
35 Se a lei chamou deuses àqueles a quem a palavra de Deus foi dirigida (e a Escritura não pode ser anulada),
36 àquele a quem o Pai santificou, e enviou ao mundo, dizeis vós: Blasfemas; porque eu disse: Sou Filho de Deus?
37 Se não faço as obras de meu Pai, não me acrediteis.
38 Mas se as faço, embora não me creiais a mim, crede nas obras; para que entendais e saibais que o Pai está em mim e eu no Pai.
39 Outra vez, pois, procuravam prendê-lo; mas ele lhes escapou das mãos.
40 E retirou-se de novo para além do Jordão, para o lugar onde João batizava no princípio; e ali ficou.
41 Muitos foram ter com ele, e diziam: João, na verdade, não fez sinal algum, mas tudo quanto disse deste homem era verdadeiro.
42 E muitos ali creram nele.'),
  ('22222222-2222-4222-8222-222222222222', 11, 'João 11', '1 Ora, estava enfermo um homem chamado Lázaro, de Betânia, aldeia de Maria e de sua irmã Marta.
2 E Maria, cujo irmão Lázaro se achava enfermo, era a mesma que ungiu o Senhor com bálsamo, e lhe enxugou os pés com os seus cabelos.
3 Mandaram, pois, as irmãs dizer a Jesus: Senhor, eis que está enfermo aquele que tu amas.
4 Jesus, porém, ao ouvir isto, disse: Esta enfermidade não é para a morte, mas para glória de Deus, para que o Filho de Deus seja glorificado por ela.
5 Ora, Jesus amava a Marta, e a sua irmã, e a Lázaro.
6 Quando, pois, ouviu que estava enfermo, ficou ainda dois dias no lugar onde se achava.
7 Depois disto, disse a seus discípulos: Vamos outra vez para Judéia.
8 Disseram-lhe eles: Rabi, ainda agora os judeus procuravam apedrejar-te, e voltas para lá?
9 Respondeu Jesus: Não são doze as horas do dia? Se alguém andar de dia, não tropeça, porque vê a luz deste mundo;
10 mas se andar de noite, tropeça, porque nele não há luz.
11 E, tendo assim falado, acrescentou: Lázaro, o nosso amigo, dorme, mas vou despertá-lo do sono.
12 Disseram-lhe, pois, os discípulos: Senhor, se dorme, ficará bom.
13 Mas Jesus falara da sua morte; eles, porém, entenderam que falava do repouso do sono.
14 Então Jesus lhes disse claramente: Lázaro morreu;
15 e, por vossa causa, folgo de que eu lá não estivesse, para para que creiais; mas vamos ter com ele.
16 Disse, pois, Tomé, chamado Dídimo, aos seus condiscípulos: Vamos nós também, para morrermos com ele.
17 Chegando pois Jesus, encontrou-o já com quatro dias de sepultura.
18 Ora, Betânia distava de Jerusalém cerca de quinze estádios.
19 E muitos dos judeus tinham vindo visitar Marta e Maria, para as consolar acerca de seu irmão.
20 Marta, pois, ao saber que Jesus chegava, saiu-lhe ao encontro; Maria, porém, ficou sentada em casa.
21 Disse, pois, Marta a Jesus: Senhor, se meu irmão não teria morrido.
22 E mesmo agora sei que tudo quanto pedires a Deus, Deus to concederá.
23 Respondeu-lhe Jesus: Teu irmão há de ressurgir.
24 Disse-lhe Marta: Sei que ele há de ressurgir na ressurreição, no último dia.
25 Declarou-lhe Jesus: Eu sou a ressurreição e a vida; quem crê em mim, ainda que morra, viverá;
26 e todo aquele que vive, e crê em mim, jamais morrerá. Crês isto?
27 Respondeu-lhe Marta: Sim, Senhor, eu creio que tu és o Cristo, o Filho de Deus, que havia de vir ao mundo.
28 Dito isto, retirou-se e foi chamar em segredo a Maria, sua irmã, e lhe disse: O Mestre está aí, e te chama.
29 Ela, ouvindo isto, levantou-se depressa, e foi ter com ele.
30 Pois Jesus ainda não havia entrado na aldeia, mas estava no lugar onde Marta o encontrara.
31 Então os judeus que estavam com Maria em casa e a consolavam, vendo-a levantar-se apressadamente e sair, seguiram-na, pensando que ia ao sepulcro para chorar ali.
32 Tendo, pois, Maria chegado ao lugar onde Jesus estava, e vendo-a, lançou-se-lhe aos pés e disse: Senhor, se tu estiveras aqui, meu irmão não teria morrido.
33 Jesus, pois, quando a viu chorar, e chorarem também os judeus que com ela vinham, comoveu-se em espírito, e perturbou-se,
34 e perguntou: Onde o puseste? Responderam-lhe: Senhor, vem e vê.
35 Jesus chorou.
36 Disseram então os judeus: Vede como o amava.
37 Mas alguns deles disseram: Não podia ele, que abriu os olhos ao cego, fazer também que este não morreste?
38 Jesus, pois, comovendo-se outra vez, profundamente, foi ao sepulcro; era uma gruta, e tinha uma pedra posta sobre ela.
39 Disse Jesus: Tirai a pedra. Marta, irmã do defunto, disse- lhe: Senhor, já cheira mal, porque está morto há quase quatro dias.
40 Respondeu-lhe Jesus: Não te disse que, se creres, verás a glória de Deus?
41 Tiraram então a pedra. E Jesus, levantando os olhos ao céu, disse: Pai, graças te dou, porque me ouviste.
42 Eu sabia que sempre me ouves; mas por causa da multidão que está em redor é que assim falei, para que eles creiam que tu me enviaste.
43 E, tendo dito isso, clamou em alta voz: Lázaro, vem para fora!
44 Saiu o que estivera morto, ligados os pés e as mãos com faixas, e o seu rosto envolto num lenço. Disse-lhes Jesus: Desligai-o e deixai-o ir.
45 Muitos, pois, dentre os judeus que tinham vindo visitar Maria, e que tinham visto o que Jesus fizera, creram nele.
46 Mas alguns deles foram ter com os fariseus e disseram-lhes o que Jesus tinha feito.
47 Então os principais sacerdotes e os fariseus reuniram o sinédrio e diziam: Que faremos? porquanto este homem vem operando muitos sinais.
48 Se o deixarmos assim, todos crerão nele, e virão os romanos, e nos tirarão tanto o nosso lugar como a nossa nação.
49 Um deles, porém, chamado Caifás, que era sumo sacerdote naquele ano, disse-lhes: Vós nada sabeis,
50 nem considerais que vos convém que morra um só homem pelo povo, e que não pereça a nação toda.
51 Ora, isso não disse ele por si mesmo; mas, sendo o sumo sacerdote naquele ano, profetizou que Jesus havia de morrer pela nação,
52 e não somente pela nação, mas também para congregar num só corpo os filhos de Deus que estão dispersos.
53 Desde aquele dia, pois, tomavam conselho para o matarem.
54 De sorte que Jesus já não andava manifestamente entre os judeus, mas retirou-se dali para a região vizinha ao deserto, a uma cidade chamada Efraim; e ali demorou com os seus discípulos.
55 Ora, estava próxima a páscoa dos judeus, e dessa região subiram muitos a Jerusalém, antes da páscoa, para se purificarem.
56 Buscavam, pois, a Jesus e diziam uns aos outros, estando no templo: Que vos parece? Não virá ele à festa?
57 Ora, os principais sacerdotes e os fariseus tinham dado ordem que, se alguém soubesse onde ele estava, o denunciasse, para que o prendessem.'),
  ('22222222-2222-4222-8222-222222222222', 12, 'João 12', '1 Veio, pois, Jesus seis dias antes da páscoa, a Betânia, onde estava Lázaro, a quem ele ressuscitara dentre os mortos.
2 Deram-lhe ali uma ceia; Marta servia, e Lázaro era um dos que estavam à mesa com ele.
3 Então Maria, tomando uma libra de bálsamo de nardo puro, de grande preço, ungiu os pés de Jesus, e os enxugou com os seus cabelos; e encheu-se a casa do cheiro do bálsamo.
4 Mas Judas Iscariotes, um dos seus discípulos, aquele que o havia de trair disse:
5 Por que não se vendeu este bálsamo por trezentos denários e não se deu aos pobres?
6 Ora, ele disse isto, não porque tivesse cuidado dos pobres, mas porque era ladrão e, tendo a bolsa, subtraía o que nela se lançava.
7 Respondeu, pois Jesus: Deixa-a; para o dia da minha preparação para a sepultura o guardou;
8 porque os pobres sempre os tendes convosco; mas a mim nem sempre me tendes.
9 E grande número dos judeus chegou a saber que ele estava ali: e afluiram, não só por causa de Jesus mas também para verem a Lázaro, a quem ele ressuscitara dentre os mortos.
10 Mas os principais sacerdotes deliberaram matar também a Lázaro;
11 porque muitos, por causa dele, deixavam os judeus e criam em Jesus.
12 No dia seguinte, as grandes multidões que tinham vindo à festa, ouvindo dizer que Jesus vinha a Jerusalém,
13 tomaram ramos de palmeiras, e saíram-lhe ao encontro, e clamavam: Hosana! Bendito o que vem em nome do Senhor! Bendito o rei de Israel!
14 E achou Jesus um jumentinho e montou nele, conforme está escrito:
15 Não temas, ó filha de Sião; eis que vem teu Rei, montado sobre o filho de uma jumenta.
16 Os seus discípulos, porém, a princípio não entenderam isto; mas quando Jesus foi glorificado, então eles se lembraram de que estas coisas estavam escritas a respeito dele, e de que assim lhe fizeram.
17 Dava-lhe, pois, testemunho a multidão que estava com ele quando chamara a Lázaro da sepultura e o ressuscitara dentre os mortos;
18 e foi por isso que a multidão lhe saiu ao encontro, por ter ouvido que ele fizera este sinal.
19 De sorte que os fariseus disseram entre si: Vedes que nada aproveitais? eis que o mundo inteiro vai após ele.
20 Ora, entre os que tinham subido a adorar na festa havia alguns gregos.
21 Estes, pois, dirigiram-se a Felipe, que era de Betsaida da Galiléia, e rogaram-lhe, dizendo: Senhor, queríamos ver a Jesus.
22 Felipe foi dizê-lo a André, e então André e Felipe foram dizê-lo a Jesus.
23 Respondeu-lhes Jesus: É chegada a hora de ser glorificado o Filho do homem.
24 Em verdade, em verdade vos digo: Se o grão de trigo caindo na terra não morrer, fica ele só; mas se morrer, dá muito fruto.
25 Quem ama a sua vida, perdê-la-á; e quem neste mundo odeia a a sua vida, guardá-la-á para a vida eterna.
26 Se alguém me quiser servir, siga-me; e onde eu estiver, ali estará também o meu servo; se alguém me servir, o Pai o honrará.
27 Agora a minha alma está perturbada; e que direi eu? Pai, salva-me desta hora? Mas para isto vim a esta hora.
28 Pai, glorifica o teu nome. Veio, então, do céu esta voz: Já o tenho glorificado, e outra vez o glorificarei.
29 A multidão, pois, que ali estava, e que a ouvira, dizia ter havido um trovão; outros diziam: Um anjo lhe falou.
30 Respondeu Jesus: Não veio esta voz por minha causa, mas por causa de vós.
31 Agora é o juízo deste mundo; agora será expulso o príncipe deste mundo.
32 E eu, quando for levantado da terra, todos atrairei a mim.
33 Isto dizia, significando de que modo havia de morrer.
34 Respondeu-lhe a multidão: Nós temos ouvido da lei que o Cristo permanece para sempre; e como dizes tu: Importa que o Filho do homem seja levantado? Quem é esse Filho do homem?
35 Disse-lhes então Jesus: Ainda por um pouco de tempo a luz está entre vós. Andai enquanto tendes a luz, para que as trevas não vos apanhem; pois quem anda nas trevas não sabe para onde vai.
36 Enquanto tendes a luz, crede na luz, para que vos torneis filhos da luz. Havendo Jesus assim falado, retirou-se e escondeu-se deles.
37 E embora tivesse operado tantos sinais diante deles, não criam nele;
38 para que se cumprisse a palavra do profeta Isaías: Senhor, quem creu em nossa pregação? e aquem foi revelado o braço do Senhor?
39 Por isso não podiam crer, porque, como disse ainda Isaías:
40 Cegou-lhes os olhos e endureceu-lhes o coração, para que não vejam com os olhos e entendam com o coração, e se convertam, e eu os cure.
41 Estas coisas disse Isaías, porque viu a sua glória, e dele falou.
42 Contudo, muitos dentre as próprias autoridades creram nele; mas por causa dos fariseus não o confessavam, para não serem expulsos da sinagoga;
43 porque amaram mais a glória dos homens do que a glória de Deus.
44 Clamou Jesus, dizendo: Quem crê em mim, crê, nâo em mim, mas naquele que me enviou.
45 E quem me vê a mim, vê aquele que me enviou.
46 Eu, que sou a luz, vim ao mundo, para que todo aquele que crê em mim não permaneça nas trevas.
47 E, se alguém ouvir as minhas palavras, e não as guardar, eu não o julgo; pois eu vim, não para julgar o mundo, mas para salvar o mundo.
48 Quem me rejeita, e não recebe as minhas palavras, já tem quem o julgue; a palavra que tenho pregado, essa o julgará no último dia.
49 Porque eu não falei por mim mesmo; mas o Pai, que me enviou, esse me deu mandamento quanto ao que dizer e como falar.
50 E sei que o seu mandamento é vida eterna. Aquilo, pois, que eu falo, falo-o exatamente como o Pai me ordenou.'),
  ('22222222-2222-4222-8222-222222222222', 13, 'João 13', '1 Antes da festa da páscoa, sabendo Jesus que era chegada a sua hora de passar deste mundo para o Pai, e havendo amado os seus que estavam no mundo, amou-os até o fim.
2 Enquanto ceavam, tendo já o Diabo posto no coração de Judas, filho de Simão Iscariotes, que o traísse,
3 Jesus, sabendo que o Pai lhe entregara tudo nas mãos, e que viera de Deus e para Deus voltava,
4 levantou-se da ceia, tirou o manto e, tomando uma toalha, cingiu-se.
5 Depois deitou água na bacia e começou a lavar os pés aos discípulos, e a enxugar-lhos com a toalha com que estava cingido.
6 Chegou, pois, a Simão Pedro, que lhe disse: Senhor, lavas-me os pés a mim?
7 Respondeu-lhe Jesus: O que eu faço, tu não o sabes agora; mas depois o entenderás.
8 Tornou-lhe Pedro: Nunca me lavarás os pés. Replicou-lhe Jesus: Se eu não te lavar, não tens parte comigo.
9 Disse-lhe Simão Pedro: Senhor, não somente os meus pés, mas também as mãos e a cabeça.
10 Respondeu-lhe Jesus: Aquele que se banhou não necessita de lavar senão os pés, pois no mais está todo limpo; e vós estais limpos, mas não todos.
11 Pois ele sabia quem o estava traindo; por isso disse: Nem todos estais limpos.
12 Ora, depois de lhes ter lavado os pés, tomou o manto, tornou a reclinar-se à mesa e perguntou-lhes: Entendeis o que vos tenho feito?
13 Vós me chamais Mestre e Senhor; e dizeis bem, porque eu o sou.
14 Ora, se eu, o Senhor e Mestre, vos lavei os pés, também vós deveis lavar os pés uns aos outros.
15 Porque eu vos dei exemplo, para que, como eu vos fiz, façais vós também.
16 Em verdade, em verdade vos digo: Não é o servo maior do que o seu senhor, nem o enviado maior do que aquele que o enviou.
17 Se sabeis estas coisas, bem-aventurados sois se as praticardes.
18 Não falo de todos vós; eu conheço aqueles que escolhi; mas para que se cumprisse a escritura: O que comia do meu pão, levantou contra mim o seu calcanhar.
19 Desde já no-lo digo, antes que suceda, para que, quando suceder, creiais que eu sou.
20 Em verdade, em verdade vos digo: Quem receber aquele que eu enviar, a mim me recebe; e quem me recebe a mim, recebe aquele que me enviou.
21 Tendo Jesus dito isto, turbou-se em espírito, e declarou: Em verdade, em verdade vos digo que um de vós me há de trair.
22 Os discípulos se entreolhavam, perplexos, sem saber de quem ele falava.
23 Ora, achava-se reclinado sobre o peito de Jesus um de seus discípulos, aquele a quem Jesus amava.
24 A esse, pois, fez Simão Pedro sinal, e lhe pediu: Pergunta- lhe de quem é que fala.
25 Aquele discípulo, recostando-se assim ao peito de Jesus, perguntou-lhe: Senhor, quem é?
26 Respondeu Jesus: É aquele a quem eu der o pedaço de pão molhado. Tendo, pois, molhado um bocado de pão, deu-o a Judas, filho de Simão Iscariotes.
27 E, logo após o bocado, entrou nele Satanás. Disse-lhe, pois, Jesus: O que fazes, faze-o depressa.
28 E nenhum dos que estavam à mesa percebeu a que propósito lhe disse isto;
29 pois, como Judas tinha a bolsa, pensavam alguns que Jesus lhe queria dizer: Compra o que nos é necessário para a festa; ou, que desse alguma coisa aos pobres.
30 Então ele, tendo recebido o bocado saiu logo. E era noite.
31 Tendo ele, pois, saído, disse Jesus: Agora é glorificado o Filho do homem, e Deus é glorificado nele;
32 se Deus é glorificado nele, também Deus o glorificará em si mesmo, e logo o há de glorificar.
33 Filhinhos, ainda por um pouco estou convosco. Procurar-me- eis; e, como eu disse aos judeus, também a vós o digo agora: Para onde eu vou, não podeis vós ir.
34 Um novo mandamento vos dou: que vos ameis uns aos outros; assim como eu vos amei a vós, que também vós vos ameis uns aos outros.
35 Nisto conhecerão todos que sois meus discípulos, se tiverdes amor uns aos outros.
36 Perguntou-lhe Simão Pedro: Senhor, para onde vais? Respondeu Jesus; Para onde eu vou, não podes agora seguir-me; mais tarde, porém, me seguirás.
37 Disse-lhe Pedro: Por que não posso seguir-te agora? Por ti darei a minha vida.
38 Respondeu Jesus: Darás a tua vida por mim? Em verdade, em verdade te digo: Não cantará o galo até que me tenhas negado três vezes.'),
  ('22222222-2222-4222-8222-222222222222', 14, 'João 14', '1 Não se turbe o vosso coração; credes em Deus, crede também em mim.
2 Na casa de meu Pai há muitas moradas; se não fosse assim, eu vo-lo teria dito; vou preparar-vos lugar.
3 E, se eu for e vos preparar lugar, virei outra vez, e vos tomarei para mim mesmo, para que onde eu estiver estejais vós também.
4 E para onde eu vou vós conheceis o caminho.
5 Disse-lhe Tomé: Senhor, não sabemos para onde vais; e como podemos saber o caminho?
6 Respondeu-lhe Jesus: Eu sou o caminho, e a verdade, e a vida; ninguém vem ao Pai, senão por mim.
7 Se vós me conhecêsseis a mim, também conheceríeis a meu Pai; e já desde agora o conheceis, e o tendes visto.
8 Disse-lhe Felipe: Senhor, mostra-nos o Pai, e isso nos basta.
9 Respondeu-lhe Jesus: Há tanto tempo que estou convosco, e ainda não me conheces, Felipe? Quem me viu a mim, viu o Pai; como dizes tu: Mostra-nos o Pai?
10 Não crês tu que eu estou no Pai, e que o Pai está em mim? As palavras que eu vos digo, não as digo por mim mesmo; mas o Pai, que permanece em mim, é quem faz as suas obras.
11 Crede-me que eu estou no Pai, e que o Pai está em mim; crede ao menos por causa das mesmas obras.
12 Em verdade, em verdade vos digo: Aquele que crê em mim, esse também fará as obras que eu faço, e as fará maiores do que estas; porque eu vou para o Pai;
13 e tudo quanto pedirdes em meu nome, eu o farei, para que o Pai seja glorificado no Filho.
14 Se me pedirdes alguma coisa em meu nome, eu a farei.
15 Se me amardes, guardareis os meus mandamentos.
16 E eu rogarei ao Pai, e ele vos dará outro Ajudador, para que fique convosco para sempre.
17 a saber, o Espírito da verdade, o qual o mundo não pode receber; porque não o vê nem o conhece; mas vós o conheceis, porque ele habita convosco, e estará em vós.
18 Não vos deixarei órfãos; voltarei a vós.
19 Ainda um pouco, e o mundo não me verá mais; mas vós me vereis, porque eu vivo, e vós vivereis.
20 Naquele dia conhecereis que estou em meu Pai, e vós em mim, e eu em vós.
21 Aquele que tem os meus mandamentos e os guarda, esse é o que me ama; e aquele que me ama será amado de meu Pai, e eu o amarei, e me manifestarei a ele.
22 Perguntou-lhe Judas (não o Iscariotes): O que houve, Senhor, que te hás de manifestar a nós, e não ao mundo?
23 Respondeu-lhe Jesus: Se alguém me amar, guardará a minha palavra; e meu Pai o amará, e viremos a ele, e faremos nele morada.
24 Quem não me ama, não guarda as minhas palavras; ora, a palavra que estais ouvindo não é minha, mas do Pai que me enviou.
25 Estas coisas vos tenho falado, estando ainda convosco.
26 Mas o Ajudador, o Espírito Santo a quem o Pai enviará em meu nome, esse vos ensinará todas as coisas, e vos fará lembrar de tudo quanto eu vos tenho dito.
27 Deixo-vos a paz, a minha paz vos dou; eu não vo-la dou como o mundo a dá. Não se turbe o vosso coração, nem se atemorize.
28 Ouvistes que eu vos disse: Vou, e voltarei a vós. Se me amásseis, alegrar-vos-íeis de que eu vá para o Pai; porque o Pai é maior do que eu.
29 Eu vo-lo disse agora, antes que aconteça, para que, quando acontecer, vós creiais.
30 Já não falarei muito convosco, porque vem o príncipe deste mundo, e ele nada tem em mim;
31 mas, assim como o Pai me ordenou, assim mesmo faço, para que o mundo saiba que eu amo o Pai. Levantai-vos, vamo-nos daqui.'),
  ('22222222-2222-4222-8222-222222222222', 15, 'João 15', '1 Eu sou a videira verdadeira, e meu Pai é o viticultor.
2 Toda vara em mim que não dá fruto, ele a corta; e toda vara que dá fruto, ele a limpa, para que dê mais fruto.
3 Vós já estais limpos pela palavra que vos tenho falado.
4 Permanecei em mim, e eu permanecerei em vós; como a vara de si mesma não pode dar fruto, se não permanecer na videira, assim também vós, se não permanecerdes em mim.
5 Eu sou a videira; vós sois as varas. Quem permanece em mim e eu nele, esse dá muito fruto; porque sem mim nada podeis fazer.
6 Quem não permanece em mim é lançado fora, como a vara, e seca; tais varas são recolhidas, lançadas no fogo e queimadas.
7 Se vós permanecerdes em mim, e as minhas palavras permanecerem em vós, pedi o que quiserdes, e vos será feito.
8 Nisto é glorificado meu Pai, que deis muito fruto; e assim sereis meus discípulos.
9 Como o Pai me amou, assim também eu vos amei; permanecei no meu amor.
10 Se guardardes os meus mandamentos, permanecereis no meu amor; do mesmo modo que eu tenho guardado os mandamentos de meu Pai, e permaneço no seu amor.
11 Estas coisas vos tenho dito, para que o meu gozo permaneça em vós, e o vosso gozo seja completo.
12 O meu mandamento é este: Que vos ameis uns aos outros, assim como eu vos amei.
13 Ninguém tem maior amor do que este, de dar alguém a sua vida pelos seus amigos.
14 Vós sois meus amigos, se fizerdes o que eu vos mando.
15 Já não vos chamo servos, porque o servo não sabe o que faz o seu senhor; mas chamei-vos amigos, porque tudo quanto ouvi de meu Pai vos dei a conhecer.
16 Vós não me escolhestes a mim mas eu vos escolhi a vós, e vos designei, para que vades e deis frutos, e o vosso fruto permaneça, a fim de que tudo quanto pedirdes ao Pai em meu nome, ele vo-lo conceda.
17 Isto vos mando: que vos ameis uns aos outros.
18 Se o mundo vos odeia, sabei que, primeiro do que a vós, me odiou a mim.
19 Se fôsseis do mundo, o mundo amaria o que era seu; mas, porque não sois do mundo, antes eu vos escolhi do mundo, por isso é que o mundo vos odeia.
20 Lembrai-vos da palavra que eu vos disse: Não é o servo maior do que o seu senhor. Se a mim me perseguiram, também vos perseguirão a vós; se guardaram a minha palavra, guardarão também a vossa.
21 Mas tudo isto vos farão por causa do meu nome, porque não conhecem aquele que me enviou.
22 Se eu não viera e não lhes falara, não teriam pecado; agora, porém, não têm desculpa do seu pecado.
23 Aquele que me odeia a mim, odeia também a meu Pai.
24 Se eu entre eles não tivesse feito tais obras, quais nenhum outro fez, não teriam pecado; mas agora, não somente viram, mas também odiaram tanto a mim como a meu Pai.
25 Mas isto é para que se cumpra a palavra que está escrita na sua lei: Odiaram-me sem causa.
26 Quando vier o Ajudador, que eu vos enviarei da parte do Pai, o Espírito da verdade, que do Pai procede, esse dará testemunho de mim;
27 e também vós dareis testemunho, porque estais comigo desde o princípio.'),
  ('22222222-2222-4222-8222-222222222222', 16, 'João 16', '1 Tenho-vos dito estas coisas para que não vos escandalizeis.
2 Expulsar-vos-ão das sinagogas; ainda mais, vem a hora em que qualquer que vos matar julgará prestar um serviço a Deus.
3 E isto vos farão, porque não conheceram ao Pai nem a mim.
4 Mas tenho-vos dito estas coisas, a fim de que, quando chegar aquela hora, vos lembreis de que eu vo-las tinha dito. Não vo-las disse desde o princípio, porque estava convosco.
5 Agora, porém, vou para aquele que me enviou; e nenhum de vós me pergunta: Para onde vais?
6 Antes, porque vos disse isto, o vosso coração se encheu de tristeza.
7 Todavia, digo-vos a verdade, convém-vos que eu vá; pois se eu não for, o Ajudador não virá a vós; mas, se eu for, vo-lo enviarei.
8 E quando ele vier, convencerá o mundo do pecado, da justiça e do juízo:
9 do pecado, porque não crêem em mim;
10 da justiça, porque vou para meu Pai, e não me vereis mais,
11 e do juízo, porque o príncipe deste mundo já está julgado.
12 Ainda tenho muito que vos dizer; mas vós não o podeis suportar agora.
13 Quando vier, porém, aquele, o Espírito da verdade, ele vos guiará a toda a verdade; porque não falará por si mesmo, mas dirá o que tiver ouvido, e vos anunciará as coisas vindouras.
14 Ele me glorificará, porque receberá do que é meu, e vo-lo anunciará.
15 Tudo quanto o Pai tem é meu; por isso eu vos disse que ele, recebendo do que é meu, vo-lo anunciará.
16 Um pouco, e já não me vereis; e outra vez um pouco, e ver-me-eis.
17 Então alguns dos seus discípulos perguntaram uns para os outros: Que é isto que nos diz? Um pouco, e não me vereis; e outra vez um pouco, e ver-me-eis; e: Porquanto vou para o Pai?
18 Diziam pois: Que quer dizer isto: Um pouco? Não compreendemos o que ele está dizendo.
19 Percebeu Jesus que o queriam interrogar, e disse-lhes: Indagais entre vós acerca disto que disse: Um pouco, e não me vereis; e outra vez um pouco, e ver-me-eis?
20 Em verdade, em verdade, vos digo que vós chorareis e vos lamentareis, mas o mundo se alegrará; vós estareis tristes, porém a vossa tristeza se converterá em alegria.
21 A mulher, quando está para dar à luz, sente tristeza porque é chegada a sua hora; mas, depois de ter dado à luz a criança, já não se lembra da aflição, pelo gozo de haver um homem nascido ao mundo.
22 Assim também vós agora, na verdade, tendes tristeza; mas eu vos tornarei a ver, e alegrar-se-á o vosso coração, e a vossa alegria ninguém vo-la tirará.
23 Naquele dia nada me perguntareis. Em verdade, em verdade vos digo que tudo quanto pedirdes ao Pai, ele vo-lo concederá em meu nome.
24 Até agora nada pedistes em meu nome; pedi, e recebereis, para que o vosso gozo seja completo.
25 Disse-vos estas coisas por figuras; chega, porém, a hora em que vos não falarei mais por figuras, mas abertamente vos falarei acerca do Pai.
26 Naquele dia pedireis em meu nome, e não vos digo que eu rogarei por vós ao Pai;
27 pois o Pai mesmo vos ama; visto que vós me amastes e crestes que eu saí de Deus.
28 Saí do Pai, e vim ao mundo; outra vez deixo o mundo, e vou para o Pai.
29 Disseram os seus discípulos: Eis que agora falas abertamente, e não por figura alguma.
30 Agora conhecemos que sabes todas as coisas, e não necessitas de que alguém te interrogue. Por isso cremos que saíste de Deus.
31 Respondeu-lhes Jesus: Credes agora?
32 Eis que vem a hora, e já é chegada, em que vós sereis dispersos cada um para o seu lado, e me deixareis só; mas não estou só, porque o Pai está comigo.
33 Tenho-vos dito estas coisas, para que em mim tenhais paz. No mundo tereis tribulações; mas tende bom ânimo, eu venci o mundo.'),
  ('22222222-2222-4222-8222-222222222222', 17, 'João 17', '1 Depois de assim falar, Jesus, levantando os olhos ao céu, disse: Pai, é chegada a hora; glorifica a teu Filho, para que também o Filho te glorifique;
2 assim como lhe deste autoridade sobre toda a carne, para que dê a vida eterna a todos aqueles que lhe tens dado.
3 E a vida eterna é esta: que te conheçam a ti, como o único Deus verdadeiro, e a Jesus Cristo, aquele que tu enviaste.
4 Eu te glorifiquei na terra, completando a obra que me deste para fazer.
5 Agora, pois, glorifica-me tu, ó Pai, junto de ti mesmo, com aquela glória que eu tinha contigo antes que o mundo existisse.
6 Manifestei o teu nome aos homens que do mundo me deste. Eram teus, e tu mos deste; e guardaram a tua palavra.
7 Agora sabem que tudo quanto me deste provém de ti;
8 porque eu lhes dei as palavras que tu me deste, e eles as receberam, e verdadeiramente conheceram que saí de ti, e creram que tu me enviaste.
9 Eu rogo por eles; não rogo pelo mundo, mas por aqueles que me tens dado, porque são teus;
10 todas as minhas coisas são tuas, e as tuas coisas são minhas; e neles sou glorificado.
11 Eu não estou mais no mundo; mas eles estão no mundo, e eu vou para ti. Pai santo, guarda-os no teu nome, o qual me deste, para que eles sejam um, assim como nós.
12 Enquanto eu estava com eles, eu os guardava no teu nome que me deste; e os conservei, e nenhum deles se perdeu, senão o filho da perdição, para que se cumprisse a Escritura.
13 Mas agora vou para ti; e isto falo no mundo, para que eles tenham a minha alegria completa em si mesmos.
14 Eu lhes dei a tua palavra; e o mundo os odiou, porque não são do mundo, assim como eu não sou do mundo.
15 Não rogo que os tires do mundo, mas que os guardes do Maligno.
16 Eles não são do mundo, assim como eu não sou do mundo.
17 Santifica-os na verdade, a tua palavra é a verdade.
18 Assim como tu me enviaste ao mundo, também eu os enviarei ao mundo.
19 E por eles eu me santifico, para que também eles sejam santificados na verdade.
20 E rogo não somente por estes, mas também por aqueles que pela sua palavra hão de crer em mim;
21 para que todos sejam um; assim como tu, ó Pai, és em mim, e eu em ti, que também eles sejam um em nós; para que o mundo creia que tu me enviaste.
22 E eu lhes dei a glória que a mim me deste, para que sejam um, como nós somos um;
23 eu neles, e tu em mim, para que eles sejam perfeitos em unidade, a fim de que o mundo conheça que tu me enviaste, e que os amaste a eles, assim como me amaste a mim.
24 Pai, desejo que onde eu estou, estejam comigo também aqueles que me tens dado, para verem a minha glória, a qual me deste; pois que me amaste antes da fundação do mundo.
25 Pai justo, o mundo não te conheceu, mas eu te conheço; conheceram que tu me enviaste;
26 e eu lhes fiz conhecer o teu nome, e lho farei conhecer ainda; para que haja neles aquele amor com que me amaste, e também eu neles esteja.'),
  ('22222222-2222-4222-8222-222222222222', 18, 'João 18', '1 Tendo Jesus dito isto, saiu com seus discípulos para o outro lado do ribeiro de Cedrom, onde havia um jardim, e com eles ali entrou.
2 Ora, Judas, que o traía, também conhecia aquele lugar, porque muitas vezes Jesus se reunira ali com os discípulos.
3 Tendo, pois, Judas tomado a coorte e uns guardas da parte dos principais sacerdotes e fariseus, chegou ali com lanternas archotes e armas.
4 Sabendo, pois, Jesus tudo o que lhe havia de suceder, adiantou-se e perguntou-lhes: A quem buscais?
5 Responderam-lhe: A Jesus, o nazareno. Disse-lhes Jesus: Sou eu. E Judas, que o traía, também estava com eles.
6 Quando Jesus lhes disse: Sou eu, recuaram, e cairam por terra.
7 Tornou-lhes então a perguntar: A quem buscais? e responderam: A Jesus, o nazareno.
8 Replicou-lhes Jesus: Já vos disse que sou eu; se, pois, é a mim que buscais, deixai ir estes;
9 para que se cumprisse a palavra que dissera: Dos que me tens dado, nenhum deles perdi.
10 Então Simão Pedro, que tinha uma espada, desembainhou-a e feriu o servo do sumo sacerdote, cortando-lhe a orelha direita. O nome do servo era Malco.
11 Disse, pois, Jesus a Pedro: Mete a tua espada na bainha; não hei de beber o cálice que o Pai me deu?
12 Então a coorte, e o comandante, e os guardas dos judeus prenderam a Jesus, e o maniataram.
13 E conduziram-no primeiramente a Anás; pois era sogro de Caifás, sumo sacerdote naquele ano.
14 Ora, Caifás era quem aconselhara aos judeus que convinha morrer um homem pelo povo.
15 Simão Pedro e outro discípulo seguiam a Jesus. Este discípulo era conhecido do sumo sacerdote, e entrou com Jesus no pátio do sumo sacerdote,
16 enquanto Pedro ficava da parte de fora, à porta. Saiu, então, o outro discípulo que era conhecido do sumo sacerdote, falou à porteira, e levou Pedro para dentro.
17 Então a porteira perguntou a Pedro: Não és tu também um dos discípulos deste homem? Respondeu ele: Não sou.
18 Ora, estavam ali os servos e os guardas, que tinham acendido um braseiro e se aquentavam, porque fazia frio; e também Pedro estava ali em pé no meio deles, aquentando-se.
19 Então o sumo sacerdote interrogou Jesus acerca dos seus discípulos e da sua doutrina.
20 Respondeu-lhe Jesus: Eu tenho falado abertamente ao mundo; eu sempre ensinei nas sinagogas e no templo, onde todos os judeus se congregam, e nada falei em oculto.
21 Por que me perguntas a mim? pergunta aos que me ouviram o que é que lhes falei; eis que eles sabem o que eu disse.
22 E, havendo ele dito isso, um dos guardas que ali estavam deu uma bofetada em Jesus, dizendo: É assim que respondes ao sumo sacerdote?
23 Respondeu-lhe Jesus: Se falei mal, dá testemunho do mal; mas, se bem, por que me feres?
24 Então Anás o enviou, maniatado, a Caifás, o sumo sacerdote.
25 E Simão Pedro ainda estava ali, aquentando-se. Perguntaram- lhe, pois: Não és também tu um dos seus discípulos? Ele negou, e disse: Não sou.
26 Um dos servos do sumo sacerdote, parente daquele a quem Pedro cortara a orelha, disse: Não te vi eu no jardim com ele?
27 Pedro negou outra vez, e imediatamente o galo cantou.
28 Depois conduziram Jesus da presença de Caifás para o pretório; era de manhã cedo; e eles não entraram no pretório, para não se contaminarem, mas poderem comer a páscoa.
29 Então Pilatos saiu a ter com eles, e perguntou: Que acusação trazeis contra este homem?
30 Responderam-lhe: Se ele não fosse malfeitor, não to entregaríamos.
31 Disse-lhes, então, Pilatos: Tomai-o vós, e julgai-o segundo a vossa lei. Disseram-lhe os judeus: A nós não nos é lícito tirar a vida a ninguém.
32 Isso foi para que se cumprisse a palavra que dissera Jesus, significando de que morte havia de morrer.
33 Pilatos, pois, tornou a entrar no pretório, chamou a Jesus e perguntou-lhe: És tu o rei dos judeus?
34 Respondeu Jesus: Dizes isso de ti mesmo, ou foram outros que to disseram de mim?
35 Replicou Pilatos: Porventura sou eu judeu? O teu povo e os principais sacerdotes entregaram-te a mim; que fizeste?
36 Respondeu Jesus: O meu reino não é deste mundo; se o meu reino fosse deste mundo, pelejariam os meus servos, para que eu não fosse entregue aos judeus; entretanto o meu reino não é daqui.
37 Perguntou-lhe, pois, Pilatos: Logo tu és rei? Respondeu Jesus: Tu dizes que eu sou rei. Eu para isso nasci, e para isso vim ao mundo, a fim de dar testemunho da verdade. Todo aquele que é da verdade ouve a minha voz.
38 Perguntou-lhe Pilatos: Que é a verdade? E dito isto, de novo saiu a ter com os judeus, e disse-lhes: Não acho nele crime algum.
39 Tendes, porém, por costume que eu vos solte alguém por ocasião da páscoa; quereis, pois, que vos solte o rei dos judeus?
40 Então todos tornaram a clamar dizendo: Este não, mas Barrabás. Ora, Barrabás era salteador.'),
  ('22222222-2222-4222-8222-222222222222', 19, 'João 19', '1 Nisso, pois, Pilatos tomou a Jesus, e mandou açoitá-lo.
2 E os soldados, tecendo uma coroa de espinhos, puseram-lha sobre a cabeça, e lhe vestiram um manto de púrpura;
3 e chegando-se a ele, diziam: Salve, rei dos judeus! e e davam-lhe bofetadas.
4 Então Pilatos saiu outra vez, e disse-lhes: Eis aqui vo-lo trago fora, para que saibais que não acho nele crime algum.
5 Saiu, pois, Jesus, trazendo a coroa de espinhos e o manto de púrpura. E disse-lhes Pilatos: Eis o homem!
6 Quando o viram os principais sacerdotes e os guardas, clamaram, dizendo: Crucifica-o! Crucifica-o! Disse-lhes Pilatos: Tomai-o vós, e crucificai-o; porque nenhum crime acho nele.
7 Responderam-lhe os judeus: Nós temos uma lei, e segundo esta lei ele deve morrer, porque se fez Filho de Deus.
8 Ora, Pilatos, quando ouviu esta palavra, mais atemorizado ficou;
9 e entrando outra vez no pretório, perguntou a Jesus: Donde és tu? Mas Jesus não lhe deu resposta.
10 Disse-lhe, então, Pilatos: Não me respondes? não sabes que tenho autoridade para te soltar, e autoridade para te crucificar?
11 Respondeu-lhe Jesus: Nenhuma autoridade terias sobre mim, se de cima não te fora dado; por isso aquele que me entregou a ti, maior pecado tem.
12 Daí em diante Pilatos procurava soltá-lo; mas os judeus clamaram: Se soltares a este, não és amigo de César; todo aquele que se faz rei é contra César.
13 Pilatos, pois, quando ouviu isto, trouxe Jesus para fora e sentou-se no tribunal, no lugar chamado Pavimento, e em hebraico Gabatá.
14 Ora, era a preparação da páscoa, e cerca da hora sexta. E disse aos judeus: Eis o vosso rei.
15 Mas eles clamaram: Tira-o! tira-o! crucifica-o! Disse-lhes Pilatos: Hei de crucificar o vosso rei? responderam, os principais sacerdotes: Não temos rei, senão César.
16 Então lho entregou para ser crucificado.
17 Tomaram, pois, a Jesus; e ele, carregando a sua própria cruz, saiu para o lugar chamado Caveira, que em hebraico se chama Gólgota,
18 onde o crucificaram, e com ele outros dois, um de cada lado, e Jesus no meio.
19 E Pilatos escreveu também um título, e o colocou sobre a cruz; e nele estava escrito: JESUS O NAZARENO, O REI DOS JUDEUS.
20 Muitos dos judeus, pois, leram este título; porque o lugar onde Jesus foi crucificado era próximo da cidade; e estava escrito em hebraico, latim e grego.
21 Diziam então a Pilatos os principais sacerdotes dos judeus: Não escrevas: O rei dos judeus; mas que ele disse: Sou rei dos judeus.
22 Respondeu Pilatos: O que escrevi, escrevi.
23 Tendo, pois, os soldados crucificado a Jesus, tomaram as suas vestes, e fizeram delas quatro partes, para cada soldado uma parte. Tomaram também a túnica; ora a túnica não tinha costura, sendo toda tecida de alto a baixo.
24 Pelo que disseram uns aos outros: Não a rasguemos, mas lancemos sortes sobre ela, para ver de quem será (para que se cumprisse a escritura que diz: Repartiram entre si as minhas vestes, e lançaram sortes). E, de fato, os soldados assim fizeram.
25 Estavam em pé, junto à cruz de Jesus, sua mãe, e a irmã de sua mãe, e Maria, mulher de Clôpas, e Maria Madalena.
26 Ora, Jesus, vendo ali sua mãe, e ao lado dela o discípulo a quem ele amava, disse a sua mãe: Mulher, eis aí o teu filho.
27 Então disse ao discípulo: Eis aí tua mãe. E desde aquela hora o discípulo a recebeu em sua casa.
28 Depois, sabendo Jesus que todas as coisas já estavam consumadas, para que se cumprisse a Escritura, disse: Tenho sede.
29 Estava ali um vaso cheio de vinagre. Puseram, pois, numa cana de hissopo uma esponja ensopada de vinagre, e lha chegaram à boca.
30 Então Jesus, depois de ter tomado o vinagre, disse: está consumado. E, inclinando a cabeça, entregou o espírito.
31 Ora, os judeus, como era a preparação, e para que no sábado não ficassem os corpos na cruz, pois era grande aquele dia de sábado, rogaram a Pilatos que se lhes quebrassem as pernas, e fossem tirados dali.
32 Foram então os soldados e, na verdade, quebraram as pernas ao primeiro e ao outro que com ele fora crucificado;
33 mas vindo a Jesus, e vendo que já estava morto, não lhe quebraram as pernas;
34 contudo um dos soldados lhe furou o lado com uma lança, e logo saiu sangue e água.
35 E é quem viu isso que dá testemunho, e o seu testemunho é verdadeiro; e sabe que diz a verdade, para que também vós creiais.
36 Porque isto aconteceu para que se cumprisse a escritura: Nenhum dos seus ossos será quebrado.
37 Também há outra escritura que diz: Olharão para aquele que traspassaram.
38 Depois disto, José de Arimatéia, que era discípulo de Jesus, embora oculto por medo dos judeus, rogou a Pilatos que lhe permitisse tirar o corpo de Jesus; e Pilatos lho permitiu. Então foi e o tirou.
39 E Nicodemos, aquele que anteriormente viera ter com Jesus de noite, foi também, levando cerca de cem libras duma mistura de mirra e aloés.
40 Tomaram, pois, o corpo de Jesus, e o envolveram em panos de linho com as especiarias, como os judeus costumavam fazer na preparação para a sepultura.
41 No lugar onde Jesus foi crucificado havia um jardim, e nesse jardim um sepulcro novo, em que ninguém ainda havia sido posto.
42 Ali, pois, por ser a vespera do sábado dos judeus, e por estar perto aquele sepulcro, puseram a Jesus.'),
  ('22222222-2222-4222-8222-222222222222', 20, 'João 20', '1 No primeiro dia da semana Maria Madalena foi ao sepulcro de madrugada, sendo ainda escuro, e viu que a pedra fora removida do sepulcro.
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
23 Âqueles a quem perdoardes os pecados, são-lhes perdoados; e àqueles a quem os retiverdes, são-lhes retidos.
24 Ora, Tomé, um dos doze, chamado Dídimo, não estava com eles quando veio Jesus.
25 Diziam-lhe, pois, ou outros discípulos: Vimos o Senhor. Ele, porém, lhes respondeu: Se eu não vir o sinal dos cravos nas mãos, e não meter a mão no seu lado, de maneira nenhuma crerei.
26 Oito dias depois estavam os discípulos outra vez ali reunidos, e Tomé com eles. Chegou Jesus, estando as portas fechadas, pôs-se no meio deles e disse: Paz seja convosco.
27 Depois disse a Tomé: Chega aqui o teu dedo, e vê as minhas mãos; chega a tua mão, e mete-a no meu lado; e não mais sejas incrédulo, mas crente.
28 Respondeu-lhe Tomé: Senhor meu, e Deus meu!
29 Disse-lhe Jesus: Porque me viste, creste? Bem-aventurados os que não viram e creram.
30 Jesus, na verdade, operou na presença de seus discípulos ainda muitos outros sinais que não estão escritos neste livro;
31 estes, porém, estão escritos para que creiais que Jesus é o Cristo, o Filho de Deus, e para que, crendo, tenhais vida em seu nome.'),
  ('22222222-2222-4222-8222-222222222222', 21, 'João 21', '1 Depois disto manifestou-se Jesus outra vez aos discípulos junto do mar de Tiberíades; e manifestou-se deste modo:
2 Estavam juntos Simão Pedro, Tomé, chamado Dídimo, Natanael, que era de Caná da Galiléia, os filhos de Zebedeu, e outros dois dos seus discípulos.
3 Disse-lhes Simão Pedro: Vou pescar. Responderam-lhe: Nós também vamos contigo. Saíram e entraram no barco; e naquela noite nada apanharam.
4 Mas ao romper da manhã, Jesus se apresentou na praia; todavia os discípulos não sabiam que era ele.
5 Disse-lhes, pois, Jesus: Filhos, não tendes nada que comer? Responderam-lhe: Não.
6 Disse-lhes ele: Lançai a rede à direita do barco, e achareis. Lançaram-na, pois, e já não a podiam puxar por causa da grande quantidade de peixes.
7 Então aquele discípulo a quem Jesus amava disse a Pedro: Senhor. Quando, pois, Simão Pedro ouviu que era o Senhor, cingiu-se com a túnica, porque estava despido, e lançou-se ao mar;
8 mas os outros discípulos vieram no barquinho, puxando a rede com os peixes, porque não estavam distantes da terra senão cerca de duzentos côvados.
9 Ora, ao saltarem em terra, viram ali brasas, e um peixe posto em cima delas, e pão.
10 Disse-lhes Jesus: Trazei alguns dos peixes que agora apanhastes.
11 Entrou Simão Pedro no barco e puxou a rede para terra, cheia de cento e cinquenta e três grandes peixes; e, apesar de serem tantos, não se rompeu a rede.
12 Disse-lhes Jesus: Vinde, comei. Nenhum dos discípulos ousava perguntar-lhe: Quem és tu? sabendo que era o Senhor.
13 Chegou Jesus, tomou o pão e deu-lho, e semelhantemente o peixe.
14 Foi esta a terceira vez que Jesus se manifestou aos seus discípulos, depois de ter ressurgido dentre os mortos.
15 Depois de terem comido, perguntou Jesus a Simão Pedro: Simão Pedro: Simão, filho de João, amas-me mais do que estes? Respondeu- lhe: Sim, Senhor; tu sabes que te amo. Disse-lhe: Apascenta os meus cordeirinhos.
16 Tornou a perguntar-lhe: Simão, filho de João, amas-me? Respondeu-lhe: Sim, Senhor; tu sabes que te amo. Disse-lhe: Pastoreia as minhas ovelhas.
17 Perguntou-lhe terceira vez: Simão, filho de João, amas-me? Entristeceu-se Pedro por lhe ter perguntado pela terceira vez: Amas- me? E respondeu-lhe: Senhor, tu sabes todas as coisas; tu sabes que te amo. Disse-lhe Jesus: Apascenta as minhas ovelhas.
18 Em verdade, em verdade te digo que, quando eras mais moço, te cingias a ti mesmo, e andavas por onde querias; mas, quando fores velho, estenderás as mãos e outro te cingirá, e te levará para onde tu não queres.
19 Ora, isto ele disse, significando com que morte havia Pedro de glorificar a Deus. E, havendo dito isto, ordenou-lhe: Segue-me.
20 E Pedro, virando-se, viu que o seguia aquele discípulo a quem Jesus amava, o mesmo que na ceia se recostara sobre o peito de Jesus e perguntara: Senhor, quem é o que te trai?
21 Ora, vendo Pedro a este, perguntou a Jesus: Senhor, e deste que será?
22 Respondeu-lhe Jesus: Se eu quiser que ele fique até que eu venha, que tens tu com isso? Segue-me tu.
23 Divulgou-se, pois, entre os irmãos este dito, que aquele discípulo não havia de morrer. Jesus, porém, não disse que não morreria, mas: se eu quiser que ele fique até que eu venha, que tens tu com isso?
24 Este é o discípulo que dá testemunho destas coisas e as escreveu; e sabemos que o seu testemunho é verdadeiro.
25 E ainda muitas outras coisas há que Jesus fez; as quais, se fossem escritas uma por uma, creio que nem ainda no mundo inteiro caberiam os livros que se escrevessem.')
on conflict (plan_id, dia) do update set referencia = excluded.referencia, texto = excluded.texto;

