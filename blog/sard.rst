Il teorema di Sard
==================

.. post:: Mar 2, 2020
   :tags: math, italian
   :category:

Questo post nasce pochi giorni dopo un seminario che ho dovuto tenere in Universitá, infatti, dopo
aver approfondito l'argomento che sto per esporre, mi spiaceva lasciare tali concetti "al vento" e
mi sembrava sensato trascriverli nero su bianco da qualche parte. L'idea iniziale era di scrivere un
bel documento in :math:`\LaTeX` di cui farne un pdf da perdere in qualche remota cartella del pc, ma alla
fine mi sono detto: perché non qui sul blog?

L'obiettivo di queste note é di fornire una semplice e concisa esposizione del teorema di Sard,
noto risultato di geometria differenziale. La trattazione é carica di osservazioni e frequenti
definizioni, in modo da essere digeribile anche ai non addetti ai lavori.

Iniziamo con le seguenti definizioni preliminari.


.. proof:def:: Rettangolo solido

   Siano :math:`(a_1, \dots, a_n), (b_1, \dots, b_n) \in \R^n` tali che :math:`a_i < b_i`,
   chiamiamo *rettangolo solido n-dimensionale* l'insieme

   .. math::
      S(a, b)=\{(x_1, \dots, x_n) \in \mathbb{R}^n : a_i \lt x_i \lt b_i\}


.. proof:def:: Volume n-dimensionale di un rettangolo solido

   Chiamiamo *volume n-dimensionale* di un rettangolo solido n-dimensionale :math:`S(a, b)` la
   quantitá reale positiva

   .. math::
      Vol(S(a, b)) = \prod_{i=1}^n (b_i - a_i)

.. proof:def:: Insiemi di :math:`\mathbb{R}^n` a misura nulla

   Diciamo che :math:`A \sub \R^n` ha *misura nulla* se
   :math:`\forall \epsilon \gt 0` esiste un ricoprimento
   :math:`\{S_i\}_{i \in \N}` di :math:`A` (ovvero :math:`\bigcup_{i \in
   \N} S_i \supset A`) formato da rettangoli solidi
   :math:`S_i` tale che

   .. math::
      \sum_{i \in \mathbb{N}} Vol(S_i) \lt \epsilon

Osserviamo innanzitutto che, nella definizione di insieme a misura nulla, considerare cubi
n-dimensionali (cioé rettangoli dove :math:`b_i - a_i = b_j = a_j \forall i, j`) invece che
rettangoli é del tutto equivalente. D'altronde é del tutto equivalente anche considerare le palle
euclidee o in generale le altre bolle indotte da norme equivalenti (nel senso che generano la
stessa topologia).

Inoltre, si segnala come tale nozione sia equivalente all'avere
misura di Lebesgue nulla, ovvero :math:`A` ha misura nulla se e solo se :math:`m_n(A) = 0` dove
:math:`m_n` é la misura di Lebesgue n-dimensionale. La dimostrazione di tale equivalenza, nonostante
non di difficile raggiungimento, non é necessaria per i nostri obiettivi e pertanto verrá omessa.

Iniziamo con le due seguenti banali osservazioni:

.. proof:oss::

   Se :math:`m \lt n` allora :math:`\R^m` ha misura nulla in :math:`\R^n`
.. proof:dim::
   
   Basta ricoprire :math:`\R^m` con una famiglia numerabile di cubi, tali cubi giacciono su un
   iano di :math:`\R^n` e quindi ognuno di essi puó essere schiacciato in una direzione
   ortogonale a questo pano. In questo modo l'unione dei rettangoli continua a contenere tutto
   :math:`\R^m` e il volume di ogni rettangolo é piccolo a piacere, questo implica che anche la
   somma di tutti i volumi é piccola a piacere.

   
.. proof:oss::

   :math:`\bigcup_{i \in \N} A_i` ha misura nulla se ogni :math:`A_i` ha misura nulla.

.. proof:dim::
   
   Unioni di famiglie numerabili sono ancora numerabili per l'assioma della scelta.

