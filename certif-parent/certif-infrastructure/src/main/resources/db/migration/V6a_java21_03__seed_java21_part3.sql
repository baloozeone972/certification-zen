-- V6a_java21_03__seed_java21_part3.sql
-- java21: questions 301–450
-- Idempotent via legacy_id check

-- JAVA21: 150 questions
DO $$
DECLARE
    v_cert_id TEXT := 'java21';
    v_theme_id UUID; v_q_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Cert % absent', v_cert_id; RETURN; END IF;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'collections_et_g_n_riques','Collections et Génériques',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'exceptions_et_gestion_d_erreurs','Exceptions et Gestion d''erreurs',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-023',v_cert_id,v_theme_id,'Différence entre poll() et remove() d''une Queue ?','medium','SINGLE_CHOICE','poll() retourne null quand la file est vide. remove() lève NoSuchElementException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','poll() retourne null si vide, remove() lève NoSuchElementException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','remove() retourne null si vide, poll() lève exception',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Pas de différence',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','poll() est plus rapide',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-024',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Deque<String> deque = new ArrayDeque<>();
deque.push("A");
deque.push("B");
System.out.println(deque.pop());
```','medium','SINGLE_CHOICE','push() ajoute en tête, pop() retire de la tête (LIFO). B a été ajouté après A → B sort en premier.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','A',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','B',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','null',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NoSuchElementException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-025',v_cert_id,v_theme_id,'Quelle est la différence entre ArrayDeque et LinkedList comme Deque ?','easy','SINGLE_CHOICE','ArrayDeque est plus performant, n''accepte pas null, mais LinkedList implémente aussi List et accepte null.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayDeque est plus rapide pour la plupart des opérations',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','LinkedList implémente aussi List',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ArrayDeque n''accepte pas les éléments null',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-026',v_cert_id,v_theme_id,'Que sont les ''weak references'' dans WeakHashMap ?','hard','SINGLE_CHOICE','WeakHashMap utilise des WeakReference pour les clés. Si une clé n''a plus de référence forte, elle peut être GC et l''entrée est supprimée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les clés peuvent être garbage collectées',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les valeurs peuvent être garbage collectées',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les entrées sont automatiquement supprimées',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-027',v_cert_id,v_theme_id,'Que produit ce code ?
```java
TreeSet<Integer> set = new TreeSet<>();
set.add(5);
set.add(2);
set.add(8);
System.out.println(set.first());
```','medium','SINGLE_CHOICE','TreeSet trie les éléments. first() retourne le plus petit élément (2).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','2',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','5',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','8',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-028',v_cert_id,v_theme_id,'Que produit ''TreeSet<Integer> set = new TreeSet<>(); set.add(null);'' ?','medium','SINGLE_CHOICE','TreeSet utilise compareTo() pour trier. null ne peut pas être comparé → NullPointerException à l''exécution.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ajoute null',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','NullPointerException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ClassCastException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Compilation OK, runtime NPE',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-029',v_cert_id,v_theme_id,'Que signifie le type générique ''T'' dans une classe ?','easy','SINGLE_CHOICE','T est une convention pour Type Parameter. On peut utiliser n''importe quel identifiant, mais T, E (Element), K (Key), V (Value) sont des conventions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Type paramètre (Type Parameter)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Test',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Template',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Temporary',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-030',v_cert_id,v_theme_id,'Quel est l''intérêt des génériques en Java ?','easy','SINGLE_CHOICE','Les génériques apportent la sécurité de type (type-safety) et éliminent les casts. L''inférence de type est aussi améliorée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La sécurité de type à la compilation',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Éviter les casts explicites',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réutiliser du code avec différents types',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-031',v_cert_id,v_theme_id,'Que signifie ''List<? extends Number>'' ?','medium','SINGLE_CHOICE','? extends Number est un upper bounded wildcard. On peut lire des Number, mais on ne peut pas ajouter (sauf null).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Liste de Number ou de ses sous-types (Integer, Double...)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Liste de Number uniquement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Liste de tout type',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Liste de types non Number',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-032',v_cert_id,v_theme_id,'Que signifie ''List<? super Integer>'' ?','medium','SINGLE_CHOICE','? super Integer est un lower bounded wildcard. On peut ajouter des Integer, mais on lit des Object.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Liste de Integer ou de ses super-types (Number, Object)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Liste de Integer uniquement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Liste de sous-types de Integer',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Liste de tout type',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-033',v_cert_id,v_theme_id,'Quel est le principe PECS (Producer Extends, Consumer Super) ?','hard','SINGLE_CHOICE','PECS : Producer Extends (si on lit, on utilise ? extends), Consumer Super (si on écrit, on utilise ? super).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Pour lire (produire) : ? extends, pour écrire (consommer) : ? super',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Pour lire : ? super, pour écrire : ? extends',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','PEC S n''a pas de sens',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les streams',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-034',v_cert_id,v_theme_id,'Que se passe-t-il à l''exécution avec les génériques ?','medium','SINGLE_CHOICE','Java utilise l''effacement des types (type erasure). Les informations génériques sont disponibles à la compilation mais effacées à l''exécution.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les types génériques sont préservés',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''effacement des types (type erasure) supprime les informations génériques',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les génériques sont réifiés',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les types sont vérifiés à l''exécution',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-035',v_cert_id,v_theme_id,'Que produit ''new ArrayList<String>().getClass() == new ArrayList<Integer>().getClass()'' ?','medium','SINGLE_CHOICE','Type erasure : à l''exécution, les deux sont ArrayList.class. Donc true.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','true',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','false',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassCastException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-036',v_cert_id,v_theme_id,'Qu''est-ce qu''un ''raw type'' en Java ?','hard','SINGLE_CHOICE','Un raw type est l''utilisation d''un type générique sans paramètre. Ex: List list (au lieu de List<String>). À éviter.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une collection sans paramètre générique',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une collection qui accepte tout type',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','List list = new ArrayList() (sans <>)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-037',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<String> strings = new ArrayList<>();
List raw = strings;
raw.add(42);
String s = strings.get(0);
```','medium','SINGLE_CHOICE','Le raw type permet d''ajouter un Integer. Mais strings.get(0) tente de cast en String → ClassCastException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ClassCastException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Compilation OK, runtime erreur',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Compilation error',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','42 est converti en String',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-038',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<?> list = new ArrayList<String>();
list.add("hello");
```','medium','SINGLE_CHOICE','List<?> est une liste de type inconnu. On ne peut rien ajouter (sauf null) car le type n''est pas connu.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Compilation OK',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Erreur compilation : cannot add to wildcard type',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Runtime exception',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Ajoute hello',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-039',v_cert_id,v_theme_id,'Que signifie le ''diamond operator'' <> ?','medium','SINGLE_CHOICE','Le diamond operator (<>) permet au compilateur d''inférer le type générique du côté droit. Ex: List<String> list = new ArrayList<>();','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Inférence de type générique',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Déclaration d''un type brut',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Création d''un type générique anonyme',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Opérateur de comparaison',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-040',v_cert_id,v_theme_id,'Quelle interface permet de comparer des objets pour le tri ?','easy','SINGLE_CHOICE','Comparable (ordre naturel, méthode compareTo) et Comparator (ordre externe, méthode compare) permettent le tri.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Comparable',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Comparator',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Comparable et Comparator',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Comparer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-041',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<String> list = new ArrayList<>();
list.add("B");
list.add("A");
Collections.sort(list);
System.out.println(list);
```','medium','SINGLE_CHOICE','Collections.sort() trie dans l''ordre naturel (String est Comparable, ordre alphabétique).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','[A, B]',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','[B, A]',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','[B, A]',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-042',v_cert_id,v_theme_id,'Comment trier une liste dans l''ordre inverse ?','medium','SINGLE_CHOICE','Collections.reverseOrder() ou Comparator.reverseOrder() pour tri inversé. Collections.reverse() inverse l''ordre existant sans tri.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collections.sort(list, Collections.reverseOrder())',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Collections.reverse(list)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','list.sort(Comparator.reverseOrder())',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-043',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<Person> persons = new ArrayList<>();
persons.add(new Person("Alice"));
persons.add(new Person("Bob"));
Collections.sort(persons);
```
(si Person n''implémente pas Comparable)','medium','SINGLE_CHOICE','Si Person n''implémente pas Comparable, Collections.sort() ne compile pas car il ne sait pas comment comparer.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Tri par ordre alphabétique',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Compilation error',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Runtime ClassCastException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Tri par ordre d''insertion',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-044',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<Integer> list = Arrays.asList(1, 2, 3);
list.replaceAll(x -> x * 2);
System.out.println(list);
```','medium','SINGLE_CHOICE','replaceAll() applique un UnaryOperator à chaque élément. Multiplie chaque élément par 2.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','[2, 4, 6]',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','[1, 2, 3]',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','[1, 4, 9]',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-045',v_cert_id,v_theme_id,'Que fait ''Map.computeIfAbsent()'' ?','medium','SINGLE_CHOICE','computeIfAbsent(key, mappingFunction) calcule et ajoute une valeur si la clé n''existe pas ou est associée à null.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Calcule une valeur si la clé est absente',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ajoute une valeur par défaut',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Supprime la clé si absente',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Met à jour toutes les clés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-046',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Map<String, Integer> map = new HashMap<>();
map.put("A", 1);
map.merge("A", 2, Integer::sum);
System.out.println(map.get("A"));
```','medium','SINGLE_CHOICE','merge() combine l''ancienne valeur (1) avec la nouvelle (2) via la fonction sum → 3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','2',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','3',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-047',v_cert_id,v_theme_id,'Quelle est la différence entre HashMap et ConcurrentHashMap ?','hard','SINGLE_CHOICE','ConcurrentHashMap est thread-safe, n''accepte pas null (clé ni valeur), et supporte un haut niveau de concurrence.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ConcurrentHashMap est thread-safe',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ConcurrentHashMap n''accepte pas les clés null',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ConcurrentHashMap permet des opérations concurrentes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-048',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<Integer> list = List.of(1, 2, 3);
list.add(4);
```','medium','SINGLE_CHOICE','List.of() crée une liste immuable. Toute tentative de modification lève UnsupportedOperationException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','[1, 2, 3, 4]',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','UnsupportedOperationException',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IllegalArgumentException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NullPointerException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-049',v_cert_id,v_theme_id,'Comment créer une copie défensive d''une liste ?','medium','SINGLE_CHOICE','new ArrayList<>(original) et List.copyOf() créent des copies. copyOf() crée une liste immuable.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','new ArrayList<>(original)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','List.copyOf(original)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','original.clone()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-050',v_cert_id,v_theme_id,'Que sont les ''NavigableMap'' et ''NavigableSet'' ?','medium','SINGLE_CHOICE','NavigableMap/Set (Java 6+) ajoutent des méthodes pour trouver les plus proches voisins : lower(), floor(), ceiling(), higher().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Interfaces avec des méthodes comme lower(), ceiling(), floor()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Extensions de SortedMap/SortedSet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permettent de naviguer entre les éléments',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-051',v_cert_id,v_theme_id,'Que produit ce code ?
```java
TreeMap<Integer, String> map = new TreeMap<>();
map.put(1, "A");
map.put(3, "C");
map.put(5, "E");
System.out.println(map.ceilingKey(4));
```','hard','SINGLE_CHOICE','ceilingKey() retourne la plus petite clé ≥ à la clé donnée. 5 ≥ 4, donc retourne 5.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','3',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','4',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','5',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-052',v_cert_id,v_theme_id,'Que produit ''map.floorKey(4)'' avec le même map ?','hard','SINGLE_CHOICE','floorKey() retourne la plus grande clé ≤ à la clé donnée. 3 ≤ 4, donc retourne 3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','3',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','4',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','5',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-053',v_cert_id,v_theme_id,'Que sont les ''BlockingQueue'' ?','medium','SINGLE_CHOICE','BlockingQueue (package java.util.concurrent) fournit put()/take() qui bloquent si pleine/vide.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','File d''attente thread-safe avec opérations bloquantes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','File d''attente avec capacité limitée',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utilisée dans les patterns producteur-consommateur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-054',v_cert_id,v_theme_id,'Quelle implémentation de BlockingQueue est généralement la plus performante ?','medium','SINGLE_CHOICE','ArrayBlockingQueue est basée sur un tableau circulaire, très performante pour une capacité fixe. LinkedBlockingQueue est optionnellement bornée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayBlockingQueue',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','LinkedBlockingQueue',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','PriorityBlockingQueue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','DelayQueue',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-055',v_cert_id,v_theme_id,'Que signifie ''fail-fast iterator'' ?','medium','SINGLE_CHOICE','Les itérateurs des collections java.util sont fail-fast : ils détectent les modifications concurrentes et lèvent ConcurrentModificationException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lève ConcurrentModificationException si la collection est modifiée pendant l''itération',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Itère très rapidement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ne fonctionne qu''avec des threads',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Ignore les modifications',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-056',v_cert_id,v_theme_id,'Que sont les ''copy-on-write'' collections ?','hard','SINGLE_CHOICE','CopyOnWriteArrayList et CopyOnWriteArraySet créent une nouvelle copie du tableau à chaque modification. Les itérateurs ne lèvent pas ConcurrentModificationException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Créent une copie à chaque modification',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Sont thread-safe sans verrouillage',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Conviennent pour des lectures fréquentes, rares modifications',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-057',v_cert_id,v_theme_id,'Qu''est-ce que ''EnumSet'' et ''EnumMap'' ?','hard','SINGLE_CHOICE','EnumSet et EnumMap sont des implémentations spécialisées pour les enums. EnumSet utilise un BitSet interne, très compact et rapide.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Implémentations optimisées pour les clés de type enum',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utilisent des bit masks pour EnumSet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Sont très performants',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-058',v_cert_id,v_theme_id,'Comment créer un EnumSet de toutes les constantes d''une enum ?','medium','SINGLE_CHOICE','EnumSet.allOf(Class) retourne un EnumSet contenant toutes les constantes de l''enum spécifiée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','EnumSet.allOf(Day.class)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','EnumSet.of(Day.values())',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','new EnumSet<>(Day.class)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Day.values()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-059',v_cert_id,v_theme_id,'Que signifie ''Collection'' vs ''Collections'' ?','easy','SINGLE_CHOICE','Collection (interface racine) vs Collections (classe utilitaire avec méthodes statiques comme sort(), reverse(), etc.).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collection est une interface, Collections une classe utilitaire',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Collections est une interface, Collection une classe',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ce sont des synonymes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Collection est pour les List, Collections pour les Set',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-060',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<Integer> list = new ArrayList<>(List.of(1, 2, 3, 2, 1));
Set<Integer> set = new LinkedHashSet<>(list);
System.out.println(set);
```','medium','SINGLE_CHOICE','LinkedHashSet supprime les doublons tout en conservant l''ordre d''apparition (1, puis 2, puis 3).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','[1, 2, 3]',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','[1, 2, 3, 2, 1]',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','[3, 2, 1]',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-001',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe ArrayList :','medium','SINGLE_CHOICE','ArrayList est basée sur un tableau dynamique, ce qui permet l''accès direct aux éléments par leur index. Elle peut contenir des éléments null, mais elle n''est pas thread-safe.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayList est basée sur un tableau dynamique.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ArrayList permet l''accès direct aux éléments par leur index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ArrayList est thread-safe.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ArrayList peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-002',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une LinkedList ?','easy','SINGLE_CHOICE','La méthode addLast() est utilisée pour ajouter un élément à la fin d''une LinkedList.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addLast()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','append()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','push()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','offer()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-003',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe HashSet :','hard','SINGLE_CHOICE','HashSet ne garantit pas l''ordre d''insertion, mais il ne permet pas de doublons et est basé sur une table de hachage. Il peut contenir un seul élément null.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashSet garantit l''ordre d''insertion.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HashSet ne permet pas de doublons.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HashSet est basée sur une table de hachage.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HashSet peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-004',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour obtenir la taille d''un Set ?','easy','SINGLE_CHOICE','La méthode size() est utilisée pour obtenir la taille d''un Set.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','size()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','length()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','count()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','getSize()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-005',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe TreeMap :','medium','SINGLE_CHOICE','TreeMap est basé sur un arbre rouge-noir et garantit l''ordre naturel des clés. Cependant, il ne peut pas contenir de clés null et n''est pas thread-safe.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','TreeMap est basé sur un arbre rouge-noir.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','TreeMap garantit l''ordre naturel des clés.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','TreeMap peut contenir des éléments null.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','TreeMap est thread-safe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-006',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour supprimer un élément d''une Queue ?','easy','SINGLE_CHOICE','La méthode poll() est utilisée pour supprimer et retourner l''élément en tête d''une Queue.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','remove()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','poll()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','pop()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','dequeue()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-007',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe LinkedList :','hard','SINGLE_CHOICE','LinkedList est basée sur une liste chaînée et peut contenir des éléments null. Elle n''est pas plus rapide pour les insertions et suppressions à la fin que ArrayList.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','LinkedList est basée sur une liste chaînée.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','LinkedList permet l''accès direct aux éléments par leur index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','LinkedList est plus rapide pour les insertions et suppressions à la fin que LinkedList.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','LinkedList peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-008',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour vérifier si un Set contient un élément spécifique ?','easy','SINGLE_CHOICE','La méthode contains() est utilisée pour vérifier si un Set contient un élément spécifique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','contains()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','has()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','exists()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','includes()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-009',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe ArrayList :','medium','SINGLE_CHOICE','Option A est correcte car ArrayList utilise un tableau dynamique pour stocker ses éléments. Option B est correcte car l''accès aux éléments par index est rapide dans une ArrayList (temps constant). Option C est incorrecte car ArrayList accepte des éléments null. Option D est correcte car l''insertion et la suppression d''éléments peuvent être coûteuses en termes de performances, surtout si elles nécessitent un redimensionnement du tableau interne.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayList est basé sur un tableau dynamique.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''accès aux éléments dans une ArrayList est rapide.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ArrayList n''accepte pas les éléments null.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les méthodes d''insertion et de suppression sont coûteuses en termes de performances.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-010',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une LinkedList ?','easy','SINGLE_CHOICE','Option B est correcte car addLast() ajoute un élément à la fin de la LinkedList. Option A est incorrecte car addFirst() ajoute un élément au début. Option C n''existe pas dans LinkedList. Option D est incorrecte car push() ajoute un élément au début de la liste.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addFirst()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','addLast()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','append()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','push()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-011',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe HashSet :','hard','SINGLE_CHOICE','Option A est correcte car HashSet ne garantit pas l''ordre des éléments. Option B est incorrecte car HashSet n''autorise qu''un seul élément null. Option C est incorrecte car HashSet est basé sur une structure de données de hachage, pas arborescente. Option D est correcte car HashSet n''accepte pas les doublons.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashSet ne garantit pas l''ordre des éléments.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HashSet permet les éléments null.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HashSet est basé sur une structure de données arborescente.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HashSet n''accepte pas les doublons.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-012',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour obtenir la valeur associée à une clé dans un HashMap ?','medium','SINGLE_CHOICE','Option A est correcte car get() retourne la valeur associée à une clé dans un HashMap. Les autres options ne sont pas des méthodes valides pour cette opération.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','get()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','find()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','search()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','lookup()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-013',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe TreeSet :','easy','SINGLE_CHOICE','Option A est correcte car TreeSet utilise un arbre binaire équilibré (un TreeMap sous-jacent). Option B est incorrecte car TreeSet n''autorise qu''un seul élément null. Option C est correcte car TreeSet trie les éléments selon leur ordre naturel ou un comparateur fourni. Option D est incorrecte car TreeSet peut être plus performant que HashSet dans certaines situations, notamment pour les opérations d''insertion et de suppression.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','TreeSet est basé sur un arbre binaire équilibré.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','TreeSet permet les éléments null.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','TreeSet garantit l''ordre des éléments selon leur ordre naturel ou un comparateur.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','TreeSet est moins performant que HashSet.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-014',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour vérifier si une LinkedList contient un élément spécifique ?','medium','SINGLE_CHOICE','Option A est correcte car contains() vérifie si une LinkedList contient un élément spécifique. Les autres options ne sont pas des méthodes valides pour cette opération.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','contains()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','includes()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','has()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','exists()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-015',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe HashMap :','hard','SINGLE_CHOICE','Option A est correcte car HashMap ne garantit pas l''ordre des entrées. Option B est incorrecte car HashMap n''autorise qu''une seule clé null. Option C est incorrecte car HashMap est basé sur une structure de données de hachage, pas arborescente. Option D est correcte car HashMap n''accepte pas les clés en double.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashMap ne garantit pas l''ordre des entrées.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HashMap permet les clés null.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HashMap est basé sur une structure de données arborescente.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HashMap n''accepte pas les clés en double.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-016',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour enlever le premier élément d''une LinkedList ?','easy','SINGLE_CHOICE','Option A est correcte car removeFirst() enlève le premier élément d''une LinkedList. Les autres options ne sont pas des méthodes valides pour cette opération.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','removeFirst()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','pollFirst()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','pop()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','shift()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-017',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''interface List :','medium','SINGLE_CHOICE','Option A est correcte car List maintient l''ordre d''insertion et permet les doublons. Option B est incorrecte car l''accès par index dans une List n''est pas nécessairement plus rapide que dans un Set. Option C est incorrecte car List peut contenir des éléments null. Option D est correcte car List est une sous-interface de Collection.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','List est ordonné et permet les doublons.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','List est plus rapide que Set pour l''accès par index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','List ne peut pas contenir des éléments null.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','List est une sous-interface de Collection.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-018',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une LinkedList ?','easy','SINGLE_CHOICE','Option B est correcte car addLast ajoute un élément à la fin d''une LinkedList. Option A est incorrecte car addFirst ajoute un élément au début de la liste. Option C est incorrecte car addElement n''est pas une méthode spécifique à LinkedList. Option D est incorrecte car push ajoute un élément au début de la liste.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addFirst',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','addLast',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','addElement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','push',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-019',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''interface Map ?','hard','SINGLE_CHOICE','Option C est correcte car Map permet de valeurs null. Option D est correcte car Map est une sous-interface de Collection. Option A est incorrecte car Map permet effectivement des clés null dans certaines implémentations comme HashMap. Option B est incorrecte car Map n''garantit pas l''ordre d''insertion des éléments, sauf pour LinkedHashMap qui le fait.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Map ne permet pas de clés null.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Map garantit l''ordre d''insertion des éléments.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Map permet de valeurs null.',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Map est une sous-interface de Collection.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-020',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour obtenir la taille d''un Set ?','easy','SINGLE_CHOICE','Option A est correcte car size() retourne la taille du Set. Option B est incorrecte car length n''est pas une méthode de l''interface Set. Option C est incorrecte car count n''est pas une méthode standard pour obtenir la taille d''un Set. Option D est incorrecte car getSize n''est pas une méthode standard de l''interface Set.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','size',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','length',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','count',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','getSize',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-021',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''interface Queue :','medium','SINGLE_CHOICE','Option A est correcte car Queue est une sous-interface de Collection. Option B est correcte car Queue garantit l''ordre FIFO. Option C est incorrecte car les méthodes de Queue comme poll() ou remove() suppriment l''élément. Option D est incorrecte car Queue peut contenir des éléments null, sauf pour certaines implémentations comme PriorityQueue qui ne le permettent pas.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Queue est une sous-interface de Collection.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Queue garantit l''ordre FIFO (First In, First Out).',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue permet d''accéder aux éléments sans les supprimer.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Queue ne peut pas contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-022',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations vraies concernant la classe ArrayList ?','medium','SINGLE_CHOICE','ArrayList est basé sur un tableau dynamique et permet l''accès direct aux éléments par leur index. Cependant, ArrayList n''est pas thread-safe et ne trie pas automatiquement ses éléments.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayList est basé sur un tableau dynamique.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ArrayList permet l''accès direct aux éléments par leur index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ArrayList est thread-safe.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ArrayList trie automatiquement ses éléments.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-023',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une LinkedList ?','easy','SINGLE_CHOICE','addLast() est la méthode utilisée pour ajouter un élément à la fin d''une LinkedList. addFirst() ajoute à l''avant, addElement() est une méthode de Vector et append() n''existe pas dans LinkedList.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addFirst()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','addLast()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','addElement()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','append()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-024',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe HashMap ?','hard','SINGLE_CHOICE','HashMap permet des clés null mais pas de valeurs null. HashMap n''est pas ordonné par insertion (à partir de Java 8, il est ordonné pour des performances améliorées). HashMap n''est pas thread-safe.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashMap permet des clés null.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HashMap est ordonné par insertion.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HashMap ne peut pas contenir de valeurs null.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HashMap est thread-safe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-025',v_cert_id,v_theme_id,'Quelle interface est étendue par toutes les interfaces de collection (hors Map) ?','medium','SINGLE_CHOICE','Iterable est l''interface étendue par toutes les interfaces de collection (hors Map) car elle définit la méthode iterator(). Collection est une interface plus haut dans la hiérarchie, List et Set sont des interfaces spécifiques.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collection',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Iterable',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','List',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Set',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-026',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations vraies concernant la classe HashSet ?','easy','SINGLE_CHOICE','HashSet n''accepte pas de doublons et permet des éléments null. Cependant, HashSet n''est pas ordonné par insertion (à partir de Java 8, il est ordonné pour des performances améliorées). HashSet n''est pas thread-safe.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashSet n''accepte pas de doublons.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HashSet est ordonné par insertion.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HashSet permet des éléments null.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HashSet est thread-safe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-027',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''interface List :','medium','SINGLE_CHOICE','Option A est correcte car List maintient l''ordre d''insertion et permet les doublons. Option B est incorrecte car List peut être utilisé avec des objets, mais pas directement avec des primitives. Option C est correcte car List est une sous-interface de Collection. Option D est incorrecte car List garantit l''ordre d''insertion.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','List est ordonné et accepte les doublons.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','List ne peut pas être utilisé avec des primitives.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','List est une sous-interface de Collection.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','List ne garantit pas l''ordre d''insertion.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-028',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une List ?','easy','SINGLE_CHOICE','Option D est correcte car la méthode add(E element) ajoute un élément à la fin de la List. Options A, B et C sont incorrectes car elles ne correspondent pas aux méthodes standard de la List.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','add(int index, E element)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','append(E element)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','push(E element)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','add(E element)',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-029',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''interface Set :','hard','SINGLE_CHOICE','Option B est correcte car Set ne permet pas de doublons. Option D est correcte car Set peut contenir des éléments null, sauf pour les implémentations spécifiques comme EnumSet. Option A est incorrecte car Set n''garantit pas l''ordre d''insertion. Option C est incorrecte car Set n''est pas une sous-interface de List.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Set garantit l''ordre d''insertion.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Set ne permet pas de doublons.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Set est une sous-interface de List.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Set peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-030',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour obtenir la taille d''une Collection ?','easy','SINGLE_CHOICE','Option A est correcte car la méthode size() retourne le nombre d''éléments dans une Collection. Options B, C et D sont incorrectes car elles ne correspondent pas aux méthodes standard de la Collection.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','size()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','length()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','count()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','getSize()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-031',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''interface Map :','medium','SINGLE_CHOICE','Option A est correcte car Map associe des clés à des valeurs. Option B est correcte car Map ne permet pas de doublons pour les clés. Option C est incorrecte car Map n''est pas une sous-interface de Collection, mais une interface distincte. Option D est correcte car Map peut contenir des éléments null pour les clés et/ou les valeurs, sauf pour les implémentations spécifiques comme HashMap qui ne permet pas de clés null par défaut.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Map associe des clés à des valeurs.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Map ne permet pas de doublons pour les clés.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Map est une sous-interface de Collection.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Map peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-032',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la méthode toArray() dans l''interface Collection :','medium','SINGLE_CHOICE','toArray() retourne un tableau d''Object[] par défaut, donc l''affirmation A est correcte. toArray(T[] a) retourne un tableau de type T[] si le tableau passé est assez grand, donc l''affirmation B est correcte. L''affirmation C est incorrecte car toArray(T[] a) retourne un tableau de type T[] avec une taille égale au nombre d''éléments dans la Collection, pas nécessairement de la même taille que le tableau passé. L''affirmation D est correcte car toArray(T[] a) retourne un tableau de type T[] avec une taille égale au nombre d''éléments dans la Collection.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','toArray() retourne un tableau d''Object[]',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','toArray(T[] a) retourne un tableau de type T[] si le tableau passé est assez grand',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','toArray(T[] a) retourne un nouveau tableau de type T[] avec la même taille que le Collection',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','toArray(T[] a) retourne un tableau de type T[] avec une taille égale au nombre d''éléments dans la Collection',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-033',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une LinkedList ?','easy','SINGLE_CHOICE','La méthode add() est utilisée pour ajouter un élément à la fin d''une LinkedList, donc l''affirmation A est correcte. append() n''est pas une méthode standard pour les LinkedList en Java, donc l''affirmation B est incorrecte. push() ajoute un élément au début de la LinkedList, donc l''affirmation C est incorrecte. offerLast() ajoute un élément à la fin de la LinkedList, mais elle retourne un booléen indiquant si l''élément a été ajouté, donc l''affirmation D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','add()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','append()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','push()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','offerLast()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-034',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''interface List :','medium','SINGLE_CHOICE','Option A est correcte car List maintient l''ordre d''insertion et permet les doublons. Option B est correcte car List offre un accès rapide aux éléments par index, ce qui la rend généralement plus rapide que Set pour cette opération. Option C est incorrecte car Set et List sont des interfaces distinctes, l''une ne dérivant pas de l''autre. Option D est incorrecte car List peut contenir des objets et des primitives, mais les primitives sont généralement emballées dans leurs classes wrapper.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','List est ordonné et accepte les doublons.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','List est plus rapide que Set pour l''accès par index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Set est une sous-interface de List.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','List ne peut contenir que des objets.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-035',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une List ?','easy','SINGLE_CHOICE','Option D est correcte car la méthode add() ajoute un élément à la fin d''une List. Les autres options ne sont pas des méthodes standard pour ajouter un élément à une List : addFirst() est spécifique aux LinkedList, append() et push() ne sont pas des méthodes de List.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addFirst()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','append()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','push()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','add()',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-036',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''interface Set :','hard','SINGLE_CHOICE','Option A est correcte car Set ne garantit pas l''ordre des éléments. Option B est incorrecte car les éléments de Set ne peuvent pas être accessibles par index, contrairement aux List. Option C est correcte car Set ne permet pas de doublons basé sur equals() et hashCode(). Option D est incorrecte car Set et List sont des interfaces distinctes, l''une ne dérivant pas de l''autre.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Set n''est pas ordonné.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Set permet d''accéder aux éléments par index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Set ne peut contenir des doublons.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Set est une sous-interface de List.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-037',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à une Set ?','medium','SINGLE_CHOICE','Option D est correcte car la méthode add() ajoute un élément à une Set. Les autres options ne sont pas des méthodes standard pour ajouter un élément à une Set : addFirst() est spécifique aux LinkedList, append() et push() ne sont pas des méthodes de Set.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addFirst()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','append()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','push()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','add()',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-038',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''interface Map :','easy','SINGLE_CHOICE','Option A est incorrecte car Map n''est pas ordonnée par défaut, bien que certaines implémentations comme LinkedHashMap puissent maintenir l''ordre d''insertion. Option B est correcte car Map permet d''accéder aux éléments en utilisant une clé unique. Option C est incorrecte car Map ne peut pas contenir de doublons de clés, chaque clé doit être unique. Option D est correcte car Map est une sous-interface de Collection, bien que ce ne soit pas directement visible dans l''interface Map elle-même.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Map est ordonné par défaut.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Map permet d''accéder aux éléments par clé.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Map peut contenir des doublons de clés.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Map est une sous-interface de Collection.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-039',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe ArrayList :','medium','SINGLE_CHOICE','ArrayList est basé sur un tableau dynamique (A est correct). Il permet l''accès direct aux éléments par index (B est correct). Cependant, ArrayList n''est pas thread-safe (C est incorrect). Il peut contenir des éléments null (D est correct).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayList est basé sur un tableau dynamique.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ArrayList permet l''accès direct aux éléments par index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ArrayList est thread-safe.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ArrayList peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-040',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une LinkedList ?','easy','SINGLE_CHOICE','addLast() est la méthode utilisée pour ajouter un élément à la fin d''une LinkedList (B est correct). addFirst() ajoute un élément au début (A est incorrect). addElement() n''est pas une méthode de LinkedList (C est incorrect). push() ajoute un élément au début, comme en pile (D est incorrect).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addFirst()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','addLast()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','addElement()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','push()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-041',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe HashSet ?','hard','SINGLE_CHOICE','HashSet n''autorise pas les éléments en double (B est correct). HashSet est basé sur une table de hachage (C est correct). HashSet ne garantit pas l''ordre d''insertion (A est incorrect). Bien que possible, HashSet ne recommande pas de contenir des éléments null multiples (D est incorrect).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashSet garantit l''ordre d''insertion.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HashSet n''autorise pas les éléments en double.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HashSet est basé sur une table de hachage.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HashSet peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-042',v_cert_id,v_theme_id,'Quelle interface est étendue par Map et permet d''accéder aux éléments par clé ?','easy','SINGLE_CHOICE','Map.Entry est l''interface étendue par Map et permet d''accéder aux éléments par clé (C est correct). Collection et Iterable sont des interfaces de haut niveau pour les collections (A et B sont incorrects). NavigableMap est une sous-interface de SortedMap, pas directement liée à l''accès par clé (D est incorrect).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collection',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Iterable',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Map.Entry',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NavigableMap',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-043',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''utilisation de génériques dans Java :','medium','SINGLE_CHOICE','Les génériques permettent de définir des classes et des méthodes paramétrées (A est correct). Ils garantissent la sécurité du type à la compilation, pas à l''exécution (B est incorrect). Les génériques ne peuvent pas être utilisés avec des types primitifs (C est incorrect). Les génériques permettent de créer des collections typées, ce qui évite les casts (D est correct).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les génériques permettent de définir des classes et des méthodes paramétrées.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les génériques garantissent la sécurité du type à l''exécution.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les génériques peuvent être utilisés avec des types primitifs.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les génériques permettent de créer des collections typées.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-044',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe ArrayList :','medium','SINGLE_CHOICE','ArrayList est basé sur un tableau dynamique (Option A correcte). Il permet l''accès direct aux éléments par index (Option B correcte). ArrayList n''est pas thread-safe, contrairement à Vector (Option C incorrecte). ArrayList peut contenir des éléments null (Option D correcte).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayList est basé sur un tableau dynamique.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ArrayList permet l''accès direct aux éléments par index.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ArrayList est thread-safe.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ArrayList peut contenir des éléments null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-045',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ajouter un élément à la fin d''une LinkedList ?','easy','SINGLE_CHOICE','addLast() est la méthode utilisée pour ajouter un élément à la fin d''une LinkedList (Option B correcte). addFirst() ajoute un élément au début (Option A incorrecte). append() n''est pas une méthode de LinkedList (Option C incorrecte). push() ajoute un élément au début, comme une pile (Option D incorrecte).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addFirst()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','addLast()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','append()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','push()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-046',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe HashMap :','hard','SINGLE_CHOICE','HashMap permet une clé null (Option A incorrecte). HashMap est ordonnée par insertion à partir de Java 8 (Option B correcte). HashMap permet des valeurs null (Option C incorrecte). HashMap ne peut contenir qu''une seule entrée pour une clé donnée (Option D incorrecte).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashMap ne permet pas de clés null.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','HashMap est ordonnée par insertion.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HashMap ne permet pas de valeurs null.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HashMap peut contenir plusieurs entrées avec la même clé.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-CEG-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-CEG-047',v_cert_id,v_theme_id,'Quelle interface est utilisée pour représenter une collection ordonnée et qui ne permet pas de doublons ?','medium','SINGLE_CHOICE','Set est l''interface utilisée pour représenter une collection ordonnée et qui ne permet pas de doublons (Option B correcte). List est ordonnée mais peut contenir des doublons (Option A incorrecte). Queue est une collection ordonnée mais permet généralement des doublons (Option C incorrecte). Map n''est pas une collection ordonnée et ne permet pas de doublons pour les clés, mais elle peut contenir des valeurs en double (Option D incorrecte).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','List',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Set',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Queue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Map',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-001',v_cert_id,v_theme_id,'Quelle est la classe parente de toutes les exceptions en Java ?','easy','SINGLE_CHOICE','Throwable est la classe racine de toute la hiérarchie des exceptions. Exception et Error héritent de Throwable.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Exception',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Throwable',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Error',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','RuntimeException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-002',v_cert_id,v_theme_id,'Quelle est la différence entre Exception et Error ?','easy','SINGLE_CHOICE','Error (OutOfMemoryError, StackOverflowError) indique des problèmes système graves. Exception est pour les erreurs applicatives.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Error est pour des problèmes système, Exception pour des erreurs applicatives',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Exception est checked, Error est unchecked',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Error ne doit pas être rattrapé',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-003',v_cert_id,v_theme_id,'Quelle est la différence entre checked et unchecked exception ?','easy','SINGLE_CHOICE','Checked exceptions : IOException, SQLException. Unchecked : RuntimeException, NullPointerException, etc.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Checked doit être catchée ou déclarée (throws), unchecked non',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Unchecked hérite de RuntimeException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Checked hérite d''Exception (sauf RuntimeException)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-004',v_cert_id,v_theme_id,'Que se passe-t-il si une checked exception n''est ni catchée ni déclarée ?','easy','SINGLE_CHOICE','Le compilateur exige que les checked exceptions soient gérées (catch) ou déclarées (throws). Sinon, erreur de compilation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Runtime exception',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Erreur de compilation',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''exception est ignorée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La JVM s''arrête',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-005',v_cert_id,v_theme_id,'Que produit ce code ?
```java
try {
    int x = 10 / 0;
} catch (ArithmeticException e) {
    System.out.print("A");
} finally {
    System.out.print("B");
}
```','easy','SINGLE_CHOICE','ArithmeticException est catchée → affiche A, puis finally s''exécute toujours → affiche B.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','A',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','B',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','AB',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','BA',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-006',v_cert_id,v_theme_id,'Le bloc finally s''exécute-t-il toujours ?','easy','SINGLE_CHOICE','finally s''exécute toujours, sauf en cas de System.exit() ou de crash JVM (segfault). Même avec return, finally s''exécute.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui, toujours',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non, jamais',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, sauf si System.exit() est appelé',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, sauf si une exception non catchée est levée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-007',v_cert_id,v_theme_id,'Que produit ce code ?
```java
try {
    return 1;
} finally {
    return 2;
}
```','medium','SINGLE_CHOICE','finally s''exécute après le return du try, et son return remplace la valeur. Donc retourne 2. (À éviter absolument !)','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','2',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','0',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-008',v_cert_id,v_theme_id,'Que produit ce code ?
```java
try {
    throw new RuntimeException();
} finally {
    return 42;
}
```','medium','SINGLE_CHOICE','finally avec return supprime l''exception. L''exception est perdue, la méthode retourne 42. Très mauvais pattern.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','42 (l''exception est supprimée)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','RuntimeException est levée',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','42 puis exception',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-009',v_cert_id,v_theme_id,'Quel est l''ordre d''exécution des blocs try-catch-finally ?','medium','SINGLE_CHOICE','Ordre : try d''abord, puis catch si exception, puis finally toujours (sauf System.exit).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try → catch (si exception) → finally',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try → finally → catch',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','catch → try → finally',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','finally → try → catch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-010',v_cert_id,v_theme_id,'Que signifie ''try-with-resources'' ?','easy','SINGLE_CHOICE','try-with-resources (Java 7+) ferme automatiquement les ressources déclarées entre parenthèses après try.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ferme automatiquement les ressources implémentant AutoCloseable',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Un try avec plusieurs catch',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Un try sans catch',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une nouvelle syntaxe pour les exceptions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-011',v_cert_id,v_theme_id,'Quelle interface doit implémenter une ressource pour try-with-resources ?','medium','SINGLE_CHOICE','AutoCloseable (Java 7+) avec méthode close(). Closeable étend AutoCloseable. Les deux fonctionnent.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Closeable',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','AutoCloseable',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Flushable',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Runnable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-012',v_cert_id,v_theme_id,'Quelle est la syntaxe correcte du try-with-resources ?','medium','SINGLE_CHOICE','Java 7 : try (Resource r = new Resource()). Java 9 : try (r) avec variable effectively final. Java 10+ : try (var r = ...).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try (BufferedReader br = new BufferedReader(...)) { ... }',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try (br) { ... } (Java 9+)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try (var br = new BufferedReader(...)) { ... } (Java 10+)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-013',v_cert_id,v_theme_id,'Que se passe-t-il si close() lève une exception dans try-with-resources ?','hard','SINGLE_CHOICE','Si une exception est levée dans le try, et une autre dans close(), l''exception de close() est ajoutée comme ''suppressed'' à l''exception principale.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''exception est ignorée',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''exception est ajoutée comme suppressed',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''exception est levée immédiatement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le programme s''arrête',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-014',v_cert_id,v_theme_id,'Comment récupérer les exceptions supprimées (suppressed) ?','medium','SINGLE_CHOICE','getSuppressed() retourne un tableau des exceptions qui ont été supprimées (typiquement dans try-with-resources).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Throwable.getSuppressed()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Exception.getSuppressedExceptions()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Throwable.getCauses()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Impossible',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-015',v_cert_id,v_theme_id,'Que signifie ''throws'' dans une signature de méthode ?','easy','SINGLE_CHOICE','throws déclare qu''une méthode peut lever une checked exception. L''appelant doit la gérer ou la déclarer aussi.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La méthode peut lever cette exception',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La méthode attrape cette exception',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La méthode ignore l''exception',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La méthode crée l''exception',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-016',v_cert_id,v_theme_id,'Peut-on déclarer plusieurs exceptions avec throws ?','easy','SINGLE_CHOICE','throws IOException, SQLException déclare plusieurs exceptions séparées par des virgules.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, une seule',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, séparées par des virgules',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, mais seulement des unchecked',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, avec un tableau',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-017',v_cert_id,v_theme_id,'Que produit ce code ?
```java
public static void main(String[] args) {
    try {
        throw new NullPointerException();
    } catch (ArithmeticException e) {
        System.out.print("A");
    }
}
```','medium','SINGLE_CHOICE','NullPointerException n''est pas un ArithmeticException, donc non catchée → exception non gérée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','A',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','NullPointerException non catchée',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Rien',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-018',v_cert_id,v_theme_id,'Que produit ce code ?
```java
try {
    throw new IOException();
} catch (Exception e) {
    System.out.print("A");
} catch (IOException e) {
    System.out.print("B");
}
```','medium','SINGLE_CHOICE','IOException est une sous-classe d''Exception. Le premier catch attrape tout, le second est inaccessible → erreur compilation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','A',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','B',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation : IOException déjà catchée',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','AB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-019',v_cert_id,v_theme_id,'L''ordre des blocs catch est important. Pourquoi ?','medium','SINGLE_CHOICE','Le premier catch qui correspond est exécuté. Il faut mettre les sous-classes avant les super-classes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Pour des raisons de performance',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les exceptions plus spécifiques doivent précéder les plus générales',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''ordre n''a pas d''importance',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les exceptions générales d''abord',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-020',v_cert_id,v_theme_id,'Que signifie ''multi-catch'' (Java 7+) ?','medium','SINGLE_CHOICE','Multi-catch : catch (IOException | SQLException e) {}. Le type de e est la super-classe commune.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Attraper plusieurs exceptions dans un seul catch',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','catch (IOException | SQLException e)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','catch (IOException, SQLException e)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-021',v_cert_id,v_theme_id,'Que peut-on faire avec ''e'' dans un multi-catch ?','hard','SINGLE_CHOICE','e a le type de la super-classe commune. On peut relaver (si effectivement final ou effectively final en Java 7+).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Appeler des méthodes communes à toutes les exceptions',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Relaver l''exception avec throw e',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser instanceof pour distinguer',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-022',v_cert_id,v_theme_id,'Quelle exception est levée par Integer.parseInt("abc") ?','easy','SINGLE_CHOICE','NumberFormatException (sous-classe de IllegalArgumentException) est levée quand la chaîne n''est pas un nombre valide.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','NumberFormatException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IllegalArgumentException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ParseException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NullPointerException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-023',v_cert_id,v_theme_id,'Quelle exception est levée par new int[-1] ?','easy','SINGLE_CHOICE','NegativeArraySizeException (RuntimeException) est levée quand on tente de créer un tableau avec une taille négative.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','NegativeArraySizeException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IllegalArgumentException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ArrayIndexOutOfBoundsException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','IndexOutOfBoundsException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-024',v_cert_id,v_theme_id,'Quelle exception est levée par arr[10] si arr a taille 5 ?','easy','SINGLE_CHOICE','ArrayIndexOutOfBoundsException (sous-classe de IndexOutOfBoundsException) pour les accès hors limites de tableau.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayIndexOutOfBoundsException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IndexOutOfBoundsException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IllegalArgumentException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NegativeArraySizeException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-025',v_cert_id,v_theme_id,'Quelle exception est levée par String s = null; s.length(); ?','easy','SINGLE_CHOICE','NullPointerException quand on appelle une méthode sur une référence null.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','NullPointerException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IllegalStateException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IllegalArgumentException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassCastException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-026',v_cert_id,v_theme_id,'Quelle exception est levée par Object obj = new Integer(5); String s = (String) obj; ?','easy','SINGLE_CHOICE','ClassCastException quand on caste un objet vers un type incompatible.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ClassCastException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','NullPointerException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IllegalArgumentException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassNotFoundException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-027',v_cert_id,v_theme_id,'Que produit ce code ?
```java
try {
    int[] arr = new int[-5];
} catch (NegativeArraySizeException e) {
    System.out.print("A");
} catch (RuntimeException e) {
    System.out.print("B");
}
```','medium','SINGLE_CHOICE','NegativeArraySizeException est une RuntimeException, mais le catch spécifique est trouvé en premier.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','A',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','B',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','AB',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-028',v_cert_id,v_theme_id,'Que sont les ''exception chaining'' ?','hard','SINGLE_CHOICE','Exception chaining permet d''encapsuler une exception dans une autre pour préserver la trace de la cause originale.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une exception qui en contient une autre (cause)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utiliser initCause() ou constructeur avec cause',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','getCause() pour remonter la chaîne',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-029',v_cert_id,v_theme_id,'Comment créer une exception personnalisée ?','medium','SINGLE_CHOICE','Une exception personnalisée étend Exception ou RuntimeException. Recommandé : fournir les 4 constructeurs standards.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Étendre Exception (checked) ou RuntimeException (unchecked)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Définir des constructeurs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Peut ajouter des champs spécifiques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-030',v_cert_id,v_theme_id,'Quelle est la sortie de ''e.printStackTrace()'' ?','easy','SINGLE_CHOICE','printStackTrace() affiche la trace d''exécution (stack trace) sur la sortie d''erreur standard (System.err).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Affiche la trace de la pile sur System.err',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Retourne une String',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Lève une exception',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Ne fait rien',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-031',v_cert_id,v_theme_id,'Que fait ''throw new AssertionError()'' ?','medium','SINGLE_CHOICE','AssertionError est une Error (unchecked). Typiquement utilisé avec assert, ou pour des cas ''impossible'' dans le code.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lève une erreur d''assertion',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Est utilisé pour les tests',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Indique une condition qui ne devrait jamais arriver',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-032',v_cert_id,v_theme_id,'Que se passe-t-il avec ''assert x > 0'' ?','medium','SINGLE_CHOICE','Les assertions (assert) sont désactivées par défaut. Activer avec -ea (enable assertions).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lève AssertionError si x ≤ 0',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ne fait rien si les assertions sont désactivées',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Doit être activé avec -ea',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-033',v_cert_id,v_theme_id,'Que produit ce code ?
```java
public static int test() {
    try {
        return 1;
    } finally {
        System.out.print("finally ");
    }
}
System.out.print(test());
```','hard','SINGLE_CHOICE','finally s''exécute avant que le return ne soit effectif. Donc ''finally '' puis ''1''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','finally 1',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','1 finally',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','finally',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-034',v_cert_id,v_theme_id,'Que produit ce code ?
```java
public static int test() {
    int x = 1;
    try {
        return x;
    } finally {
        x = 2;
    }
}
System.out.print(test());
```','hard','SINGLE_CHOICE','La valeur de retour est calculée avant l''exécution de finally. x=2 n''affecte pas la valeur retournée (1).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','2',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','0',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-035',v_cert_id,v_theme_id,'Que signifie ''finally block does not complete normally'' ?','medium','SINGLE_CHOICE','Si finally contient return ou throw, le compilateur avertit que le bloc finally peut interrompre le flux normal.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le finally contient un return ou throw',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le finally est vide',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le finally n''existe pas',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur de compilation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-036',v_cert_id,v_theme_id,'Peut-on avoir un try sans catch ?','medium','SINGLE_CHOICE','try-finally est valide (sans catch). try-with-resources peut aussi être sans catch (les ressources sont fermées).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, try nécessite catch ou finally',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, try-finally est valide',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, mais seulement avec try-with-resources',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','B et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-037',v_cert_id,v_theme_id,'Que produit ce code ?
```java
public static void main(String[] args) {
    try {
        System.exit(0);
    } finally {
        System.out.print("finally");
    }
}
```','medium','SINGLE_CHOICE','System.exit() arrête la JVM immédiatement. finally n''est PAS exécuté.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','finally',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Rien',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','finally puis exit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-038',v_cert_id,v_theme_id,'Qu''est-ce que ''try-with-resources'' améliore par rapport à try-catch-finally ?','hard','SINGLE_CHOICE','try-with-resources simplifie la gestion des ressources et gère correctement les exceptions multiples avec suppressed.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Moins de code boilerplate',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Gestion automatique des exceptions supprimées (suppressed)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Fermeture garantie des ressources',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-039',v_cert_id,v_theme_id,'Quelle est l''ordre de fermeture dans try-with-resources ?','medium','SINGLE_CHOICE','Les ressources sont fermées dans l''ordre inverse de leur déclaration (LIFO : last declared, first closed).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ordre inverse de déclaration',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ordre de déclaration',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ordre alphabétique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Aléatoire',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-040',v_cert_id,v_theme_id,'Que se passe-t-il si deux ressources lèvent des exceptions lors de close() ?','medium','SINGLE_CHOICE','La première exception de close est la principale, les suivantes lui sont ajoutées comme suppressed.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La première est perdue',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La seconde est ajoutée comme suppressed à la première',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les deux sont perdues',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une seule est levée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-041',v_cert_id,v_theme_id,'Quelle méthode permet d''ajouter une exception supprimée ?','medium','SINGLE_CHOICE','Throwable.addSuppressed(Throwable) ajoute une exception à la liste des exceptions supprimées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','addSuppressed()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','addSuppressedException()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','suppress()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','addCause()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-042',v_cert_id,v_theme_id,'Quelle est la différence entre ''throws'' et ''throw'' ?','hard','SINGLE_CHOICE','throw new Exception() lance une exception. throws Exception dans la signature déclare qu''elle peut être lancée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','throws déclare, throw lance une exception',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','throw lance, throws déclare',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les deux sont identiques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','throws est pour les méthodes, throw pour les blocs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-043',v_cert_id,v_theme_id,'Peut-on relancer une exception dans un catch ?','medium','SINGLE_CHOICE','On peut relancer une exception. En Java 7+, si e est effectively final, le type déclaré est plus précis.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui, avec throw e',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, mais seulement si e est déclaré dans throws',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, en utilisant la même variable',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-044',v_cert_id,v_theme_id,'Qu''est-ce que ''final rethrow'' (Java 7+) ?','hard','SINGLE_CHOICE','Final rethrow : si le paramètre catch est effectively final, le compilateur peut utiliser le type exact de l''exception.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Relaver une exception avec un type plus précis',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le compilateur peut inférer un type plus spécifique que Exception',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utilise la précision du catch',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-045',v_cert_id,v_theme_id,'Que signifie ''StackOverflowError'' ?','easy','SINGLE_CHOICE','StackOverflowError se produit quand la pile d''appels dépasse sa capacité (typiquement récursion infinie).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Récursion infinie ou trop profonde',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Mémoire heap insuffisante',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Trop de threads',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur d''E/S',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-046',v_cert_id,v_theme_id,'Que signifie ''OutOfMemoryError'' ?','easy','SINGLE_CHOICE','OutOfMemoryError se produit quand la JVM ne peut plus allouer d''objet faute de mémoire heap.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Plus assez de mémoire heap',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Trop d''objets en mémoire',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Fuite mémoire',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses peuvent causer OOME',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-047',v_cert_id,v_theme_id,'Peut-on rattraper un Error ?','medium','SINGLE_CHOICE','On peut techniquement rattraper Error, mais c''est déconseillé car indique des problèmes système graves (OOME, SOE).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, jamais',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, avec catch (Error e)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, mais déconseillé',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','B et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-048',v_cert_id,v_theme_id,'Que produit ce code ?
```java
try {
    throw new NullPointerException();
} catch (NullPointerException e) {
    throw new IllegalArgumentException(e);
}
```','hard','SINGLE_CHOICE','On encapsule NPE dans IllegalArgumentException. getCause() retournera le NPE d''origine.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','IllegalArgumentException avec NPE comme cause',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','NullPointerException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les deux exceptions',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur compilation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-049',v_cert_id,v_theme_id,'Comment obtenir la cause originale d''une exception encapsulée ?','medium','SINGLE_CHOICE','Throwable.getCause() retourne l''exception qui a causé l''exception courante (si encapsulée).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','getCause()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','getRootCause()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','getOriginalException()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','getSuppressed()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-05-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-05-050',v_cert_id,v_theme_id,'Quelle est la meilleure pratique pour les exceptions ?','medium','SINGLE_CHOICE','Bonnes pratiques : ne jamais avaler d''exception, logger, utiliser des types spécifiques, ne pas utiliser Exception pour tout.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ne pas avaler les exceptions (catch vide)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Logger l''exception',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser des exceptions spécifiques plutôt que Exception générique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-001',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la hiérarchie des exceptions en Java :','medium','SINGLE_CHOICE','Toutes les exceptions héritent de la classe Throwable, ce qui est correct. Error et Exception sont des classes sœurs dans l''arbre d''héritage, ce qui est également correct. RuntimeException n''est pas une sous-classe de Error mais d''Exception, ce qui rend cette option incorrecte. Les exceptions Checked sont effectivement des sous-classes d''Exception, ce qui est correct.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Toutes les exceptions héritent de la classe Throwable.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Error et Exception sont des classes sœurs dans l''arbre d''héritage.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','RuntimeException est une sous-classe de Error.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les exceptions Checked sont des sous-classes d''Exception.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-002',v_cert_id,v_theme_id,'Quelle est la différence entre try-catch et try-with-resources en Java ?','easy','SINGLE_CHOICE','try-with-resources est utilisé pour gérer des ressources qui implémentent AutoCloseable, ce qui est correct. try-catch permet de capturer des exceptions, tandis que try-with-resources peut également être utilisé pour gérer les exceptions lors de la fermeture des ressources, ce qui rend cette option incorrecte. try-catch peut être utilisé avec des ressources AutoCloseable, mais try-with-resources est spécifiquement conçu pour cela, ce qui rend cette option incorrecte. try-catch et try-with-resources ne sont pas interchangeables dans tous les cas, car try-with-resources est conçu pour gérer des ressources AutoCloseable, ce qui rend cette option incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources est utilisé pour gérer des ressources qui implémentent AutoCloseable.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try-catch permet de capturer des exceptions, tandis que try-with-resources ne le fait pas.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try-catch peut être utilisé avec des ressources AutoCloseable, mais try-with-resources ne le fait pas.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','try-catch et try-with-resources sont interchangeables dans tous les cas.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-003',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le bloc finally en Java ?','hard','SINGLE_CHOICE','Le bloc finally est toujours exécuté, même si une exception n''est pas lancée, ce qui est correct. Le bloc finally peut être omis s''il ne contient aucune instruction, ce qui est correct. Le bloc finally n''est pas exécuté avant le bloc catch si une exception est lancée, mais après, ce qui rend cette option incorrecte. Le bloc finally peut être utilisé pour libérer des ressources, ce qui est correct.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc finally est toujours exécuté, même si une exception n''est pas lancée.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc finally peut être omis s''il ne contient aucune instruction.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc finally est exécuté avant le bloc catch si une exception est lancée.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le bloc finally peut être utilisé pour libérer des ressources.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-004',v_cert_id,v_theme_id,'Quelle est la signification de l''instruction ''throw'' en Java ?','easy','SINGLE_CHOICE','L''instruction ''throw'' lance une nouvelle exception, ce qui est correct. Capture une exception existante n''est pas la fonction de ''throw'', ce qui rend cette option incorrecte. Termine le programme immédiatement n''est pas la fonction de ''throw'', ce qui rend cette option incorrecte. Résout une exception existante n''est pas la fonction de ''throw'', ce qui rend cette option incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lance une nouvelle exception.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Capture une exception existante.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Termine le programme immédiatement.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Résout une exception existante.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-005',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''utilisation de try-with-resources en Java :','medium','SINGLE_CHOICE','try-with-resources est utilisé pour gérer des ressources qui implémentent AutoCloseable, ce qui est correct. try-with-resources peut être utilisé avec plusieurs ressources en les déclarant dans le même bloc, ce qui est correct. try-with-resources garantit que toutes les ressources sont fermées à la fin du bloc try, ce qui est correct. try-with-resources peut être utilisé avec des ressources qui ne sont pas AutoCloseable, ce qui rend cette option incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources est utilisé pour gérer des ressources qui implémentent AutoCloseable.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try-with-resources peut être utilisé avec plusieurs ressources en les déclarant dans le même bloc.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try-with-resources garantit que toutes les ressources sont fermées à la fin du bloc try.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','try-with-resources ne peut pas être utilisé avec des ressources qui ne sont pas AutoCloseable.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-006',v_cert_id,v_theme_id,'Quelle est la différence entre une exception Checked et une exception Unchecked en Java ?','easy','SINGLE_CHOICE','Les exceptions Checked doivent être déclarées dans la signature de méthode ou capturées, ce qui est correct. Les exceptions Unchecked ne sont pas des sous-classes d''Error mais de RuntimeException, ce qui rend cette option incorrecte. Les exceptions Checked ne sont pas toujours lancées par le système, ce qui rend cette option incorrecte. Les exceptions Checked sont gérées au moment de la compilation, tandis que les exceptions Unchecked sont gérées au moment de l''exécution, ce qui est correct.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les exceptions Checked doivent être déclarées dans la signature de méthode ou capturées.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les exceptions Unchecked sont des sous-classes d''Error.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les exceptions Checked sont toujours lancées par le système, tandis que les exceptions Unchecked peuvent être lancées par l''utilisateur.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les exceptions Checked sont gérées au moment de la compilation, tandis que les exceptions Unchecked sont gérées au moment de l''exécution.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-007',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''utilisation du mot-clé ''finally'' en Java ?','hard','SINGLE_CHOICE','Le bloc finally est toujours exécuté, même si une exception n''est pas lancée, ce qui est correct. Le bloc finally peut être omis s''il ne contient aucune instruction, ce qui est correct. Le bloc finally n''est pas exécuté avant le bloc catch si une exception est lancée, mais après, ce qui rend cette option incorrecte. Le bloc finally peut être utilisé pour libérer des ressources, ce qui est correct.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc finally est toujours exécuté, même si une exception n''est pas lancée.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc finally peut être omis s''il ne contient aucune instruction.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc finally est exécuté avant le bloc catch si une exception est lancée.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le bloc finally peut être utilisé pour libérer des ressources.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-008',v_cert_id,v_theme_id,'Quelle est la signification de l''instruction ''throws'' en Java ?','easy','SINGLE_CHOICE','L''instruction ''throws'' indique que la méthode peut lancer des exceptions spécifiques, ce qui est correct. Lance une nouvelle exception n''est pas la fonction de ''throws'', ce qui rend cette option incorrecte. Capture une exception existante n''est pas la fonction de ''throws'', ce qui rend cette option incorrecte. Résout une exception existante n''est pas la fonction de ''throws'', ce qui rend cette option incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lance une nouvelle exception.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Indique que la méthode peut lancer des exceptions spécifiques.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Capture une exception existante.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Résout une exception existante.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-009',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''instruction try-catch-finally en Java :','medium','SINGLE_CHOICE','Le bloc finally est effectivement exécuté même si aucune exception n''est lancée, ce qui le rend utile pour libérer des ressources. Le bloc catch n''est pas obligatoire si aucune gestion d''exception spécifique n''est requise, mais il est souvent utilisé. Il est possible de définir plusieurs blocs catch pour gérer différentes types d''exceptions spécifiques. Le bloc finally peut être omis, mais il est recommandé de l''utiliser pour garantir la fermeture des ressources ou d''autres opérations de nettoyage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc finally est exécuté même si une exception n''est pas lancée.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc catch doit toujours être utilisé avec un bloc try.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Il est possible d''avoir plusieurs blocs catch pour une seule instruction try.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le bloc finally peut être omis si aucun traitement n''est nécessaire après le bloc try.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-010',v_cert_id,v_theme_id,'Quelle est la principale différence entre try-catch-finally et try-with-resources en Java ?','easy','SINGLE_CHOICE','La principale différence est que try-with-resources permet de gérer automatiquement les ressources en s''assurant qu''elles sont fermées après l''exécution du bloc try, même en cas d''exception. Le bloc finally peut être utilisé avec try-with-resources pour des opérations supplémentaires, mais il n''est pas nécessaire. try-catch-finally peut gérer toutes les ressources, pas seulement celles qui implémentent AutoCloseable. En général, try-with-resources est aussi performant ou plus performant que try-catch-finally pour la gestion des ressources.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources permet de gérer automatiquement les ressources.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc finally n''est pas nécessaire dans try-with-resources.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try-catch-finally ne peut gérer que des ressources qui implémentent AutoCloseable.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','try-with-resources est moins performant que try-catch-finally.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-011',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''utilisation de try-with-resources :','medium','SINGLE_CHOICE','Option A est correcte car try-with-resources est bien utilisé pour gérer les ressources AutoCloseable. Option B est correcte car vous pouvez déclarer plusieurs ressources dans une clause try, séparées par des points-virgules. Option C est incorrecte car try-with-resources ne remplace pas complètement le bloc finally, mais peut être utilisé avec un bloc finally. Option D est incorrecte car les exceptions lancées dans un try-with-resources sont ajoutées à la pile des exceptions si une exception est déjà en cours de traitement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources est utilisé pour gérer automatiquement les ressources qui implémentent l''interface AutoCloseable.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try-with-resources peut être utilisé avec plusieurs ressources en les déclarant dans la clause try.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try-with-resources remplace complètement le bloc finally pour fermer les ressources.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les exceptions lancées dans un try-with-resources sont cachées si une exception est déjà en cours de traitement.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-012',v_cert_id,v_theme_id,'Quelle est la différence entre une exception checked et une unchecked en Java ?','easy','SINGLE_CHOICE','Option A est correcte car les exceptions checked doivent être explicitement déclarées ou gérées. Option B est correcte car les exceptions unchecked, comme des erreurs de programmation, ne sont pas obligatoires à gérer explicitement. Option C est incorrecte car les exceptions checked ne sont pas des sous-classes de RuntimeException, mais plutôt des sous-classes d''Exception. Option D est incorrecte car elle combine des informations contradictoires.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les exceptions checked doivent être déclarées dans une clause throws ou gérées par un bloc catch.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les exceptions unchecked sont généralement des erreurs de programmation qui devraient être évitées.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les exceptions checked sont toujours des sous-classes de RuntimeException.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes les options ci-dessus.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-013',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le bloc finally dans un try-catch-finally :','hard','SINGLE_CHOICE','Option A est correcte car le bloc finally s''exécute toujours à la fin, même si aucune exception n''est lancée. Option B est correcte car le bloc finally peut être omis si aucun nettoyage n''est nécessaire. Option C est correcte car le bloc finally s''exécute après le bloc catch correspondant à l''exception. Option D est incorrecte car un bloc finally ne peut pas retourner une valeur, ce qui serait ambigu avec le code après la structure try-catch-finally.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc finally est toujours exécuté, même si une exception n''est pas lancée.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc finally peut être omis si aucun code de nettoyage n''est nécessaire.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc finally est exécuté après le bloc catch correspondant à l''exception lancée.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le bloc finally peut être utilisé pour retourner une valeur.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-014',v_cert_id,v_theme_id,'Quelle est la syntaxe correcte pour déclarer une ressource dans un try-with-resources ?','easy','SINGLE_CHOICE','Option A est correcte car elle déclare une ressource avec un constructeur. Option B est correcte car elle déclare plusieurs ressources, séparées par des points-virgules. Option C est incorrecte car elle manque les parenthèses dans l''initialisation des ressources. Option D est correcte car toutes les options précédentes sont syntaxiquement valides.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try (Resource r = new Resource()) { ... }',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try (Resource r = new Resource(); Resource s = new Resource()) { ... }',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try (Resource r = new Resource; Resource s = new Resource) { ... }',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes les options ci-dessus.',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-015',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''ordre d''exécution dans un try-catch-finally :','medium','SINGLE_CHOICE','Option A est correcte car le bloc finally s''exécute après le bloc try ou catch, peu importe si une exception est lancée. Option B est correcte car le bloc catch correspondant s''exécute avant le finally si une exception est lancée. Option C est incorrecte car un bloc finally peut contenir une déclaration return, mais cela peut entraîner des comportements inattendus. Option D est incorrecte car une exception lancée dans un bloc catch ne peut pas être capturée par un autre bloc catch, sauf si elle est relancée explicitement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc finally s''exécute toujours après le bloc try ou catch.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Si une exception est lancée dans le bloc try, le bloc catch correspondant s''exécute avant le finally.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc finally ne peut pas contenir de déclaration return.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Si une exception est lancée dans le bloc catch, elle peut être capturée par un autre bloc catch.',FALSE,3);
    END IF;
END $$;
