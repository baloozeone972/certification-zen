-- V6a_java21_02__seed_java21_part2.sql
-- java21: questions 151–300
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
    VALUES (uuid_generate_v4(),v_cert_id,'types_de_donn_es_et_wrappers','Types de données et Wrappers',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'poo_classes_h_ritage_polymorphisme','POO - Classes, Héritage, Polymorphisme',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'collections_et_g_n_riques','Collections et Génériques',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-012',v_cert_id,v_theme_id,'Quelle est la taille en bits d''un type ''long'' en Java ?','easy','SINGLE_CHOICE','long est un entier signé sur 64 bits. Plage de valeurs : -9,223,372,036,854,775,808 à 9,223,372,036,854,775,807.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','32',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','64',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-013',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion explicite entre types primitifs :','hard','SINGLE_CHOICE','Option A est correcte car Java effectue une conversion explicite entre des types numériques incompatibles, comme de ''double'' à ''int''. Option B est correcte car Java effectue une conversion explicite entre un type primitif et son wrapper correspondant, comme de ''int'' à ''Integer''. Option C est incorrecte car une conversion explicite entre un type primitif et une chaîne de caractères nécessite l''utilisation d''une méthode comme toString(). Option D est incorrecte car il n''existe aucune conversion explicite entre des types non compatibles comme ''int'' et ''boolean''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une conversion explicite peut se produire entre des types numériques incompatibles.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une conversion explicite peut se produire entre un type primitif et son wrapper correspondant.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une conversion explicite peut se produire entre un type primitif et une chaîne de caractères.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une conversion explicite peut se produire entre des types non compatibles comme ''int'' et ''boolean''.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-014',v_cert_id,v_theme_id,'Quelle est la valeur par défaut du type primitif ''boolean'' en Java ?','easy','SINGLE_CHOICE','false est la valeur par défaut du type primitif ''boolean'' en Java.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','true',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','false',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','null',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','0',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-015',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe ''Double'' en Java ?','medium','SINGLE_CHOICE','Option A est correcte car la méthode parseDouble() de la classe ''Double'' peut convertir une chaîne en double. Option B est incorrecte car la méthode valueOf() peut retourner une instance existante à partir d''un pool d''instances pour des valeurs entre -128 et 127. Option C est correcte car la méthode toString() de la classe ''Double'' peut convertir un double en chaîne. Option D est incorrecte car la méthode parseInt() est définie dans la classe ''Integer'', pas dans la classe ''Double''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La méthode parseDouble() peut convertir une chaîne en double.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La méthode valueOf() retourne toujours une nouvelle instance de ''Double''.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La méthode toString() peut convertir un double en chaîne.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La méthode parseInt() est définie dans la classe ''Double''.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-016',v_cert_id,v_theme_id,'Quelle est la taille en bits d''un type ''float'' en Java ?','easy','SINGLE_CHOICE','float est un type à virgule flottante signé sur 32 bits. Plage de valeurs : -3.4028235E+38 à 3.4028235E+38.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','32',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-017',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion entre types primitifs et leurs wrappers en Java :','medium','SINGLE_CHOICE','L''auto-boxing est une fonctionnalité Java qui convertit automatiquement un type primitif en son wrapper correspondant, donc l''option A est correcte. L''unboxing peut se produire avec des objets nuls, ce qui lève une NullPointerException, donc l''option B est incorrecte. La méthode parseXXX() permet effectivement de convertir une chaîne en type primitif, donc l''option C est correcte. La conversion entre types primitifs ne nécessite pas toujours une méthode explicite, car Java effectue des conversions implicites lorsqu''il est sûr de le faire, donc l''option D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''auto-boxing permet de convertir automatiquement un type primitif en son wrapper correspondant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''unboxing ne peut se produire qu''avec des objets non nuls.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','On peut utiliser la méthode parseXXX() des classes wrapper pour convertir une chaîne en type primitif.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La conversion entre types primitifs nécessite toujours une méthode explicite.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-018',v_cert_id,v_theme_id,'Quelle est la méthode correcte pour convertir un objet Integer en type primitif int ?','easy','SINGLE_CHOICE','La méthode correcte pour convertir un objet Integer en type primitif int est d''utiliser la méthode intValue() de l''objet Integer, donc l''option C est correcte. L''option A effectue une conversion de type et non une conversion d''un objet Integer à un int, donc elle est incorrecte. L''option B utilise parseInt() qui convertit une chaîne en int, pas un objet Integer, donc elle est incorrecte. L''option D utilise valueOf() qui retourne un objet Integer, pas un int primitif, donc elle est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','int value = (int) myInteger;',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','int value = Integer.parseInt(myInteger);',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','int value = myInteger.intValue();',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','int value = Integer.valueOf(myInteger);',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-019',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion entre types primitifs et leurs wrappers en Java :','medium','SINGLE_CHOICE','A est correct car Java permet l''autoboxing entre un type primitif et son wrapper. B est correct car pour utiliser une méthode qui attend un type primitif, il faut effectuer l''unboxing. C est incorrect car certains types de conversions peuvent nécessiter des cast explicites ou lever des exceptions (par exemple, conversion d''un Float vers un Integer). D est incorrect car les méthodes spécifiques pour la conversion sont généralement des méthodes statiques dans les classes de wrappers, mais elles ne couvrent pas toutes les conversions possibles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La conversion automatique (autoboxing) est possible entre un type primitif et son wrapper correspondant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La conversion manuelle (unboxing) est nécessaire pour utiliser une méthode qui attend un type primitif.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','On peut convertir n''importe quel type primitif en son wrapper correspondant sans problème.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Il existe des méthodes spécifiques dans les classes de wrappers pour effectuer des conversions.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-020',v_cert_id,v_theme_id,'Quelle est la classe wrapper correspondant au type primitif ''int'' en Java ?','easy','SINGLE_CHOICE','A est correct car la classe wrapper correspondant au type primitif ''int'' en Java est Integer. Les autres options ne sont pas des classes wrapper valides pour le type ''int''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Integer',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Int',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','intWrapper',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Integral',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-021',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la gestion de mémoire pour les types primitifs et leurs wrappers en Java :','hard','SINGLE_CHOICE','A est correct car les types primitifs sont généralement stockés sur la pile (stack). B est correct car les wrappers, étant des objets, sont stockés sur le tas (heap). C est incorrect car les types primitifs ne peuvent pas être null. D est correct car les wrappers, étant des objets, peuvent être null.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les types primitifs sont stockés sur la pile (stack).',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les wrappers sont stockés sur le tas (heap).',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les types primitifs peuvent être null.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les wrappers peuvent être null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-022',v_cert_id,v_theme_id,'Quelle méthode doit être utilisée pour convertir une chaîne de caractères en un type primitif ''int'' en Java ?','medium','SINGLE_CHOICE','A est correct car la méthode parseInt() doit être utilisée pour convertir une chaîne de caractères en un type primitif ''int''. Les autres options ne sont pas des méthodes valides pour cette conversion.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','parseInt()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','toInteger()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','intParse()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','valueOf()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-023',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''auto-boxing et l''unboxing en Java :','easy','SINGLE_CHOICE','A est correct car l''auto-boxing convertit automatiquement un type primitif en son wrapper correspondant. B est correct car l''unboxing convertit automatiquement un wrapper en son type primitif correspondant. C est incorrect car l''auto-boxing et l''unboxing peuvent lever des exceptions, par exemple lors d''une conversion non valide. D est correct car les conversions implicites entre types primitifs sont possibles sans auto-boxing ou unboxing.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''auto-boxing convertit automatiquement un type primitif en son wrapper correspondant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''unboxing convertit automatiquement un wrapper en son type primitif correspondant.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''auto-boxing et l''unboxing sont toujours sans risque en termes d''exceptions.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les conversions implicites entre types primitifs sont possibles sans auto-boxing ou unboxing.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-024',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion entre types primitifs et leurs wrappers en Java :','medium','SINGLE_CHOICE','L''auto-boxing et l''unboxing sont des mécanismes de conversion entre types primitifs et leurs wrappers en Java. La méthode parse() dans les classes wrapper convertit une chaîne en un type primitif, tandis que la méthode toString() convertit un objet wrapper en une chaîne. L''option D est incorrecte car toString() n''est pas utilisée pour convertir un type primitif en une chaîne.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''auto-boxing permet de convertir automatiquement un type primitif en son wrapper correspondant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''unboxing est la conversion automatique d''un objet wrapper en type primitif.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La méthode parse() dans les classes wrapper convertit une chaîne en un type primitif.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La méthode toString() dans les classes wrapper convertit un type primitif en une chaîne.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-025',v_cert_id,v_theme_id,'Quelle est la taille en bits d''un type ''int'' en Java ?','easy','SINGLE_CHOICE','int est un entier signé sur 32 bits. Plage de valeurs : -2,147,483,648 à 2,147,483,647.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','32',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-026',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant les wrappers en Java ?','medium','SINGLE_CHOICE','Les wrappers sont effectivement des classes qui encapsulent les types primitifs, permettant ainsi de stocker des valeurs nulles. Chaque type primitif a un wrapper correspondant dans le package java.lang, mais ce n''est pas toujours vrai pour tous les types primitifs. Les wrappers ne sont pas toujours plus rapides que les types primitifs, car ils comportent des coûts supplémentaires en termes de mémoire et de performances.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les wrappers sont des classes qui encapsulent les types primitifs.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Chaque type primitif a un wrapper correspondant dans le package java.lang.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les wrappers peuvent être utilisés pour stocker des valeurs nulles.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les wrappers sont toujours plus rapides que les types primitifs.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-027',v_cert_id,v_theme_id,'Quelle exception est levée lorsqu''on essaie de convertir une chaîne non numérique en un type primitif avec la méthode parse() ?','hard','SINGLE_CHOICE','NumberFormatException est levée lorsqu''une chaîne ne peut pas être convertie en un type numérique avec la méthode parse(). Les autres exceptions ne sont pas liées à cette conversion spécifique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','NumberFormatException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','NullPointerException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IllegalArgumentException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassCastException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-028',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la méthode valueOf() dans les classes wrapper en Java :','medium','SINGLE_CHOICE','La méthode valueOf() peut retourner une nouvelle instance de l''objet wrapper ou utiliser un pool d''objets pour des valeurs spécifiques, ce qui peut améliorer les performances. La méthode valueOf() est plus performante que l''auto-boxing pour des valeurs spécifiques car elle utilise un pool d''objets. L''option D est incorrecte car valueOf() peut être utilisée avec des types primitifs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La méthode valueOf() retourne une nouvelle instance de l''objet wrapper.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La méthode valueOf() peut utiliser un pool d''objets pour des valeurs spécifiques.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La méthode valueOf() est plus performante que l''auto-boxing pour des valeurs spécifiques.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La méthode valueOf() ne peut pas être utilisée avec des types primitifs.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-029',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion entre types primitifs et leurs wrappers en Java :','medium','SINGLE_CHOICE','L''auto-boxing et le dé-boxing sont des mécanismes permettant la conversion automatique entre types primitifs et leurs wrappers en Java. La conversion entre types primitifs nécessite parfois une méthode explicite, mais pas toujours. Les wrappers peuvent être utilisés dans des structures de contrôle comme les boucles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''auto-boxing permet de convertir automatiquement un type primitif en son wrapper correspondant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le dé-boxing permet de convertir automatiquement un wrapper en type primitif correspondant.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La conversion entre types primitifs nécessite toujours une méthode explicite de conversion.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les wrappers ne peuvent pas être utilisés dans des structures de contrôle comme les boucles.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-030',v_cert_id,v_theme_id,'Quelle est la taille en bits d''un type ''int'' en Java ?','easy','SINGLE_CHOICE','int est un entier signé sur 32 bits. Plage de valeurs : -2,147,483,648 à 2,147,483,647.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','32',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-031',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''utilisation des wrappers en Java ?','hard','SINGLE_CHOICE','Les wrappers permettent de stocker des valeurs primitives dans des collections qui ne peuvent contenir que des objets. Les wrappers peuvent être utilisés pour effectuer des opérations arithmétiques, mais cela n''est généralement pas recommandé car cela peut entraîner une perte de performances. Les wrappers peuvent être nuls, ce qui n''est pas possible avec les types primitifs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les wrappers permettent de stocker des valeurs primitives dans des collections.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les wrappers peuvent être utilisés pour effectuer des opérations arithmétiques.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les wrappers sont toujours plus rapides que les types primitifs en termes de performances.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les wrappers peuvent être nuls, ce qui n''est pas possible avec les types primitifs.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-032',v_cert_id,v_theme_id,'Quelle est la méthode utilisée pour convertir un type primitif en son wrapper correspondant ?','medium','SINGLE_CHOICE','L''auto-boxing est la méthode utilisée pour convertir automatiquement un type primitif en son wrapper correspondant.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Auto-boxing',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Boxing explicite',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Conversion implicite',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Dé-boxing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-033',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion entre types primitifs en Java :','hard','SINGLE_CHOICE','La conversion implicite peut entraîner une perte de données si le type cible ne peut pas contenir la valeur du type source. La conversion explicite nécessite parfois une méthode de conversion, mais pas toujours. Les conversions entre types primitifs peuvent entraîner une perte de données, donc il n''est pas toujours possible de les effectuer sans risque. Les conversions entre types primitifs peuvent être effectuées avec un cast.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La conversion implicite peut entraîner une perte de données.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La conversion explicite nécessite toujours une méthode de conversion.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les conversions entre types primitifs peuvent être effectuées sans risque de perte de données.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les conversions entre types primitifs peuvent être effectuées avec un cast.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-034',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion entre types primitifs et leurs wrappers en Java :','medium','SINGLE_CHOICE','L''auto-boxing et l''auto-unboxing sont des fonctionnalités Java qui permettent la conversion implicite entre types primitifs et leurs wrappers correspondants. La conversion entre types primitifs nécessite parfois un cast explicite, mais pas toujours. Les wrappers peuvent être utilisés dans des structures de données qui nécessitent des types primitifs, car Java effectue automatiquement l''auto-unboxing.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''auto-boxing permet la conversion implicite d''un type primitif à son wrapper correspondant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''auto-unboxing permet la conversion implicite d''un wrapper à son type primitif correspondant.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La conversion entre types primitifs nécessite toujours l''utilisation d''un cast explicite.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les wrappers ne peuvent pas être utilisés dans des structures de données qui nécessitent des types primitifs.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-035',v_cert_id,v_theme_id,'Quelle est la taille en bits d''un type ''int'' en Java ?','easy','SINGLE_CHOICE','int est un entier signé sur 32 bits. La plage de valeurs est -2,147,483,648 à 2,147,483,647.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','32',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-036',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la conversion entre types primitifs en Java ?','hard','SINGLE_CHOICE','La conversion d''un double à un float peut entraîner une perte de précision car un float a moins de bits pour représenter la partie décimale. La conversion d''un int à un short nécessite parfois un cast explicite, mais pas toujours si la valeur est dans la plage d''un short. La conversion d''un byte à un int ne peut pas entraîner une perte de précision car un int a plus de bits. La conversion d''un long à un int nécessite toujours un cast explicite car un long a plus de bits qu''un int.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La conversion d''un double à un float peut entraîner une perte de précision.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La conversion d''un int à un short nécessite toujours un cast explicite.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La conversion d''un byte à un int peut entraîner une perte de précision.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La conversion d''un long à un int nécessite toujours un cast explicite.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-037',v_cert_id,v_theme_id,'Quelle est la méthode correcte pour convertir une chaîne en un entier en Java ?','medium','SINGLE_CHOICE','La méthode correcte pour convertir une chaîne en un entier en Java est Integer.parseInt().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Integer.parseInt()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','String.toInteger()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Integer.valueOf()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','String.toInt()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-038',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''utilisation des wrappers en Java :','hard','SINGLE_CHOICE','Les wrappers peuvent être utilisés dans des structures de données qui nécessitent des objets, comme les collections. Les wrappers permettent la conversion implicite entre types primitifs et leurs wrappers correspondants grâce à l''auto-boxing. Les wrappers ne sont pas toujours plus rapides que les types primitifs, car ils ont une surcharge mémoire. Les wrappers peuvent être null, ce qui n''est pas possible avec les types primitifs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les wrappers peuvent être utilisés dans des structures de données qui nécessitent des objets.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les wrappers permettent la conversion implicite entre types primitifs et leurs wrappers correspondants.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les wrappers sont toujours plus rapides que les types primitifs.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les wrappers peuvent être null.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-039',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la conversion entre types primitifs et leurs wrappers en Java :','medium','SINGLE_CHOICE','L''auto-boxing et le dé-boxing sont des mécanismes automatisés en Java pour convertir entre types primitifs et leurs wrappers. L''option A est correcte car elle décrit l''auto-boxing, B est correcte car elle décrit le dé-boxing. L''option C est correcte car parse() est une méthode des wrappers qui permet de convertir une chaîne en type primitif. L''option D est incorrecte car valueOf() est effectivement une méthode des wrappers qui permet de convertir une chaîne en type primitif.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''auto-boxing convertit automatiquement un type primitif en son wrapper correspondant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le dé-boxing convertit automatiquement un wrapper en son type primitif correspondant.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','On peut utiliser la méthode parse() des wrappers pour convertir une chaîne en type primitif.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','On ne peut pas utiliser la méthode valueOf() des wrappers pour convertir une chaîne en type primitif.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-TDD-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='types_de_donn_es_et_wrappers' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-TDD-040',v_cert_id,v_theme_id,'Quelle est la taille en bits d''un type ''int'' en Java ?','easy','SINGLE_CHOICE','int est un entier signé sur 32 bits. Sa plage de valeurs va de -2,147,483,648 à 2,147,483,647.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','32',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-001',v_cert_id,v_theme_id,'Qu''est-ce que l''héritage en Java ?','easy','SINGLE_CHOICE','Java supporte l''héritage simple de classes (une seule classe parente) mais l''héritage multiple d''interfaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe peut hériter de plusieurs classes parentes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe peut hériter d''une seule classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe peut hériter d''une interface uniquement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''héritage n''existe pas en Java',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-002',v_cert_id,v_theme_id,'Que signifie ''extends'' en Java ?','easy','SINGLE_CHOICE','extends est utilisé pour l''héritage de classes. Une classe étend une autre classe avec ''extends''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Implémente une interface',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Hérite d''une classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Crée une nouvelle instance',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Déclare une méthode abstraite',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-003',v_cert_id,v_theme_id,'Que signifie ''implements'' en Java ?','easy','SINGLE_CHOICE','implements permet à une classe d''implémenter une ou plusieurs interfaces. La classe doit fournir le corps de toutes les méthodes abstraites.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Hérite d''une classe',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Implémente une ou plusieurs interfaces',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Crée une méthode abstraite',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Déclare une variable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-004',v_cert_id,v_theme_id,'Qu''est-ce que le polymorphisme en Java ?','easy','SINGLE_CHOICE','Le polymorphisme permet à une référence de type parent de désigner un objet de type enfant. Ex: Animal a = new Chien();','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La capacité d''une classe à avoir plusieurs constructeurs',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La capacité d''un objet à prendre plusieurs formes',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La capacité d''une méthode à s''appeler elle-même',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La capacité d''une variable à changer de type',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-005',v_cert_id,v_theme_id,'Qu''est-ce que l''encapsulation ?','easy','SINGLE_CHOICE','L''encapsulation consiste à déclarer les champs private et fournir des méthodes public (getters/setters) pour y accéder.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Cacher les détails d''implémentation et exposer une interface publique',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Mettre toutes les méthodes dans une seule classe',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser des classes internes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Créer des objets immuables',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-006',v_cert_id,v_theme_id,'Que produit ''super()'' dans un constructeur ?','easy','SINGLE_CHOICE','super() appelle le constructeur de la classe parente. Si non spécifié, le constructeur par défaut du parent est appelé automatiquement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Appelle le constructeur de la classe courante',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Appelle le constructeur de la classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Appelle une méthode statique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Crée une nouvelle instance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-007',v_cert_id,v_theme_id,'Que produit ''this()'' dans un constructeur ?','easy','SINGLE_CHOICE','this() permet d''appeler un autre constructeur de la même classe. Doit être la première instruction du constructeur.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Appelle un autre constructeur de la même classe',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Appelle le constructeur parent',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Retourne l''instance courante',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Crée une copie de l''objet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-008',v_cert_id,v_theme_id,'Qu''est-ce qu''une classe abstraite ?','easy','SINGLE_CHOICE','Une classe abstraite ne peut pas être instanciée avec ''new''. Elle peut contenir des méthodes abstraites et concrètes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe qui ne peut pas être étendue',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe qui ne peut pas être instanciée directement',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe qui n''a pas de méthodes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe qui est automatiquement final',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-009',v_cert_id,v_theme_id,'Qu''est-ce qu''une méthode abstraite ?','easy','SINGLE_CHOICE','Une méthode abstraite n''a pas de corps (seulement signature) et doit être implémentée par les classes concrètes qui étendent la classe abstraite.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une méthode sans corps (implémentation)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une méthode avec le mot-clé ''abstract''',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une méthode qui doit être implémentée par les sous-classes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-010',v_cert_id,v_theme_id,'Qu''est-ce qu''une interface en Java ?','easy','SINGLE_CHOICE','Une interface définit un ensemble de méthodes (par défaut abstract) qu''une classe implémentant l''interface doit fournir.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe qui ne peut pas avoir de méthodes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Un contrat définissant des méthodes qu''une classe doit implémenter',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe qui ne peut pas être instanciée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Un type de variable spécial',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-011',v_cert_id,v_theme_id,'Une interface peut-elle contenir des champs ?','easy','SINGLE_CHOICE','Les champs d''une interface sont implicitement public, static et final (constantes).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, seulement des méthodes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, mais ils sont automatiquement public static final',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, comme n''importe quelle classe',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, mais uniquement des constantes primitives',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-012',v_cert_id,v_theme_id,'Depuis Java 8, une interface peut contenir des méthodes avec implémentation. Comment s''appellent-elles ?','easy','SINGLE_CHOICE','Java 8 a introduit les méthodes default (avec mot-clé default) et les méthodes static dans les interfaces. Java 9 a ajouté les méthodes private.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Méthodes abstraites',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Méthodes statiques et méthodes default',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Méthodes privées',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Méthodes final',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-013',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Parent { void show() { System.out.print("Parent"); } }
class Child extends Parent { void show() { System.out.print("Child"); } }
Parent p = new Child();
p.show();
```','medium','SINGLE_CHOICE','C''est du polymorphisme. La méthode appelée est celle de l''objet réel (Child), pas celle du type de référence (Parent).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Parent',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Child',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassCastException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-014',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Parent { static void show() { System.out.print("Parent"); } }
class Child extends Parent { static void show() { System.out.print("Child"); } }
Parent p = new Child();
p.show();
```','medium','SINGLE_CHOICE','Les méthodes static sont liées à la compilation (early binding). C''est la méthode de la classe du type de référence (Parent) qui est appelée, pas celle de l''objet.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Parent',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Child',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassCastException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-015',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class A { int x = 5; }
class B extends A { int x = 10; }
A obj = new B();
System.out.println(obj.x);
```','medium','SINGLE_CHOICE','Les variables (champs) n''ont pas de polymorphisme. C''est la variable du type de référence (A.x) qui est utilisée, même si l''objet est de type B.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','5',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','10',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','0',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-016',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Animal {}
class Chien extends Animal {}
Animal a = new Chien();
Chien c = (Chien) a;
System.out.println(c instanceof Chien);
```','medium','SINGLE_CHOICE','Le cast est valide car a est bien un Chien. instanceof retourne true.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','true',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','false',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassCastException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-017',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Animal {}
class Chien extends Animal {}
Animal a = new Animal();
Chien c = (Chien) a;
```','medium','SINGLE_CHOICE','Le cast est syntaxiquement valide (compilation OK). Mais a n''est pas un Chien, donc ClassCastException à l''exécution.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Compilation OK, runtime ClassCastException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Erreur de compilation',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Compilation OK, runtime OK',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassNotFoundException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-018',v_cert_id,v_theme_id,'Que fait ''instanceof'' ?','medium','SINGLE_CHOICE','instanceof retourne true si l''objet est une instance de la classe ou implémente l''interface spécifiée. Ex: obj instanceof String.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Crée une nouvelle instance',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Vérifie si un objet est d''un certain type',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Convertit un objet en un autre type',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Compare deux objets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-019',v_cert_id,v_theme_id,'Quel modificateur permet à une classe d''être héritée mais pas instanciée directement ?','easy','SINGLE_CHOICE','abstract permet l''héritage mais empêche l''instanciation directe. final fait l''inverse : empêche l''héritage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','abstract',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','final',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','static',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','private',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-020',v_cert_id,v_theme_id,'Quel modificateur empêche une méthode d''être surchargée (override) ?','easy','SINGLE_CHOICE','final empêche la surcharge (override). Une méthode final ne peut pas être redéfinie dans les sous-classes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','static',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','final',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','private',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','abstract',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-021',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Parent {
    final void show() { System.out.print("Parent"); }
}
class Child extends Parent {
    void show() { System.out.print("Child"); }
}
```','medium','SINGLE_CHOICE','Une méthode déclarée final dans la classe parente ne peut pas être surchargée (override) par la classe enfant.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Compilation OK, affiche Child',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Erreur compilation : ne peut pas override méthode final',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Compilation OK, affiche Parent',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Runtime error',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-022',v_cert_id,v_theme_id,'Une classe peut-elle implémenter plusieurs interfaces ?','medium','SINGLE_CHOICE','Java permet l''héritage multiple d''interfaces. Une classe peut implémenter autant d''interfaces que nécessaire.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, seulement une',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, sans limite',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, mais uniquement si elles n''ont pas de conflits',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, jusqu''à 3 interfaces',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-023',v_cert_id,v_theme_id,'Que se passe-t-il si une classe implémente deux interfaces avec la même méthode default ?','hard','SINGLE_CHOICE','Conflit de méthode default : la classe doit fournir sa propre implémentation pour lever l''ambiguïté, ou utiliser super pour choisir.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Erreur de compilation automatique',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La classe doit override la méthode',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La première interface gagne',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La méthode est ignorée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-024',v_cert_id,v_theme_id,'Comment appeler une méthode default spécifique d''une interface en cas de conflit ?','hard','SINGLE_CHOICE','Syntaxe : InterfaceName.super.method() permet d''appeler la méthode default spécifique d''une interface en cas de conflit.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','InterfaceName.super.method()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','super.InterfaceName.method()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','InterfaceName.method()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','C''est impossible',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-025',v_cert_id,v_theme_id,'Quelle est la classe parente de toutes les classes en Java ?','easy','SINGLE_CHOICE','Object est la classe racine de toute la hiérarchie Java. Toute classe étend implicitement Object (ou explicitement via extends).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Main',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Class',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Object',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Root',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-026',v_cert_id,v_theme_id,'Quelles méthodes la classe Object fournit-elle ?','easy','SINGLE_CHOICE','Object fournit : toString(), equals(), hashCode(), clone(), finalize(), getClass(), wait(), notify(), notifyAll().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','toString(), equals(), hashCode()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','clone(), finalize(), wait(), notify()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','getClass()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-027',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class A {}
class B extends A {}
System.out.println(new B() instanceof A);
```','medium','SINGLE_CHOICE','B est une sous-classe de A, donc une instance de B est aussi une instance de A. instanceof retourne true.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','true',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','false',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ClassCastException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-028',v_cert_id,v_theme_id,'Que produit ce code ?
```java
String s = null;
System.out.println(s instanceof String);
```','medium','SINGLE_CHOICE','instanceof retourne false pour une référence null. Aucune exception n''est levée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','true',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','false',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NullPointerException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-029',v_cert_id,v_theme_id,'Quelle est la règle de visibilité pour override une méthode ?','medium','SINGLE_CHOICE','Une méthode override peut avoir une accessibilité plus large (ex: protected → public) mais pas plus restrictive (public → private).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le modificateur doit être identique',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le modificateur peut être plus accessible (moins restrictif)',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le modificateur peut être moins accessible (plus restrictif)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le modificateur n''a pas d''importance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-030',v_cert_id,v_theme_id,'Quelle est la règle pour les types de retour lors d''un override ?','hard','SINGLE_CHOICE','Java supporte les types de retour covariants. Une méthode override peut retourner un sous-type du type de retour de la méthode parente.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Doit être identique',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Peut être un sous-type (covariant return type)',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Peut être un super-type',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Peut être différent si méthodes static',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-031',v_cert_id,v_theme_id,'Quelle annotation recommande-t-on pour indiquer qu''une méthode override une méthode parente ?','medium','SINGLE_CHOICE','@Override est une annotation qui indique qu''une méthode override une méthode de la superclasse. Le compilateur vérifie que c''est bien le cas.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','@Override',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','@Overload',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','@Inherit',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','@Extends',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-032',v_cert_id,v_theme_id,'Une classe interne (inner class) peut-elle accéder aux membres private de sa classe englobante ?','easy','SINGLE_CHOICE','Les classes internes non-static ont accès à tous les membres (y compris private) de leur classe englobante.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, jamais',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, toujours',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, uniquement si déclarée static',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, uniquement si la classe englobante est public',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-033',v_cert_id,v_theme_id,'Qu''est-ce qu''une classe anonyme en Java ?','medium','SINGLE_CHOICE','Une classe anonyme est déclarée et instanciée en une seule expression. Elle est souvent utilisée pour implémenter des interfaces ou étendre des classes à la volée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe sans nom, définie à l''instanciation',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe qui ne peut pas être instanciée',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe dont le nom est inconnu à la compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe qui n''a pas de constructeur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-034',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Outer {
    private int x = 10;
    class Inner {
        void show() { System.out.println(x); }
    }
}
new Outer().new Inner().show();
```','medium','SINGLE_CHOICE','La classe interne non-static accède au champ private x de la classe englobante. L''instanciation nécessite une instance d''Outer.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','10',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Erreur compilation',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','0',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-035',v_cert_id,v_theme_id,'Comment instancier une classe interne static (nested static class) ?','medium','SINGLE_CHOICE','Une classe interne static (nested class) s''instancie comme une classe normale : new Outer.Inner(). Pas besoin d''instance d''Outer.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','new Outer.Inner()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','new Outer().new Inner()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','new Outer.Inner() sans instance d''Outer',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-036',v_cert_id,v_theme_id,'Que sont les ''sealed classes'' introduites en Java 17 ?','hard','SINGLE_CHOICE','Les sealed classes (Java 17) permettent de spécifier explicitement quelles classes peuvent les étendre, avec permits. Ex: sealed class A permits B, C {}','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Des classes qui ne peuvent pas être étendues',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Des classes qui restreignent quelles sous-classes peuvent les étendre',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Des classes qui sont automatiquement final',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Des classes qui ne peuvent être utilisées que dans un module',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-037',v_cert_id,v_theme_id,'Quel mot-clé est utilisé avec les sealed classes pour autoriser l''héritage ?','hard','SINGLE_CHOICE','permits est utilisé dans la déclaration d''une sealed class pour lister les classes autorisées à l''étendre.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','extends',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','implements',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','permits',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','allows',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-038',v_cert_id,v_theme_id,'Quelles sont les trois permissions pour une sous-classe d''une sealed class ?','hard','SINGLE_CHOICE','Une sous-classe d''une sealed class doit être : final (ne peut plus être étendue), sealed (continue la restriction), ou non-sealed (permet l''héritage libre).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','final, sealed, non-sealed',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','public, private, protected',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','static, final, abstract',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','extends, implements, permits',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-039',v_cert_id,v_theme_id,'Qu''est-ce qu''un constructeur en Java ?','easy','SINGLE_CHOICE','Un constructeur a le même nom que la classe, pas de type de retour, et est appelé automatiquement lors de l''instanciation avec new.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une méthode qui s''appelle comme la classe et n''a pas de type de retour',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une méthode qui initialise l''objet lors de sa création',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une méthode appelée automatiquement par new',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-040',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class A {
    A() { System.out.print("A"); }
}
class B extends A {
    B() { System.out.print("B"); }
}
new B();
```','medium','SINGLE_CHOICE','Le constructeur de B appelle d''abord implicitement super() (constructeur de A), puis exécute son corps. Donc A puis B.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AB',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BA',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','A',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','B',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-041',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Parent {
    Parent(int x) { System.out.print(x); }
}
class Child extends Parent {
    Child() { System.out.print("Child"); }
}
```','medium','SINGLE_CHOICE','Parent n''a pas de constructeur par défaut (sans paramètre). Child tente d''appeler super() implicitement → erreur de compilation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Compilation OK, affiche Child',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Erreur compilation : constructeur par défaut Parent inexistant',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Runtime error',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Affiche 0Child',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-042',v_cert_id,v_theme_id,'Comment corriger l''erreur précédente ?','medium','SINGLE_CHOICE','Soit ajouter un constructeur sans paramètre à Parent, soit appeler explicitement super(x) dans le constructeur de Child.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ajouter Parent() {} dans la classe Parent',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Appeler super(x) dans le constructeur de Child',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','A ou B',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Rendre Parent abstract',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-043',v_cert_id,v_theme_id,'Un constructeur peut-il être private ?','medium','SINGLE_CHOICE','Un constructeur private empêche l''instanciation depuis l''extérieur de la classe, utilisé dans le pattern Singleton ou les classes utilitaires.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, jamais',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, pour le pattern Singleton',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, mais seulement dans les enums',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, mais la classe devient abstraite',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-044',v_cert_id,v_theme_id,'Que sont les records en Java (introduits en Java 14/16) ?','easy','SINGLE_CHOICE','Les records sont des classes immuables qui génèrent automatiquement constructeur, accesseurs, equals(), hashCode() et toString(). Ex: record Point(int x, int y) {}','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Des classes immuables pour le transport de données',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Des classes avec des constructeurs automatiques',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Des classes avec equals(), hashCode(), toString() générés',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-045',v_cert_id,v_theme_id,'Quelle est la syntaxe correcte pour déclarer un record ?','medium','SINGLE_CHOICE','Un record se déclare avec ''record Nom(composants)''. Les modificateurs d''accès sont autorisés. Les composants sont automatiquement des champs final.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','record Point(int x, int y) {}',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','public record Point(int x, int y) {}',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','record Point { int x; int y; }',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-046',v_cert_id,v_theme_id,'Un record peut-il étendre une autre classe ?','medium','SINGLE_CHOICE','Les records étendent implicitement java.lang.Record et ne peuvent pas étendre d''autre classe. Ils peuvent implémenter des interfaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui, comme une classe normale',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non, les records étendent implicitement java.lang.Record',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, uniquement des classes abstraites',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, avec le mot-clé extends',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-047',v_cert_id,v_theme_id,'Que sont les ''pattern matching for instanceof'' (Java 16/17) ?','hard','SINGLE_CHOICE','Pattern matching permet de déclarer une variable directement dans l''instanceof. Ex: if (obj instanceof String s) utilise s directement sans cast.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','instanceof avec déclaration de variable',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','if (obj instanceof String s) { s.length(); }',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Simplifie le cast après instanceof',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-048',v_cert_id,v_theme_id,'Que produit ce code avec Java 21 ?
```java
Object obj = "Hello";
if (obj instanceof String s && s.length() > 0) {
    System.out.println(s.toLowerCase());
}
```','medium','SINGLE_CHOICE','Pattern matching : s est déclarée et utilisable dans l''expression. La variable s est en scope dans la clause && et le bloc if.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','hello',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Hello',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NullPointerException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-049',v_cert_id,v_theme_id,'Que sont les ''switch pattern matching'' (Java 21) ?','hard','SINGLE_CHOICE','Java 21 généralise switch pour utiliser des patterns : case String s -> s.length(), case Integer i -> i, case Point(int x, int y) -> x+y.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Switch avec des patterns au lieu de constantes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Switch sur le type d''un objet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permet de déstructurer des records',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-050',v_cert_id,v_theme_id,'Qu''est-ce qu''une ''enum'' en Java ?','hard','SINGLE_CHOICE','enum est un type spécial pour définir un ensemble fixe de constantes. C''est une classe qui étend java.lang.Enum, peut avoir des champs, constructeurs et méthodes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Un type spécial pour des constantes nommées',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe qui étend Enum',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Peut avoir des champs et méthodes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-051') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-051',v_cert_id,v_theme_id,'Peut-on ajouter des méthodes à une enum ?','medium','SINGLE_CHOICE','Les enums peuvent avoir des constructeurs, des champs et des méthodes. Chaque constante peut même avoir sa propre implémentation de méthode.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, les enums ne peuvent avoir que des constantes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, comme une classe normale',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, mais seulement des méthodes abstraites',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Oui, mais seulement des méthodes static',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-052') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-052',v_cert_id,v_theme_id,'Que produit ''DayOfWeek.MONDAY.ordinal()'' ?','medium','SINGLE_CHOICE','ordinal() retourne la position de la constante dans la déclaration (commence à 0). À utiliser avec précaution car l''ordre peut changer.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le nom de la constante',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La position de la constante (0 pour la première)',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Un hashcode',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La valeur numérique associée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-053') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-053',v_cert_id,v_theme_id,'Que produit ''DayOfWeek.MONDAY.name()'' ?','medium','SINGLE_CHOICE','name() retourne le nom exact de la constante tel que déclaré. La méthode toString() peut être override pour un affichage différent.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','"MONDAY"',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','monday',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','1',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''instance elle-même',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-054') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-054',v_cert_id,v_theme_id,'Comment obtenir toutes les constantes d''une enum ?','medium','SINGLE_CHOICE','La méthode statique values() retourne un tableau contenant toutes les constantes de l''enum dans l''ordre de déclaration.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Enum.values()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Enum.constants()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Enum.list()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Enum.all()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-055') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-055',v_cert_id,v_theme_id,'Qu''est-ce que le ''method overloading'' ?','medium','SINGLE_CHOICE','La surcharge (overloading) permet d''avoir plusieurs méthodes avec le même nom mais des signatures différentes (type, nombre, ordre des paramètres).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Plusieurs méthodes avec le même nom mais des paramètres différents',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Redéfinir une méthode dans une sous-classe',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une méthode qui s''appelle elle-même',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une méthode avec trop de paramètres',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-056') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-056',v_cert_id,v_theme_id,'Qu''est-ce que le ''method overriding'' ?','medium','SINGLE_CHOICE','La surcharge (overriding) permet à une sous-classe de fournir une implémentation spécifique d''une méthode déjà définie dans la classe parente.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Redéfinir une méthode dans une sous-classe avec la même signature',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Créer plusieurs méthodes avec le même nom',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Appeler une méthode depuis une autre classe',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Définir une méthode comme static',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-057') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-057',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class A { void m(int x) { System.out.print("A"); } }
class B extends A { void m(long x) { System.out.print("B"); } }
B b = new B();
b.m(5);
```','medium','SINGLE_CHOICE','Ce n''est pas un override (signature différente : int vs long). C''est un overload. Le compilateur choisit la méthode la plus spécifique : m(long) avec promotion de int à long.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','A',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','B',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','AB',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-058') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-058',v_cert_id,v_theme_id,'Que produit ce code ?
```java
class Parent { void m(int... x) { System.out.print("Parent"); } }
class Child extends Parent { void m(int x) { System.out.print("Child"); } }
Parent p = new Child();
p.m(5);
```','hard','SINGLE_CHOICE','La signature est différente : varargs vs int. Ce n''est pas un override mais un overload. La méthode appelée dépend du type de référence (Parent).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Parent',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Child',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur compilation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ChildParent',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-059') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-059',v_cert_id,v_theme_id,'Que sont les ''value classes'' (projet Valhalla, prévisualisation Java 21) ?','hard','SINGLE_CHOICE','Les value classes (prévisualisation Java 21) permettent de créer des types personnalisés avec sémantique par valeur, sans allocation sur le tas dans certains cas.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Des classes avec sémantique par valeur plutôt que par référence',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Des classes immuables',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Des classes qui ne peuvent pas être null',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-03-060') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-03-060',v_cert_id,v_theme_id,'Qu''est-ce qu''un ''sealed interface'' ?','hard','SINGLE_CHOICE','Comme les sealed classes, une sealed interface restreint quelles classes ou interfaces peuvent l''implémenter/étendre, avec le mot-clé permits.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une interface qui ne peut être implémentée que par certaines classes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une interface sans méthodes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une interface qui étend seulement des interfaces sealed',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une interface avec une seule méthode',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-001',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encapsulation en Java :','medium','SINGLE_CHOICE','L''encapsulation en Java permet de protéger les données et de modifier leur accès, généralement en utilisant des variables privées et des méthodes publiques pour y accéder. L''option B est incorrecte car l''encapsulation n''est pas uniquement réalisée par des méthodes publiques, mais aussi par le contrôle d''accès aux attributs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''encapsulation permet de protéger les données.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''encapsulation est réalisée en utilisant des méthodes publiques.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''encapsulation permet de modifier l''accès aux attributs d''une classe.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''encapsulation est souvent implémentée en utilisant des variables privées.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-002',v_cert_id,v_theme_id,'Quelle est la différence entre une classe et un objet en Java ?','easy','SINGLE_CHOICE','Une classe définit les propriétés et les méthodes, tandis qu''un objet est une instance de cette classe. L''option A est incorrecte car une classe n''est pas une instance d''un objet, mais elle peut créer des objets. L''option B est incorrecte car un objet n''est pas une définition, mais une instance. L''option D est incorrecte car un objet n''est pas un type de classe, mais une instance d''une classe.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe est une instance d''un objet.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Un objet est une définition de données et de comportements.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe définit les propriétés et les méthodes, tandis qu''un objet est une instance de cette classe.',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Un objet est un type de classe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-003',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''héritage en Java ?','hard','SINGLE_CHOICE','Java ne supporte pas l''héritage multiple, mais il permet à une classe d''implémenter plusieurs interfaces. L''héritage est utilisé pour modifier le comportement d''une classe en redéfinissant ses méthodes. L''option B est incorrecte car une classe ne peut hériter d''une seule classe mère. L''option C est incorrecte car une classe ne peut hériter d''une seule classe, mais elle peut implémenter plusieurs interfaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Java ne supporte pas l''héritage multiple.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''héritage permet à une classe de posséder plusieurs classes mères.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe peut hériter d''une interface et d''une classe.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''héritage est utilisé pour modifier le comportement d''une classe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-004',v_cert_id,v_theme_id,'Quelle est la méthode utilisée pour appeler une méthode de la classe parente en Java ?','easy','SINGLE_CHOICE','La méthode utilisée pour appeler une méthode de la classe parente en Java est super.methodName(). L''option B est incorrecte car il n''y a pas de mot-clé ''parent''. L''option C est incorrecte car ''this'' fait référence à l''objet courant, pas au parent. L''option D est incorrecte car il n''y a pas de mot-clé ''base''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','super.methodName()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','parent.methodName()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','this.methodName()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','base.methodName()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-005',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le polymorphisme en Java :','medium','SINGLE_CHOICE','Le polymorphisme en Java permet de faire référence à un objet sous une forme différente et d''appeler une méthode définie dans la classe enfant. Le polymorphisme est réalisé par l''intermédiaire de méthodes abstraites, d''interfaces et de surcharge. L''option B est incorrecte car le polymorphisme n''est pas uniquement réalisé par des méthodes abstraites.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le polymorphisme permet de faire référence à un objet sous une forme différente.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le polymorphisme est réalisé par l''intermédiaire de méthodes abstraites.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le polymorphisme permet d''appeler une méthode qui est définie dans la classe enfant.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le polymorphisme est utilisé pour réduire le couplage.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-006',v_cert_id,v_theme_id,'Quelle est la différence entre une méthode abstraite et une méthode concrète en Java ?','easy','SINGLE_CHOICE','Une méthode abstraite peut être déclarée dans une classe sans corps, tandis qu''une méthode concrète doit avoir un corps. L''option A est incorrecte car une méthode abstraite peut être implémentée dans la classe enfant, mais elle n''est pas obligatoire si la méthode est redéfinie. L''option C est incorrecte car une méthode abstraite n''est pas toujours publique, elle peut avoir d''autres modificateurs d''accès. L''option D est incorrecte car une méthode abstraite peut être statique, mais ce n''est pas courant.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une méthode abstraite doit être implémentée dans la classe enfant, tandis qu''une méthode concrète est déjà implémentée.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une méthode abstraite peut être déclarée dans une classe sans corps, tandis qu''une méthode concrète doit avoir un corps.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une méthode abstraite est toujours publique, tandis qu''une méthode concrète peut avoir n''importe quel modificateur d''accès.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une méthode abstraite ne peut pas être statique, tandis qu''une méthode concrète peut l''être.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-007',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''interface en Java ?','hard','SINGLE_CHOICE','Une interface peut hériter d''une autre interface et une classe peut implémenter plusieurs interfaces. Une interface ne peut pas contenir des méthodes concrètes, sauf en utilisant les méthodes par défaut ou statiques introduits dans Java 8. L''option D est incorrecte car une interface peut contenir des attributs, mais ils sont implicitement publics, statiques et finals.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une interface peut contenir des méthodes concrètes.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une interface peut hériter d''une autre interface.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe peut implémenter plusieurs interfaces.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une interface ne peut pas contenir des attributs.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-008',v_cert_id,v_theme_id,'Quelle est la différence entre une classe abstraite et une interface en Java ?','easy','SINGLE_CHOICE','Une classe abstraite peut avoir des constructeurs, tandis qu''une interface ne peut pas. Une classe abstraite peut contenir des méthodes concrètes et des champs non statiques, tandis qu''une interface ne peut contenir que des méthodes abstraites et des champs publics statiques finals. L''option B est incorrecte car une classe abstraite ne peut pas être instanciée, mais elle peut avoir des constructeurs pour initialiser ses sous-classes. L''option D est incorrecte car une interface peut avoir des champs publics statiques finals.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe abstraite peut contenir des méthodes concrètes, tandis qu''une interface ne peut pas.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe abstraite peut être instanciée, tandis qu''une interface ne peut pas.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Une classe abstraite peut avoir des constructeurs, tandis qu''une interface ne peut pas.',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe abstraite peut avoir des champs non statiques, tandis qu''une interface ne peut pas.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-009',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la polymorphisme en Java :','medium','SINGLE_CHOICE','L''option A est correcte car la polymorphisme permet de redéfinir une méthode dans une classe enfant. L''option B est correcte car elle décrit le polymorphisme par subtypes, où des objets de types différents peuvent être traités comme étant du même type. L''option C est incorrecte car la surcharge de méthodes se fait dans une même classe, pas entre parent et enfant. L''option D est incorrecte car le polymorphisme ne concerne pas la possibilité de créer des classes avec le même nom.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permet de définir une méthode dans la classe parente et redéfinir cette méthode dans la classe enfant',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permet de créer des objets avec des types différents mais qui peuvent être traités comme étant du même type',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permet de surcharger des méthodes dans une classe enfant',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Permet d''avoir plusieurs classes avec le même nom',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-010',v_cert_id,v_theme_id,'Quelle est la différence entre l''héritage et l''interface en Java ?','easy','SINGLE_CHOICE','L''option C est correcte car l''héritage est utilisé pour définir des classes avec une hiérarchie, tandis que l''interface est utilisée pour définir des types qui peuvent être partagés entre différentes classes. Les autres options sont incorrectes car l''héritage permet de partager des méthodes et des attributs, les interfaces peuvent avoir des méthodes avec une implémentation par défaut en Java 8+, et l''héritage est simple mais une classe peut implémenter plusieurs interfaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''héritage permet de partager des méthodes et des attributs, l''interface ne le fait pas',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''interface peut avoir des méthodes avec une implémentation, l''héritage non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''héritage est utilisé pour définir des classes, l''interface pour définir des types',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''héritage est multiple, l''interface ne peut être implémentée qu''une seule fois',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-011',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''encapsulation en Java ?','hard','SINGLE_CHOICE','L''option A est correcte car l''encapsulation permet de protéger les données en utilisant des accesseurs (getters) et mutateurs (setters). L''option B est incorrecte car l''héritage ou l''implémentation d''interfaces permettent de partager des méthodes entre différentes classes. L''option C est incorrecte car l''encapsulation n''est pas liée à l''implémentation d''interfaces. L''option D est correcte car l''encapsulation permet de cacher les détails d''implémentation en limitant l''accès direct aux variables membres.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permet de protéger les données en utilisant des accesseurs et mutateurs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permet de partager des méthodes entre différentes classes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permet d''implémenter des interfaces',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Permet de cacher les détails d''implémentation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-012',v_cert_id,v_theme_id,'Quelle est la méthode appelée lors de l''instanciation d''un objet en Java ?','easy','SINGLE_CHOICE','L''option A est correcte car le constructeur est appelé lors de l''instanciation d''un objet en Java. Les autres options sont incorrectes car l''initialiseur est utilisé pour initialiser des champs, les méthodes statiques ne sont pas appelées lors de l''instanciation et les méthodes d''instance nécessitent une instance pour être appelées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','constructeur',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','initialiseur',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','méthode statique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','méthode d''instance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-013',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''abstraction en Java :','medium','SINGLE_CHOICE','L''option A est correcte car l''abstraction permet de cacher les détails d''implémentation en utilisant des interfaces et des classes abstraites. L''option B est correcte car elle décrit l''utilisation de méthodes abstraites dans une interface ou une classe abstraite. L''option C est incorrecte car l''abstraction ne concerne pas la partage de données entre différentes classes. L''option D est incorrecte car l''abstraction n''est pas liée à la possibilité de définir plusieurs constructeurs dans une classe.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permet de cacher les détails d''implémentation',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permet de définir des méthodes sans implémentations',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permet de partager des données entre différentes classes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Permet d''avoir plusieurs constructeurs dans une classe',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-014',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''héritage en Java :','medium','SINGLE_CHOICE','L''option B est correcte car Java supporte l''héritage simple de classes (une seule classe parente). L''option C est correcte car l''héritage est utilisé pour réutiliser le code. Les options A et D sont incorrectes car Java ne supporte pas l''héritage multiple de classes mais permet l''héritage d''interfaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe peut hériter de plusieurs classes parentes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe peut hériter d''une seule classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''héritage est utilisé pour réutiliser le code',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe peut hériter d''une interface uniquement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-015',v_cert_id,v_theme_id,'Quelle est la différence entre ''extends'' et ''implements'' en Java ?','easy','SINGLE_CHOICE','''extends'' est utilisé pour hériter de classes, tandis que ''implements'' est utilisé pour implémenter des interfaces. Les options A et C sont incorrectes car elles inversent les usages, tandis que l''option D est incorrecte car ces mots-clés ont des utilisations distinctes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','''extends'' est utilisé pour implémenter des interfaces, ''implements'' est utilisé pour hériter de classes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','''extends'' est utilisé pour hériter de classes, ''implements'' est utilisé pour implémenter des interfaces',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','''extends'' et ''implements'' sont interchangeables',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Aucune différence, ils ont le même usage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-016',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le polymorphisme en Java ?','hard','SINGLE_CHOICE','L''option C est correcte car le polymorphisme permet de faire référence à un objet d''une classe enfant avec une variable de type de classe parente. L''option D est correcte car le polymorphisme permet également de cacher des méthodes. Les options A et B sont incorrectes car le polymorphisme ne concerne pas la surcharge de méthodes ou l''implémentation de plusieurs méthodes avec le même nom.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le polymorphisme permet de définir plusieurs méthodes avec le même nom',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le polymorphisme est utilisé pour surcharger des classes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le polymorphisme permet de faire référence à un objet d''une classe enfant avec une variable de type de classe parente',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le polymorphisme est utilisé pour cacher des méthodes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-017',v_cert_id,v_theme_id,'Quelle est la méthode appelée lors de l''instanciation d''un objet en Java ?','easy','SINGLE_CHOICE','La méthode appelée lors de l''instanciation d''un objet en Java est le constructeur. Les options B, C et D sont incorrectes car elles ne correspondent pas à des méthodes spécifiques de l''instanciation d''un objet.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Constructeur',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Méthode main',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Méthode start',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Méthode init',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-018',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la surcharge de méthodes en Java :','medium','SINGLE_CHOICE','L''option A est correcte car la surcharge permet de définir plusieurs méthodes avec le même nom mais des signatures différentes. L''option D est correcte car la surcharge peut être effectuée en changeant le type des paramètres. Les options B et C sont incorrectes car la surcharge ne modifie pas le comportement d''une méthode existante et n''est pas réalisée dans différentes classes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La surcharge permet de définir plusieurs méthodes avec le même nom mais des signatures différentes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','La surcharge permet de modifier le comportement d''une méthode existante',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La surcharge est réalisée dans différentes classes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','La surcharge peut être effectuée en changeant le type des paramètres',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-019',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''héritage en Java :','medium','SINGLE_CHOICE','L''option B est correcte car Java supporte l''héritage simple de classes, une classe peut hériter d''une seule classe parente. L''option D est correcte car une classe peut également hériter d''une interface, ce qui est appelé héritage multiple. Les options A et C sont incorrectes : Java ne supporte pas l''héritage multiple de classes, mais permet d''implémenter plusieurs interfaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe peut hériter de plusieurs classes parentes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe peut hériter d''une seule classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''héritage n''existe pas en Java',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe peut hériter d''une interface uniquement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-020',v_cert_id,v_theme_id,'Quelle est la méthode utilisée pour appeler une méthode de la classe parente dans Java ?','easy','SINGLE_CHOICE','L''option A est correcte car ''super.methodName()'' est utilisé pour appeler une méthode de la classe parente dans Java. Les options B, C et D sont incorrectes : ''this'' fait référence à l''objet actuel, ''parent'' et ''base'' ne sont pas des mots-clés valides en Java pour accéder à la classe parente.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','super.methodName()',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','this.methodName()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','parent.methodName()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','base.methodName()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-021',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le polymorphisme en Java ?','medium','SINGLE_CHOICE','L''option B est correcte car le polymorphisme en Java est effectivement réalisé par l''intermédiaire de l''héritage et des interfaces. L''option D est correcte car le polymorphisme permet d''utiliser un objet d''une classe enfant comme si c''était un objet de la classe parente, ce qui est appelé polymorphisme par subtyping. Les options A et C sont incorrectes : le polymorphisme ne permet pas de définir plusieurs méthodes avec le même nom dans une classe, et il peut être utilisé avec des classes non abstraites.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le polymorphisme permet de définir plusieurs méthodes avec le même nom dans une classe',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le polymorphisme est réalisé par l''intermédiaire de l''héritage et des interfaces',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le polymorphisme ne peut être utilisé que avec les classes abstraites',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le polymorphisme permet d''utiliser un objet d''une classe enfant comme si c''était un objet de la classe parente',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-022',v_cert_id,v_theme_id,'Quelle est la différence entre un constructeur et une méthode dans Java ?','hard','SINGLE_CHOICE','L''option A est correcte car un constructeur initialise les attributs d''un objet lors de sa création, tandis qu''une méthode effectue une action spécifique. Les options B et C sont incorrectes : un constructeur ne retourne aucune valeur, et il s''exécute lors de la création d''un objet, pas après l''appel de main(). L''option D est incorrecte car une méthode peut avoir le même nom que la classe, mais ce n''est pas une règle.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Un constructeur initialise un objet, une méthode effectue une action',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Un constructeur peut retourner une valeur, une méthode ne peut pas',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Un constructeur s''exécute après l''appel de la méthode main()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Un constructeur doit avoir le même nom que la classe, une méthode peut avoir n''importe quel nom',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-023',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encapsulation en Java :','medium','SINGLE_CHOICE','L''option A est correcte car l''encapsulation permet de cacher les détails d''implémentation en utilisant des modificateurs d''accès. L''option B est correcte car l''encapsulation est souvent réalisée en utilisant des accesseurs et mutateurs pour contrôler l''accès aux attributs. L''option C est correcte car elle protège les données en limitant leur accès direct. L''option D est incorrecte car utiliser des variables publiques va à l''encontre de la philosophie de l''encapsulation, qui vise à protéger les données.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''encapsulation permet de cacher les détails d''implémentation',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''encapsulation est réalisée en utilisant des accesseurs (getters) et mutateurs (setters)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''encapsulation permet de protéger les données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''encapsulation est réalisée en utilisant des variables publiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-024',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''héritage en Java :','medium','SINGLE_CHOICE','L''héritage en Java est simple, une classe peut hériter d''une seule classe parente (option B). L''héritage multiple de classes n''est pas supporté (option A est incorrecte), mais une classe peut hériter d''une interface (option D). L''héritage existe en Java, donc l''option C est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe peut hériter de plusieurs classes parentes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe peut hériter d''une seule classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''héritage n''existe pas en Java',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe peut hériter d''une interface',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-025',v_cert_id,v_theme_id,'Que signifie ''implements'' en Java ?','easy','SINGLE_CHOICE','''implements'' est utilisé pour implémenter une interface, donc l''option C est correcte. Les autres options ne sont pas liées à ''implements''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Déclare une méthode abstraite',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Hérite d''une classe parente',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Implémente une interface',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Crée une nouvelle instance',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-026',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le polymorphisme en Java :','medium','SINGLE_CHOICE','Le polymorphisme permet d''appeler une méthode sur un objet sans connaître son type exact (option B). Il permet également de créer des méthodes avec le même nom dans différentes classes (option A), ce qui est appelé polymorphisme par surcharge. L''utilisation de ''final'' empêche la surcharge et l''override, donc option C est incorrecte. Les types génériques sont liés à la paramétrisation de classes et méthodes, pas directement au polymorphisme (option D).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permet de créer des méthodes avec le même nom dans différentes classes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permet d''appeler une méthode sur un objet sans connaître son type exact',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Nécessite l''utilisation de la clé ''final''',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Permet d''utiliser des types génériques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-027',v_cert_id,v_theme_id,'Quelle est la différence entre ''abstract'' et ''interface'' en Java ?','hard','SINGLE_CHOICE','''abstract'' peut avoir des champs (variables), tandis que ''interface'' ne peut pas contenir de champs sauf des constantes. Les autres options sont incorrectes car ''abstract'' peut avoir des méthodes non implémentées (option A est partielle), ''interface'' est utilisé pour définir des méthodes mais peut également avoir des champs constants (option B), et ''interface'' peut être implémentée par une classe, pas héritée (option D).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','''abstract'' peut avoir des méthodes non implémentées, ''interface'' ne peut pas',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','''abstract'' est utilisé pour définir des classes, ''interface'' est utilisé pour définir des méthodes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','''abstract'' peut avoir des champs, ''interface'' ne peut pas',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','''abstract'' peut être hérité par une classe, ''interface'' ne peut pas',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-028',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le polymorphisme par inclusion en Java :','medium','SINGLE_CHOICE','Le polymorphisme par inclusion permet d''utiliser un objet d''une classe dérivée comme un objet de sa classe mère (option A). Il permet également d''appeler des méthodes spécifiques à la classe dérivée (option C). Le polymorphisme par inclusion n''utilise pas nécessairement ''extends'' ou ''implements'', donc options B et D sont incorrectes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permet d''utiliser un objet d''une classe dérivée comme un objet de sa classe mère',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Nécessite l''utilisation du mot-clé ''extends''',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permet d''appeler des méthodes spécifiques à la classe dérivée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Nécessite l''utilisation du mot-clé ''implements''',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-029',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''héritage en Java :','medium','SINGLE_CHOICE','L''héritage en Java est simple (une classe peut hériter d''une seule classe parente), mais il existe l''héritage multiple d''interfaces (une classe peut hériter d''une interface uniquement). L''héritage existe en Java, donc l''option C est incorrecte. L''option A est incorrecte car Java ne supporte pas l''héritage multiple de classes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe peut hériter de plusieurs classes parentes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe peut hériter d''une seule classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''héritage n''existe pas en Java',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe peut hériter d''une interface uniquement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-030',v_cert_id,v_theme_id,'Que signifie ''extends'' en Java ?','easy','SINGLE_CHOICE','''extends'' est utilisé pour l''héritage de classes. Une classe étend une autre classe avec ''extends''. Les autres options ne sont pas correctes car ''implements'' est utilisé pour implémenter une interface, ''new'' crée une nouvelle instance et ''abstract'' déclare une méthode abstraite.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Implémente une interface',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Hérite d''une classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Crée une nouvelle instance',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Déclare une méthode abstraite',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-031',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le polymorphisme en Java ?','hard','SINGLE_CHOICE','Le polymorphisme permet de définir des méthodes avec le même nom dans différentes classes (surcharge et redéfinition). Il permet également d''appeler une méthode d''une classe enfant en utilisant une référence de la classe parente (liaison dynamique). L''option B est incorrecte car le polymorphisme peut être utilisé avec des méthodes non statiques. L''option D est incorrecte car le polymorphisme s''applique aux méthodes, pas aux attributs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le polymorphisme permet de définir des méthodes avec le même nom dans différentes classes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le polymorphisme ne peut être utilisé qu''avec des méthodes statiques',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le polymorphisme permet d''appeler une méthode d''une classe enfant en utilisant une référence de la classe parente',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le polymorphisme est utilisé pour accéder à des attributs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-032',v_cert_id,v_theme_id,'Quelle est la différence entre ''abstract'' et ''interface'' en Java ?','easy','SINGLE_CHOICE','''abstract'' peut avoir des méthodes non abstraites, tandis que ''interface'' ne peut avoir que des méthodes abstraites (à partir de Java 8, les interfaces peuvent avoir des méthodes par défaut et statiques). Les autres options ne sont pas correctes car ''abstract'' est utilisé pour définir des classes, et ''interface'' est utilisée pour définir un contrat de méthodes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','''abstract'' est utilisé pour définir des méthodes abstraites, ''interface'' est utilisée pour définir une classe',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','''abstract'' peut avoir des méthodes non abstraites, ''interface'' ne peut avoir que des méthodes abstraites',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','''abstract'' est utilisé pour définir une classe, ''interface'' est utilisée pour définir des méthodes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','''abstract'' peut avoir des attributs, ''interface'' ne peut pas',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-033',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le polymorphisme en Java :','medium','SINGLE_CHOICE','Le polymorphisme permet de définir des méthodes avec le même nom dans différentes classes (surcharge et redéfinition). Il permet également d''appeler une méthode d''une classe enfant en utilisant une référence de la classe parente (liaison dynamique). L''option B est incorrecte car le polymorphisme peut être utilisé avec des méthodes non statiques. L''option D est incorrecte car le polymorphisme s''applique aux méthodes, pas aux attributs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le polymorphisme permet de définir des méthodes avec le même nom dans différentes classes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le polymorphisme ne peut être utilisé qu''avec des méthodes statiques',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le polymorphisme permet d''appeler une méthode d''une classe enfant en utilisant une référence de la classe parente',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le polymorphisme est utilisé pour accéder à des attributs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-034',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''héritage en Java :','medium','SINGLE_CHOICE','L''héritage en Java est simple et une classe peut hériter d''une seule classe parente (option B). L''héritage multiple est possible via des interfaces, ce qui signifie qu''une classe peut implémenter plusieurs interfaces (option C). Une classe ne peut pas hériter d''une interface, mais plutôt l''implémenter (option D). Donc, les options B et C sont correctes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Une classe peut hériter de plusieurs classes parentes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Une classe peut hériter d''une seule classe parente',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''héritage multiple est possible via des interfaces',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Une classe peut hériter d''une interface',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-035',v_cert_id,v_theme_id,'Quelle est la différence entre ''extends'' et ''implements'' en Java ?','easy','SINGLE_CHOICE','''extends'' est utilisé pour l''héritage de classes, tandis que ''implements'' est utilisé pour implémenter des interfaces (option A).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','''extends'' est utilisé pour l''héritage de classes, ''implements'' pour l''implémentation d''interfaces',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','''extends'' est utilisé pour l''implémentation d''interfaces, ''implements'' pour l''héritage de classes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','''extends'' et ''implements'' sont interchangeables',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Aucune différence',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-036',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le polymorphisme en Java :','hard','SINGLE_CHOICE','Le polymorphisme permet de définir des méthodes avec le même nom dans différentes classes (option A) et permet d''appeler une méthode sur un objet sans connaître son type exact (option C). Le polymorphisme n''est pas principalement utilisé pour améliorer la performance du code (option B) ni pour réduire la complexité du code (option D).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le polymorphisme permet de définir des méthodes avec le même nom dans différentes classes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le polymorphisme est utilisé pour améliorer la performance du code',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le polymorphisme permet d''appeler une méthode sur un objet sans connaître son type exact',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le polymorphisme est utilisé pour réduire la complexité du code',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-037',v_cert_id,v_theme_id,'Quelle est la méthode appelée lorsqu''on utilise un objet de type parent mais qu''il s''agit en réalité d''un objet de type enfant ?','medium','SINGLE_CHOICE','Lorsqu''on utilise un objet de type parent mais qu''il s''agit en réalité d''un objet de type enfant, la méthode appelée est celle de la classe enfant si elle est redéfinie (option B).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Méthode de la classe parente',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Méthode de la classe enfant si elle est redéfinie',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Aucune méthode n''est appelée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes les méthodes sont appelées',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-038',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''encapsulation en Java :','hard','SINGLE_CHOICE','L''encapsulation permet de cacher les détails d''implémentation (option A), est réalisée en utilisant des modificateurs d''accès (public, private, protected) (option B), et permet de protéger les données (option C). L''encapsulation n''est pas utilisée pour accélérer l''exécution du code (option D).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','L''encapsulation permet de cacher les détails d''implémentation',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''encapsulation est réalisée en utilisant des modificateurs d''accès (public, private, protected)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''encapsulation permet de protéger les données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','L''encapsulation est utilisée pour accélérer l''exécution du code',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-P-C-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='poo_classes_h_ritage_polymorphisme' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-P-C-039',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le polymorphisme en Java :','medium','SINGLE_CHOICE','L''option A est correcte car le polymorphisme en Java permet effectivement à une méthode d''être redéfinie dans une classe enfant, ce qui est connu sous le nom de surcharge (overriding). L''option B est incorrecte car, bien que les interfaces jouent un rôle dans le polymorphisme en Java (en définissant des méthodes que les classes peuvent implémenter), le polymorphisme lui-même ne se limite pas exclusivement aux interfaces. L''option C est correcte car le polymorphisme peut être utilisé avec des objets de type Object, ce qui est une caractéristique importante du polymorphisme en Java. L''option D est incorrecte car le polymorphisme fonctionne également avec des classes abstraites et non seulement avec les classes concrètes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le polymorphisme permet à une méthode d''être redéfinie dans une classe enfant',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le polymorphisme est réalisé à l''aide de l''interface',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le polymorphisme peut être utilisé avec des objets de type Object',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le polymorphisme ne fonctionne qu''avec les classes concrètes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-001',v_cert_id,v_theme_id,'Quelle interface est à la racine de la hiérarchie des collections (hors Map) ?','easy','SINGLE_CHOICE','Collection est l''interface racine pour List, Set, Queue. Iterable est au-dessus de Collection (permet le foreach).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Collection',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Iterable',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','List',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Set',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-002',v_cert_id,v_theme_id,'Quelle est la différence principale entre List et Set ?','easy','SINGLE_CHOICE','List maintient l''ordre d''insertion et permet les éléments en double. Set ne permet pas de doublons (basé sur equals/hashCode).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','List est ordonné et accepte les doublons, Set n''est pas ordonné et n''accepte pas les doublons',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','List est plus rapide que Set',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Set est plus rapide que List',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','List ne peut contenir que des objets, Set que des primitives',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-003',v_cert_id,v_theme_id,'Quelle implémentation de List est la plus utilisée pour un accès aléatoire rapide ?','easy','SINGLE_CHOICE','ArrayList est basé sur un tableau, offrant un accès O(1) par index. LinkedList a un accès O(n).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','LinkedList',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ArrayList',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Vector',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Stack',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-004',v_cert_id,v_theme_id,'Quelle implémentation de List est préférable pour des insertions/suppressions fréquentes au milieu ?','easy','SINGLE_CHOICE','LinkedList est basé sur une liste chaînée, offrant des insertions/suppressions O(1) au milieu (après avoir trouvé la position).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ArrayList',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','LinkedList',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Vector',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','CopyOnWriteArrayList',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-005',v_cert_id,v_theme_id,'Quelle implémentation de Set garantit l''ordre d''insertion ?','easy','SINGLE_CHOICE','LinkedHashSet maintient l''ordre d''insertion via une liste chaînée. HashSet n''a pas d''ordre, TreeSet est trié.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashSet',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','TreeSet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','LinkedHashSet',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','EnumSet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-006',v_cert_id,v_theme_id,'Quelle implémentation de Set trie les éléments ?','easy','SINGLE_CHOICE','TreeSet implémente SortedSet et maintient les éléments triés (ordre naturel ou via Comparator).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashSet',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','TreeSet',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','LinkedHashSet',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Set.of()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-007',v_cert_id,v_theme_id,'Quelle est la complexité temporelle moyenne pour contains() dans un HashSet ?','easy','SINGLE_CHOICE','HashSet utilise une table de hachage, donc contains() est O(1) en moyenne. O(n) dans le pire cas (beaucoup de collisions).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','O(1)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','O(log n)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','O(n)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','O(n²)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-008',v_cert_id,v_theme_id,'Quelle interface Map conserve l''ordre d''insertion ?','easy','SINGLE_CHOICE','LinkedHashMap maintient l''ordre d''insertion ou l''ordre d''accès (si accessOrder=true).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashMap',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','TreeMap',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','LinkedHashMap',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Hashtable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-009',v_cert_id,v_theme_id,'Quelle implémentation de Map trie les clés ?','easy','SINGLE_CHOICE','TreeMap implémente SortedMap et maintient les clés triées selon l''ordre naturel ou un Comparator.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashMap',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','TreeMap',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','LinkedHashMap',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ConcurrentHashMap',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-010',v_cert_id,v_theme_id,'Que signifie la capacité initiale d''un HashMap ?','easy','SINGLE_CHOICE','La capacité initiale est le nombre de buckets (cases) dans la table de hachage à la création. Par défaut 16.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le nombre maximum d''éléments',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le nombre de buckets au moment de la création',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La taille de chaque bucket',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le seuil de rehachage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-011',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<String> list = new ArrayList<>();
list.add("A");
list.add("B");
list.add(1, "C");
System.out.println(list);
```','medium','SINGLE_CHOICE','add(1, "C") insère à l''index 1. Liste initiale [A, B] → après insertion [A, C, B].','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','[A, B, C]',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','[A, C, B]',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','[C, A, B]',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','[A, B]',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-012',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Set<Integer> set = new HashSet<>();
set.add(1);
set.add(2);
set.add(1);
System.out.println(set.size());
```','medium','SINGLE_CHOICE','HashSet n''accepte pas les doublons. 1 est ajouté une seule fois → taille = 2.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','3',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','2',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','1',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','0',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-013',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Map<String, Integer> map = new HashMap<>();
map.put("A", 1);
map.put("A", 2);
System.out.println(map.get("A"));
```','medium','SINGLE_CHOICE','put() avec une clé existante remplace l''ancienne valeur. La nouvelle valeur est 2.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','2',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','null',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-014',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<Integer> list = Arrays.asList(1, 2, 3);
list.add(4);
System.out.println(list);
```','medium','SINGLE_CHOICE','Arrays.asList() retourne une liste de taille fixe. add() n''est pas supporté → UnsupportedOperationException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','[1, 2, 3, 4]',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Erreur - UnsupportedOperationException',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','[1, 2, 3]',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NullPointerException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-015',v_cert_id,v_theme_id,'Comment créer une liste immuable (non modifiable) en Java 9+ ?','medium','SINGLE_CHOICE','List.of() (Java 9+) crée une liste immuable. Collections.unmodifiableList() crée une vue non modifiable mais la liste sous-jacente peut l''être.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','new ArrayList<>(Arrays.asList(1,2,3))',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','List.of(1, 2, 3)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Collections.unmodifiableList()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','B et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-016',v_cert_id,v_theme_id,'Quelle est la différence entre Collection.remove() et Iterator.remove() ?','medium','SINGLE_CHOICE','Pendant l''itération, appeler Collection.remove() cause ConcurrentModificationException. Iterator.remove() est sûr.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Aucune différence',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Iterator.remove() peut être appelé pendant l''itération, pas Collection.remove()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Collection.remove() est plus rapide',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Iterator.remove() lève une exception si la collection est vide',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-017',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<Integer> list = new ArrayList<>(List.of(1,2,3));
for (Integer i : list) {
    if (i == 2) list.remove(i);
}
```','medium','SINGLE_CHOICE','Modifier une collection pendant une itération foreach (qui utilise un Iterator implicite) lève ConcurrentModificationException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','[1, 3]',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ConcurrentModificationException',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','[1, 2, 3]',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','IndexOutOfBoundsException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-018',v_cert_id,v_theme_id,'Comment supprimer correctement des éléments pendant l''itération ?','medium','SINGLE_CHOICE','Trois méthodes sûres : Iterator.remove(), removeIf(Predicate) (Java 8+), ou itérer sur une copie.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser Iterator.remove()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utiliser Collection.removeIf()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser une copie de la collection',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-019',v_cert_id,v_theme_id,'Quelle est la capacité par défaut d''un ArrayList ?','easy','SINGLE_CHOICE','ArrayList a une capacité initiale par défaut de 10 éléments. Il s''agrandit automatiquement quand nécessaire.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','10',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','0',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Dépend de la JVM',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-020',v_cert_id,v_theme_id,'Quelle est la capacité par défaut d''un HashMap ?','easy','SINGLE_CHOICE','HashMap a une capacité initiale par défaut de 16 buckets. Le facteur de charge par défaut est 0.75.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','10',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','16',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','32',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','8',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-021',v_cert_id,v_theme_id,'Qu''est-ce que le ''load factor'' d''un HashMap ?','medium','SINGLE_CHOICE','Le load factor (0.75 par défaut) détermine quand rehasher : quand nombre éléments > capacité × load factor.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le ratio taille/capacité qui déclenche le rehachage',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le nombre moyen d''éléments par bucket',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La limite avant débordement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-04-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='collections_et_g_n_riques' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-04-022',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Queue<String> queue = new LinkedList<>();
queue.offer("A");
queue.offer("B");
System.out.println(queue.poll());
System.out.println(queue.peek());
```','medium','SINGLE_CHOICE','offer() ajoute, poll() retire et retourne la tête (A), peek() regarde sans retirer (B restant).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','A B',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','A A',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','B B',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A null',FALSE,3);
    END IF;
END $$;