Vediamo ora una prorietá fondamentale che ci permettá in seguito di estendere la definizione di
insiemi a misura nulla.

.. proof:prop::

   Sia :math:`F: U \to \R^n` una mappa liscia, con :math:`U \sub \R^n` aperto. Se :math:`A \sub
   U` ha misura nulla allora anche l'immagine :math:`F(A)` ha misura nulla.

.. proof:dim::

   Iniziamo osservando che :math:`U` é ricopribile da una famiglia numerabile di palle chiuse per
   cui la restrizione di :math:`F` ad ognuna di queste palle é ancora liscia, ricordiamo che una
   mappa é liscia su un insieme generico (non aperto) se essa é estendibile ad una mappa liscia
   definita su un aperto contenente tale insieme.
   Sia :math:`\bar{B}` una di queste palle, siccome :math:`\bar{B}` é compatto e :math:`F \in
   \mathscr{C}^1(\bar{B})` allora :math:`\exists c \gt 0` tale che :math:`\forall x, y \in \bar{B}`

   .. math::

      ||F(x) - F(y)|| \le c ||x-y||

   Fissiamo :math:`\delta \gt 0`, visto che :math:`A \cap \bar{B}` ha misura nulla possiamo
   considerare un suo ricoprimento numerabile :math:`\{ B_k \}_{k \in \N}` di palle tale che

   .. math::

      \sum_{k \in \N} Vol({B_k}) \lt \delta

   Per la diseguaglianza di prima sappiamo che :math:`F(B_k \cap \bar{B})` é contenuto in una palla
   di raggio al piú :math:`c` volte il raggio di :math:`B_k`. Dunque :math:`F(A \cap B_k)` é
   ricoperto da una famiglia numerabile :math:`\{ \tilde{B_k} \}_{k \in \N}` di palle di volume
   complessivo inferiore a

   .. math::

      \sum_{k \in \N} Vol({\tilde{B_k}}) \lt c^n \delta

   Per arbitrarietá di :math:`\delta` segue che :math:`F(A \cap \bar{B})` ha misura nulla, e
   dunque per quanto osservato all'inizio che anche :math:`F(A)` ha misura nulla, cioé la tesi.


Ció implica che l'avere dimensione nulla é invariante per diffeomorfismi, siamo quindi ora pronti ad
estendere la definizione di insiemi a misura nulla alle varietá differenziabili, prima di fare ció
enunciamo e dimostriamo una versione piú debole del teorema di Sard, Per capire in che modo questo
teorema é implicato dalla versione generale occorrerá attendere ancora un poco.

.. proof:teo:: Mini-Sard

   Sia :math:`F: U \sub \R^m \to \R^n` una mappa liscia, con :math:`U` aperto e :math:`m < n`.
   Allora l'immagine :math:`F(\R^m)` ha misura nulla in :math:`\R^n`.

.. proof:dim::

   Sia :math:`\pi: \R^n \to \R^m` la proiezione sulle prime :math:`m` componenti, tale mappa é
   liscia. Consideriamo ora l'aperto :math:`\tilde{U} = \pi^{-1}(U) \sub \R^n` e :math:`\tilde{F} =
   F \circ \pi: \R^n \to \R^n`, che é ancora liscia. A questo punto é sufficiente osservare che
   :math:`F(U)` non é nient'altro che l'immagine di :math:`\tilde{U} \cap \R^m` attraverso
   :math:`\tilde{F}`, che, per la proposizione precedente, ha misura nulla siccome é l'immagine di
   un insieme a misura nulla (é tutto contenuto in un iperpiano!) attraverso una funzione liscia.

Come preannunciato, estendiamo la definizione di insieme a misura nulla sulle varietá differenziali.

.. proof:def:: Insiemi a misura nulla su varietá differenziabili

   Sia :math:`M` una varietá differenziale, diciamo che :math:`A \sub M` ha misura nulla se
   :math:`\varphi(A_i \cap U_i)` ha misura nulla in :math:`\R^{dim(M)}` per ogni carta :math:`(U,
   \varphi)` dell'atlante di :math:`M`.

Si osserva che, a causa della :math:`\mathscr{C}^\infty`-compatibilitá delle carte dell'atlante, per
affermare che un sottoinsieme della varietá ha misura nulla é sufficiente trovare una collezione
numerabile di carte che ricoprano l'insieme candidato e che soddisfino
l'enunciato della definizione.
In particolare se l'insieme é tutto contenuto in una carta, per mostrare che ha misura nulla basta
verificare che l'immagine attraverso la carta ha misura nulla.

Passiamo ora a definire un altro concetto che sará fondamentale per enunciare il Teorema di Sard.

.. proof:def:: Punti critici e valori critici
               
   Sia :math:`F: M \to N` una mappa liscia tra varietá differenziali, diciamo che :math:`p \in M` é
   un *punto critico* se la mappa differenziale indotta :math:`dF_p: T_P \to T_{F(p)}N` non é
   suriettiva.
   In tal caso :math:`F(p)` si dice *valore critico*.

   Denotiamo con :math:`Crit(F)` l'insieme dei punti critici di :math:`F`.

.. proof:def:: Punti regolari e valori regolari
               
   Sia :math:`F: M \to N` una mappa liscia tra varietá differenziali, diciamo che :math:`p \in M` é
   un *punto regolare* se non é critico, ovvero se :math:`dF_p: T_p \to T_{F(p)}N` é suriettiva
   (ovvero locamente `F` é una sommersione).
   Se :math:`p'` é un punto regolare per ogni punto sulla fibra :math:`F^{-1}(F(p))` allora
   :math:`F(p)` si dice *valore regolare*.

Osserviamo come affinché un valore sia critico é sufficiente che esso sia l'immagine di un solo
punto critico, mentre affinché sia regolare occorre che tutti i punti della sua controimmagine siano
regolari.

La seguente osservazione ci sará utile durante la dimostrazione del teorema di Sard.

.. proof:oss::

   :math:`Crit(F)` é un chiuso di :math:`M`

.. proof:dim::

   :math:`Crit(F)=h^{-1}(0)` dove :math:`h: M \to \R` é la mappa liscia tale che

         .. math:: h(p)=det(J(F)\bigr|_p \cdot (J(F)\bigr|_p)^t)

   cioé la mappa che manda i punti della varietá nel determinante del prodotto della Jacobiana con
   la sua trasposta.

Prima di presentare il teorema di Sard occorre ancora dare una definizione ed enunciare il teorema
di Fubini, di cui peró ometteremo la dimostrazione [#fubini]_. Tale risultato sará fondamentale nella
dimostrazione del teorema di Sard.

.. proof:def:: Sezione verticale

   Sia :math:`\R^n = \R^k \times \R^l` e :math:`a \in \R^k`, chiamiamo *sezione verticale* l'insieme
   :math:`V_a = \{ a \} \times \R^l`.

Sempre adottando le notazioni della definizione, diremo che un insieme :math:`A \sub \R^n` ha
sezione verticale nulla se la proiezione (sulle ultime :math:`l` componenti) di :math:`V_a \cap A`
in :math:`\R^l` ha misura nulla.

.. proof:teo:: Teorema di Fubini

   Sia :math:`A \sub \R^n = \R^k \times \R^l`, se tutte le sezioni verticali :math:`V_a` hanno
   misura nulla (quindi :math:`\forall a \in \R^k`) allora :math:`A` ha misura nulla in :math:`\R^n`.

Enunciamo finalmente il teorema di Sard:

.. proof:teo:: Teorema di Sard

   Sia :math:`F: M \to N` una mappa liscia tra varietá differenziabili, allora l'insieme dei valori
   critici :math:`F(Crit(F))` ha misura nulla in :math:`N`.

Siccome per le varietá differenziabili vale il secondo assioma di numerabilitá ogni insieme é
ricopribile con una collezione numerabile di carte, pertanto nell'enunciato del teorema é
sufficiente chiedere che il dominio di :math:`F` sia un singolo aperto :math:`U \sub \R^m`, dove
:math:`m = dim(M)`.
Inoltre, per lo stesso motivo, anche l'immagine :math:`F(U)` é ricopribile con una collezione
numerabile di carte, pertanto anche qui si puó supporre senza perdita di generalitá che la carta sia
una sola, ovvero che l'immagine :math:`F(U)` stia in :math:`\R^n`, dove :math:`n = dim(N)`.

Quanto appena scritto é sufficiente a giustificare la seguente formulazione equivalente del teorema
di Sard.

.. proof:teo:: Teorema di Sard (formulazione equivalente)

   Sia :math:`F: U \sub \R^m \to \R^n` una mappa liscia, con :math:`U` aperto. Allora l'insieme dei
   valori critici :math:`F(Crit(F))` ha misura nulla in :math:`\R^n`.

.. proof:dim::

   Se :math:`m \lt n` l'enunciato diventa una semplice conseguenza del Teorema Mini-Sard, supponiamo
   dunque :math:`m \geq n` e procediamo per induzione su :math:`m`.

   Se :math:`m = 0` allora l'immagine dei punti critici deve essere contenuta in un punto, e
   pertanto non puó che avere misura nulla. Supponiamo quindi ora il teorema valido per :math:`m-1`
   e dimostriamolo per :math:`m`.

   Chiamiamo ora per brevitá :math:`C = Crit(F)` e :math:`C_i = \{ p \in U : \frac{\partial^k
   F}{\partial \dots} \bigr|_p = 0, \forall k \leq i \}`, ovvero l'insieme dei punti di :math:`U` in
   cui tutte le derivate di ordine inferiore a :math:`i` si annullano.

   Osserviamo subito come :math:`C` e i :math:`C_i` sono chiusi (dimostrazione simile
   all'osservazione iniziale sulla chiusura di :math:`C`), inoltre ha luogo la seguente catena di
   inclusioni:

   .. math::

      C \supset C_1 \supset C_2 \supset \dots

   Assumiamo ora i tre seguenti lemmi, rimandandone temporaneamente la dimostrazione, che ricordiamo
   avverrá per induzione su :math:`m`.

   .. proof:lemma:: a

      :math:`F(C \setminus C_1)` ha misura nulla in :math:`\R^n`

   .. proof:lemma:: b

      :math:`F(C_i \setminus C_{i+1})` ha misura nulla in :math:`\R^n`

   .. proof:lemma:: c

      :math:`F(C_k)` ha misura nulla in :math:`\R^n` se :math:`k \gt \frac{m}{n} - 1`


   Per concludere il teorema ora é sufficiente osservare che

   .. math::

      F(C) = F(C \setminus C_1) \cup \bigcup_{i=1}^{\floor{\frac{m}{n}-1}} F(C_i) \setminus
      F(C_{i+1}) \cup F(C_{\ceil{\frac{m}{n}-1}})

      
   Ovvero che l'insieme dei valori critici é unione finita di insiemi che sono a misura nulla per i
   tre lemmi, e pertanto anch'esso ha misura nulla.


Seguono le dimostrazioni dei tre lemmi, ricordiamo che ci troviamo sotto ipotesi induttive, pertanto
potremo assumere il teorema di Sard valido per :math:`m-1`.


.. proof:lemma:: a

   :math:`F(C \setminus C_1)` ha misura nulla in :math:`\R^n`

.. proof:dim::

   Osserviamo come sia sufficiente mostrare che per ogni punto in :math:`C \setminus C_1` esiste un
   intorno :math:`V` per cui :math:`f(C \cap V)` ha misura nulla. Infatti siccome :math:`U` é un
   aperto di :math:`\R^m`, vale il secondo assioma di numerabilitá, e quindi é possibile ricoprire
   :math:`C \setminus C_1` di intorni la cui immagine ha misura nulla.

   Consideriamo quindi :math:`\tilde{x} \in C \setminus C_1`, visto che :math:`\tilde{x} \not\in
   C_1` possiamo assumere senza perdita di generalitá che :math:`\frac{\partial f}{\partial x_1}`
   sia non nulla in :math:`\tilde{x}`, a questo punto definiamo una mappa :math:`h: U \to \R^m` tale
   che

   .. math::

      h(x_1, \dots, x_m) = (f_1(x), x_2, \dots, x_m)

   Questa mappa ha rango massimo in :math:`\tilde{x}` e quindi é un diffeomorfismo locale per un
   qualche intorno aperto di :math:`\tilde{x}`, continuiamo a chiamare :math:`h: V \sub U \to V'
   \sub \R^m` il diffeomorfismo ottenuto dalla restrizione.

   Definiamo ora la mappa composta :math:`g = f \circ h^{-1} : V' \to \R^n` e chiamiamo :math:`C' =
   Crit(g)`, osserviamo subito che :math:`C' = h(C \cap V)`; ma allora :math:`g(C') = g(h(C \cap V))
   = f(h(h^{-1}(C \cap V))) = f(C \cap V)` e quindi per mostrare la tesi basta mostrare che
   :math:`g(C')` ha misura nulla.

   Osservando che :math:`g_1 = f_1 \circ h_1^{-1} = id` si vede che :math:`g` é la funzione identitá
   sulla prima coordinata, questo permette di definire per ogni :math:`t` la mappa :math:`g^t: ({t}
   \times \R^{m-1} \to {t} \times \R^{n-1})` dove

   .. math::

      g^t(x_2, x_3, \dots, x_m) = (g_2(t, x_2, \dots, x_m), \dots, g_m(t, x_2, \dots, x_m))

   I punti critici di questa mappa coincidono coi punti critici della sezione verticale di
   :math:`C'`, ovvero :math:`C' \cap V_t = \{ t \} \times Crit(g^t)`. Questo implica che
   :math:`g(C') \cap V_t = \{ t \} \times g^t(C)`, ovvero che le varie sezioni verticali dei valori
   critici di :math:`g` coincidono con i valori critici di :math:`g^t`, che peró hanno misura nulla
   per ipotesi induttiva!

   Questo basterebbe a concludere grazie al teorema di Fubini, se solo non fosse che mentre
   :math:`C'` é un chiuso non é detto che anche :math:`g(C')` sia un chiuso (serve che lo sia
   affinché sia possibile applicare il teorema di Fubini). Questo problema é facilmente superabile
   osservando che :math:`C'` é unione numerabile di compatti (é un chiuso di :math:`U`) e
   quindi anche l'immagine :math:`g(C')` é unione numerabile di compatti, pertanto non assumere
   :math:`C'` chiuso non é lmitante.


.. proof:lemma:: b

    :math:`F(C_i \setminus C_{i+1})` ha misura nulla in :math:`\R^n`

.. proof:dim::

   La dimostrazione é simile a quella del lemma precedente, infatti  dimostreremo che
   :math:`\forall x \in C_i \setminus C_{i+1}` troviamo un intorno :math:`V` di :math:`x` tale che
   :math:`f(C_i \cap V)` ha misura nulla, per le stesse motivizaioni del lemma precedente questo é
   sufficiente a concludere la dimostrazione.
        
   Sia :math:`\tilde{x} \in C_i \setminus C_{i+1}`, siccome :math:`\tilde{x} \not \in C_{i+1}`
   significa che possiamo trovare una derivata :math:`k+1`-esima di :math:`f` non nulla in
   :math:`\tilde{x}`.
   Senza perdita di generalitá assumiamo quindi che esista una derivata :math:`k`-esima :math:`\rho:
   U \to \R^n` tale che :math:`\frac{\partial \rho_1}{\partial x_1}` sia non nulla in
   :math:`\tilde{x}`.

   Definiamo a questo punto una mappa :math:`h: U \to \R^m` tale che

   .. math::

      h(x_1, \dots, x_m) = (\rho_1(x_1, \dots, x_m), \dots, x_m)

   Come nella dimostrazione del lemma precedente, siccome tale mappa ha rango massimo in
   :math:`\tilde{x}`, esistono :math:`x \in V \sub U \sub \R^m` e :math:`V' \sub \R^n` aperti
   diffeomorfi attraverso la restrizione di :math:`h`, che continueremo a chiamare :math:`h`.
   Per costruzione :math:`h(C_k \cap V)` é contenuto nell'iperpiano :math:`\{ 0 \} \times \R^{m-1}`,
   e quindi :math:`g = f \circ h^{-1}` ha i punti critici di tipo :math:`C_k` in tale iperpiano.

   Definiamo :math:`\tilde{g}` come la restrizione di :math:`g` data da :math:`\tilde{g}: (\{ 0 \}
   \times \R^{m-1}) \cap V' \to \R^n`, per induzione vediamo che i suoi valori critici hanno misura
   nulla, ma i suoi punti critici coincidono coi punti critici di tipo :math:`C_k` di :math:`g`, e
   quindi l'immagini di tali punti, ovvero :math:`f(C_k \cap V)`, ha misura nulla.

   
.. proof:lemma:: c

    :math:`F(C_k)` ha misura nulla in :math:`\R^n` se :math:`k \gt \frac{m}{n} - 1`

.. proof:dim::

   Siccome :math:`C_k` é ricopribile da una collezione numerabile di cubi contenuti in :math:`U` di
   lato :math:`\delta`, preso uno di questi cubi, diciamo :math:`S \sub U`, é sufficiente mostrare
   che :math:`f(C_k \cap S)` ha misura nulla per :math:`k` sufficientemente grande.

   Sia :math:`x \in C_k \cap S` e :math:`x+h \in S`, scrivendo lo sviluppo in serie di Taylor di
   :math:`f` di ordine :math:`k` e ricordandoci della compattezza di :math:`S` e della definizione
   di :math:`C_k` otteniamo:

   .. math::

      f(x, h) = f(x) + R(x, h)


   dove vale la seguente maggiorazione per il resto :math:`R`

   .. math::

      R(x, h) \lt a ||h||^{k+1}


   :math:`a \in \R` é costante e dipende solo da :math:`f` e :math:`S`.
   A questo punto possiamo suddividere il cubo :math:`S` in :math:`r^m` cubi di lato
   :math:`\frac{\delta}{r}`, sia :math:`\tilde{S}` uno di questi cubi e sia :math:`x \in \tilde{S}
   \cap C_k`, osserviamo come ogni punto di :math:`\tilde{S}` sia della forma :math:`x+h` dove

   .. math::

      ||h|| \lt \sqrt{m} \cdot \frac{\delta}{r} = diam(\tilde{S})


   Dalle diseguaglianze di prima otteniamo

   .. math::

      ||f(x,h) - f(x)|| = ||R(x,h)|| \lt a ||h||^{k+1} \lt a ( \sqrt{m} \frac{\delta}{r} )^{k+1}

 
   Che significa che un :math:`diam(f(\tilde{S})) \lt a ( \sqrt{m} \frac{\delta}{r} )^{k+1}` e che
   quindi :math:`f(\tilde{S})` é contenuto in un cubo di lato :math:`\frac{b}{r^{k+1}}` dove :math:`b
   = 2a (\sqrt{m} \delta)^{k+1}`.
   
   Questo ragionamento non dipende da una particolare scelta del cubo :math:`\tilde{S}` e puó essere
   effettuato per ogni cubo della suddivisione, dunque :math:`f(C_k \cap S)` é ricopribile da una
   famiglia di :math:`r^m` cubi, ognuno di lato :math:`\frac{b}{r^{k+1}}`.
   Ma allora la somma dei volumi é minore di

   .. math::

      r^m (\frac{b}{r^{k+1}})^n = b^n r^{m - (k+1)n} \xrightarrow[r \rightarrow \infty]{} 0

   Che é equivalente ad affermare che :math:`\forall \epsilon \gt 0` troviamo un :math:`r_0`
   sufficientemente grande per cui :math:`\forall r \gt r_0` la somma dei volumi dei cubi che
   ricoprono :math:`f(C_k \cap S)` é inferiore di :math:`\epsilon`, ovvero che :math:`f(C_k \cap S)`
   ha misura nulla.

  
La dimostrazione di questo lemma termina la dimostrazione del teorema di Sard, seguono gli enunciati
di alcuni notevoli risultati interpretabili come corollari.


.. proof:oss::

   Il gruppo di omotopia :math:`\pi_q(S^n)` é banale se :math:`q \lt n`

.. proof:dim:: idea [#gruppo-omotopia]_

   Basta il teorema Mini-Sard, che usato in un certo modo permette di non considerare un punto da
   :math:`S^n` e retrarre (in modo :math:`\mathscr{C}^{\infty}`) tramite una proiezione
   stereografica ad un aperto di :math:`\R^n`.
   
.. proof:teo:: Teorema del punto fisso di Brouwer [#hirsch]_

   Sia :math:`f: D^n \to D^n` continua, dove :math:`D^n` é il disco :math:`n`-dimensionale. Allora
   :math:`f` ammette un punto fisso cioé :math:`\exists x_0 \in D^n` tale che :math:`f(x_0)=x_0`.

.. proof:teo:: Teorema di Whitney [#whitney]_

   Sia :math:`M` una varietá differenziabile :math:`n`-dimensionale, allora essa puó essere
   realizzata come sottovarietá chiusa di :math:`\R^{2n+1}` o come sottovarietá immersa di
   :math:`\R^{2n}`.
         
   Equivalentemente esiste un embedding proprio di :math:`M` in :math:`\R^{2n+1}` e una immersione
   di :math:`\R^{2n}`.

Per esporre il prossimo risultato (fondamentale nella teoria di Morse) occorre dare alcune
definizioni.

.. proof:def:: punto critico non degenere

   Sia :math:`f: \R^k \to \R` una funzione liscia, diciamo che :math:`p \in \R^k` é un *punto
   critico non degenere* se é un punto critico (cioé la mappa differenziale indotta ivi si annulla)
   e se l'Hessiana nel punto é non singolare, ovvero

   .. math::

      det(H(f)\bigr|_p) = det(\Big(\frac{\partial^2 f}{\partial x_i \partial x_j}\Big)_{i, j}) \not = 0

.. proof:def:: funzione di Morse

   Sia :math:`f: \R^k \to \R` una funzione liscia, diciamo é una *funzione di Morse* se tutti i suoi
   punti non degeneri.

Si puó mostrare [#lemma-morse]_ (lemma di Morse) che le funzioni di Morse hanno la proprietá di
essere localmente descrivibili come polinomi di secondo grado, ovvero che esiste sempre un cambio di
coordinate per cui

.. math::

   f(x_1, \dots, x_k) = f(p) + \bold{x} \cdot H(f)\bigr|_p \cdot \bold{x}^t

Diagonalizzando la matrice si riesce addirittura a riscrivere la precedente relazione come

.. math::

   f(x_1, \dots, x_k) = f(p) + \sum_{i = 1}^k \epsilon_i x_i^2

dove :math:`\epsilon_i = \pm 1`

Il teorema di Sard ci permette di affermare [#teo-morse]_ che queste (belle) funzioni di Morse sono
quasi tutte le funzioni liscie, in termini piú precisi

.. proof:teo::

   Sia :math:`f: M \to \R` una funzione liscia definita su una varietá differenziabile
   :math:`k`-dimensionale :math:`M`, tramite le sue carte possiamo definire sempre :math:`M` la
   funzione liscia
   
   .. math::

      f_a(x_1, \dots, x_k) = f(x_1, \dots, x_k) + \sum_{i=1}^k a_i x_i

   Allora il sottoinsieme di :math:`\R^k` degli :math:`a \in \R^k` tali che :math:`f_a` non é
   funzione di Morse ha misura nulla.


.. [#fubini] V. Guillemin, A. Pollack - Differential Topology (p. 204)
.. [#gruppo-omotopia] L. W. Tu, R. Bott - Differential Forms in Algebraic Topology (pp. 214, 215)
.. [#lemma-morse] V. Guillemin, A. Pollack - Differential Topology (p. 42)
.. [#teo-morse] V. Guillemin, A. Pollack - Differential Topology (p. 43)
.. [#hirsch] M. W. Hirsch - A  proof  of  the  non-retractability  of  a  cell  onto  its  boundary
.. [#whitney] M. Abate, F. Tovena - Geometria Differenziale (pp. 109-115)
