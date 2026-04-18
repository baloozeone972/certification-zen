-- V6a_java21_04__seed_java21_part4.sql
-- java21: questions 451–600
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
    VALUES (uuid_generate_v4(),v_cert_id,'exceptions_et_gestion_d_erreurs','Exceptions et Gestion d''erreurs',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'flux_i_o_et_nio','Flux I/O et NIO',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'multithreading_et_concurrence','Multithreading et Concurrence',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'lambda_streams_et_api_fonctionnelle','Lambda, Streams et API fonctionnelle',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-016',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le bloc finally dans une structure try-catch :','medium','SINGLE_CHOICE','Le bloc finally est toujours exécuté après le bloc try et catch, indépendamment de l''occurrence d''une exception. Il peut être omis si aucune action spécifique n''est nécessaire après le bloc catch. Cependant, il ne peut pas contenir de instructions return car cela pourrait empêcher l''exécution du code dans le bloc finally. Le bloc finally est exécuté après le bloc catch.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc finally est toujours exécuté, quelle que soit l''occurrence d''une exception.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc finally peut être omis si aucune action n''est requise après le bloc catch.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc finally ne peut pas contenir de instructions return.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le bloc finally est exécuté avant le bloc catch.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-017',v_cert_id,v_theme_id,'Quelle est la principale différence entre try-with-resources et un bloc try-catch standard ?','easy','SINGLE_CHOICE','Toutes ces réponses sont correctes. try-with-resources permet de gérer automatiquement les ressources en s''assurant qu''elles sont fermées après l''exécution du bloc try. Le bloc try-catch standard peut effectivement gérer plusieurs exceptions en une seule ligne à partir de Java 7. try-with-resources nécessite que toutes les ressources soient des objets qui implémentent AutoCloseable.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources permet de gérer automatiquement les ressources.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc try-catch standard ne peut pas gérer plusieurs exceptions en une seule ligne.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try-with-resources nécessite que toutes les ressources soient des objets qui implémentent AutoCloseable.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-018',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''utilisation du mot-clé ''throw'' en Java ?','hard','SINGLE_CHOICE','''throw'' est effectivement utilisé pour lancer une exception explicitement. Cependant, ''throw'' ne peut pas être utilisé pour lancer n''importe quelle exception checked sans un bloc try-catch ou une clause throws dans la signature de méthode. ''throw'' peut être utilisé n''importe où dans le code, pas seulement dans des blocs try-catch. ''throw'' doit toujours être suivi d''une nouvelle instance d''exception.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','''throw'' est utilisé pour lancer une exception explicitement.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','''throw'' peut être utilisé pour lancer n''importe quelle exception, y compris les exceptions checked.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','''throw'' ne peut être utilisé que dans des blocs try-catch.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','''throw'' doit toujours être suivi d''une nouvelle instance d''exception.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-019',v_cert_id,v_theme_id,'Quelle est la hiérarchie de l''exception IOException en Java ?','easy','SINGLE_CHOICE','IOException est une exception checked, donc elle étend Exception. RuntimeException et Error sont des exceptions unchecked, et Throwable est la classe parente de toutes les exceptions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','IOException extends Exception.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IOException extends RuntimeException.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IOException extends Error.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','IOException extends Throwable.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-020',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''ordre d''exécution dans un bloc try-catch-finally :','medium','SINGLE_CHOICE','Le bloc try est toujours exécuté avant le bloc catch et finally. Si une exception est lancée, le bloc catch est effectivement exécuté avant le bloc finally. Cependant, le bloc finally est toujours exécuté après le bloc try et catch, quelle que soit l''occurrence d''une exception. Si une exception n''est pas lancée, le bloc finally est exécuté après le bloc try.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc finally est toujours exécuté avant le bloc catch.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Si une exception est lancée, le bloc catch est exécuté avant le bloc finally.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc try est toujours exécuté avant le bloc catch et finally.',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Si une exception n''est pas lancée, le bloc finally est exécuté après le bloc try.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-021',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le bloc finally :','medium','SINGLE_CHOICE','Le bloc finally s''exécute toujours après le try et catch, même si une exception est lancée. Cependant, il ne s''exécute pas si System.exit() est appelé. Il peut être omis, mais ne peut pas contenir de déclarations return.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le code dans le bloc finally s''exécute toujours, même si une exception est lancée.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le code dans le bloc finally ne s''exécute pas si System.exit() est appelé.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le code dans le bloc finally peut être omis si aucune action n''est nécessaire après la gestion des exceptions.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le code dans le bloc finally ne peut pas contenir de déclarations return.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-022',v_cert_id,v_theme_id,'Quelle est la principale différence entre try-with-resources et try-catch-finally ?','easy','SINGLE_CHOICE','Toutes les réponses précédentes sont correctes. try-with-resources est spécifique pour gérer des ressources qui implémentent AutoCloseable, garantissant leur fermeture après l''exécution du bloc try. En revanche, avec try-catch-finally, il faut fermer les ressources explicitement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources est utilisé pour gérer les ressources qui implémentent AutoCloseable.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try-with-resources garantit que toutes les ressources sont fermées après l''exécution du bloc try.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try-catch-finally nécessite explicitement la fermeture des ressources.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes les réponses précédentes.',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-023',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''utilisation du bloc catch ?','hard','SINGLE_CHOICE','Le bloc catch peut capturer plusieurs types d''exceptions dans une seule clause en utilisant des barres verticales. Le bloc catch doit capturer des exceptions de type Throwable, mais il n''est pas obligatoire d''avoir un bloc finally après chaque bloc catch. Le bloc catch ne peut pas être omis si le bloc try lance des exceptions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le bloc catch peut capturer plusieurs types d''exceptions dans une seule clause.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le bloc catch doit toujours être suivi d''un bloc finally.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc catch peut être omis si le bloc try ne lance pas d''exceptions.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le bloc catch doit capturer des exceptions de type Throwable.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-024',v_cert_id,v_theme_id,'Quelle est la bonne pratique pour gérer les exceptions en Java ?','easy','SINGLE_CHOICE','La bonne pratique est d''utiliser des blocs try-catch pour gérer les exceptions spécifiques et un bloc catch général pour capturer les autres types d''exceptions. Cela permet une gestion précise et flexible des erreurs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Capturer toutes les exceptions possibles dans un seul bloc catch.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utiliser des blocs try-catch pour gérer les exceptions spécifiques et un bloc catch général.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Omettre la gestion des exceptions pour simplifier le code.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Utiliser try-with-resources uniquement pour les ressources qui implémentent AutoCloseable.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-025',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''ordre d''exécution dans un bloc try-catch-finally :','medium','SINGLE_CHOICE','Le code dans le bloc finally s''exécute après le bloc try et catch, peu importe si une exception est lancée ou non. Le code dans le bloc try est toujours exécuté avant les blocs catch et finally. Si une exception est lancée, le code dans le bloc catch est exécuté avant le bloc finally.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le code dans le bloc finally s''exécute après le bloc try et catch.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Si une exception est lancée, le code dans le bloc finally s''exécute avant le bloc catch.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le code dans le bloc try est toujours exécuté avant les blocs catch et finally.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Le code dans le bloc catch est exécuté avant le bloc finally.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-EEG-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='exceptions_et_gestion_d_erreurs' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-EEG-026',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''utilisation de try-with-resources en Java :','medium','SINGLE_CHOICE','L''option A est correcte car try-with-resources permet d''automatiquement fermer les ressources après l''exécution du bloc try. L''option B est correcte car try-with-resources ne peut être utilisé que avec des classes qui implémentent l''interface AutoCloseable. L''option C est incorrecte car Closeable est une interface, mais try-with-resources nécessite l''implémentation d''AutoCloseable. L''option D est incorrecte car try-with-resources peut être utilisé avec des classes qui implémentent la méthode close(), mais il faut qu''elles implémentent l''interface AutoCloseable.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources permet d''automatiquement fermer les ressources après l''exécution du bloc try',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','try-with-resources ne peut être utilisé que avec des classes qui implémentent l''interface AutoCloseable',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','try-with-resources peut être utilisé avec des classes qui implémentent la méthode close()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','try-with-resources ne peut pas être utilisé avec des classes qui implémentent l''interface Closeable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-001',v_cert_id,v_theme_id,'Quelle classe est utilisée pour lire des fichiers texte avec encodage ?','easy','SINGLE_CHOICE','FileReader est la classe de base pour lire des fichiers texte. Pour les performances, l''envelopper dans BufferedReader.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','FileReader',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BufferedReader',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','InputStreamReader',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','FileInputStream',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-002',v_cert_id,v_theme_id,'Quelle classe est utilisée pour écrire des fichiers texte ?','easy','SINGLE_CHOICE','FileWriter écrit des caractères dans un fichier. Pour les performances, utiliser BufferedWriter.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','FileWriter',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BufferedWriter',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','OutputStreamWriter',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','FileOutputStream',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-003',v_cert_id,v_theme_id,'Quelle est la différence entre InputStream et Reader ?','easy','SINGLE_CHOICE','InputStream (et OutputStream) travaillent avec des bytes. Reader (et Writer) travaillent avec des caractères (texte).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','InputStream lit des bytes, Reader lit des caractères',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','InputStream lit des caractères, Reader lit des bytes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','InputStream est plus rapide',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Reader est obsolète',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-004',v_cert_id,v_theme_id,'Comment spécifier l''encodage avec FileReader ?','easy','SINGLE_CHOICE','FileReader n''accepte pas d''encodage avant Java 11. Java 11+ accepte Charset. La solution portable est InputStreamReader.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','new FileReader("file.txt", StandardCharsets.UTF_8)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','FileReader n''accepte pas d''encodage',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','new InputStreamReader(new FileInputStream("file.txt"), "UTF-8")',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','B et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-005',v_cert_id,v_theme_id,'Que produit ce code ?
```java
try (BufferedReader br = new BufferedReader(new FileReader("test.txt"))) {
    String line;
    while ((line = br.readLine()) != null) {
        System.out.println(line);
    }
}
```','medium','SINGLE_CHOICE','readLine() lit ligne par ligne. Si le fichier n''existe pas, FileNotFoundException (checked) doit être gérée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lit et affiche chaque ligne du fichier',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lit un seul caractère',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur si fichier inexistant',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-006',v_cert_id,v_theme_id,'Que fait ''Files.readString(Path.of("test.txt"))'' (Java 11+) ?','medium','SINGLE_CHOICE','Files.readString() (Java 11+) lit tout le contenu d''un fichier dans une String. Pratique pour les petits fichiers.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lit tout le fichier en une String',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lit la première ligne',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Lit le fichier en bytes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Lit le fichier en Base64',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-007',v_cert_id,v_theme_id,'Que fait ''Files.writeString(Path.of("test.txt"), "Hello")'' (Java 11+) ?','medium','SINGLE_CHOICE','writeString() écrit la String dans le fichier, écrasant le contenu existant par défaut (option d''ajout disponible).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Écrit une String dans un fichier',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ajoute à la fin du fichier',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Remplace le contenu par défaut',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-008',v_cert_id,v_theme_id,'Qu''est-ce que NIO (java.nio) apporte par rapport à java.io ?','easy','SINGLE_CHOICE','NIO (New I/O, Java 1.4+) ajoute les buffers, canaux, sélecteurs pour I/O scalable et non-bloquant.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Canaux (channels) et buffers',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Sélecteurs pour I/O non-bloquant',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Meilleures performances pour les gros fichiers',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-009',v_cert_id,v_theme_id,'Que représente ''Path'' en Java NIO ?','easy','SINGLE_CHOICE','Path (interface) représente un chemin dans le système de fichiers. Path.of() ou Paths.get() pour créer.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Un chemin de fichier ou répertoire',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le contenu d''un fichier',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Un flux de données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Un buffer de bytes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-010',v_cert_id,v_theme_id,'Que fait ''Files.exists(Path.of("/tmp/test"))'' ?','easy','SINGLE_CHOICE','Files.exists() vérifie l''existence d''un fichier ou répertoire. Il existe aussi Files.notExists() pour le cas contraire.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Vérifie si le fichier/répertoire existe',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Crée le fichier',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Supprime le fichier',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Lit le fichier',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-011',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Path path = Path.of("a/b/c/file.txt");
System.out.println(path.getParent());
```','medium','SINGLE_CHOICE','getParent() retourne le chemin parent (a/b/c). getFileName() retournerait ''file.txt''.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','a/b/c',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','file.txt',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','a/b/c/file.txt',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-012',v_cert_id,v_theme_id,'Que fait ''Files.createDirectories(Path.of("a/b/c"))'' ?','medium','SINGLE_CHOICE','createDirectories() crée tous les répertoires du chemin qui n''existent pas. createDirectory() crée seulement le dernier.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Crée tous les répertoires manquants',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Crée seulement le dernier répertoire',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Lève exception si parent n''existe pas',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Crée un fichier',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-013',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Path p1 = Path.of("/a/b");
Path p2 = Path.of("/a/b/c/../d");
System.out.println(p1.equals(p2.normalize()));
```','medium','SINGLE_CHOICE','normalize() résout ''..'' . /a/b/c/../d → /a/b/d. p1=/a/b, p2=/a/b/d → pas égaux. Correction : p1=/a/b, p2=/a/b/d → false. Je corrige : p2=/a/b/c/../d normalisé = /a/b/d, p1=/a/b, donc false. La réponse est false.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','true',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','false',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Erreur',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-014',v_cert_id,v_theme_id,'Que fait ''Files.walk(Path.of("."))'' ?','medium','SINGLE_CHOICE','Files.walk() retourne un Stream<Path> qui parcourt récursivement l''arborescence. Nécessite try-with-resources pour fermer.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Parcourt récursivement l''arborescence',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Retourne un Stream<Path>',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Liste seulement les fichiers',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-015',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Path path = Path.of("test.txt");
Files.writeString(path, "Hello");
Files.writeString(path, "World", StandardOpenOption.APPEND);
System.out.println(Files.readString(path));
```','medium','SINGLE_CHOICE','Premier writeString : "Hello". Deuxième avec APPEND : ajoute "World" à la fin → "HelloWorld".','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HelloWorld',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','World',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Hello',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','HelloWorld avec saut',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-016',v_cert_id,v_theme_id,'Quelle exception est levée si un fichier n''existe pas avec Files.readString() ?','easy','SINGLE_CHOICE','Files.readString() lève NoSuchFileException (sous-classe de IOException) si le fichier n''existe pas.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','FileNotFoundException',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IOException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','NoSuchFileException',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NullPointerException',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-017',v_cert_id,v_theme_id,'Que fait ''Files.copy(Path.of("src.txt"), Path.of("dst.txt"), StandardCopyOption.REPLACE_EXISTING)'' ?','medium','SINGLE_CHOICE','REPLACE_EXISTING remplace le fichier destination s''il existe. Sinon, sans cette option, FileAlreadyExistsException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Copie le fichier, remplace si existe',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Copie seulement si destination n''existe pas',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Déplace le fichier',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Crée un lien symbolique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-018',v_cert_id,v_theme_id,'Quelle est la différence entre Files.move() et Files.copy() ?','medium','SINGLE_CHOICE','move() déplace/renomme, copy() copie. Sur même système de fichiers, move() est atomique et rapide.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','move() déplace (supprime l''original), copy() copie',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','move() peut renommer, copy() non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','move() plus rapide sur même système',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-019',v_cert_id,v_theme_id,'Que sont les ''memory-mapped files'' dans NIO ?','hard','SINGLE_CHOICE','MappedByteBuffer permet de mapper un fichier en mémoire, traitant le fichier comme un tableau. Très rapide pour accès aléatoire.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Fichiers mappés en mémoire pour accès direct',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utilise FileChannel.map()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Très performant pour les gros fichiers',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-020',v_cert_id,v_theme_id,'Que fait ''Files.lines(Path.of("file.txt"))'' ?','medium','SINGLE_CHOICE','Files.lines() retourne un Stream qui lit les lignes paresseusement. Le stream doit être fermé (try-with-resources).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Retourne un Stream<String> des lignes',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lit tout le fichier en mémoire',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Nécessite try-with-resources',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-021',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Files.list(Path.of("."))
    .filter(Files::isRegularFile)
    .forEach(System.out::println);
```','medium','SINGLE_CHOICE','Files.list() liste le contenu d''un répertoire (non-récursif). Files::isRegularFile filtre les fichiers normaux.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Liste les fichiers du répertoire courant (non-récursif)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Liste tous les fichiers récursivement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Liste les répertoires',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-022',v_cert_id,v_theme_id,'Que signifie ''FileVisitor'' et ''Files.walkFileTree()'' ?','hard','SINGLE_CHOICE','walkFileTree() avec FileVisitor permet un contrôle fin sur le parcours : preVisitDirectory, visitFile, postVisitDirectory, visitFileFailed.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Visite récursive avec actions personnalisées',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permet de parcourir avec pré/post visite',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Gère les erreurs et les liens symboliques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-023',v_cert_id,v_theme_id,'Que fait ''Files.delete(Path.of("file.txt"))'' ?','easy','SINGLE_CHOICE','delete() lève exception si le fichier n''existe pas. Files.deleteIfExists() ne lève pas d''exception.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Supprime le fichier',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lève NoSuchFileException si n''existe pas',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Lève DirectoryNotEmptyException pour répertoire non vide',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-024',v_cert_id,v_theme_id,'Que sont les ''WatchService'' en NIO ?','medium','SINGLE_CHOICE','WatchService (Java 7+) permet de surveiller un répertoire pour des événements : ENTRY_CREATE, ENTRY_DELETE, ENTRY_MODIFY.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Surveille les changements dans un répertoire',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Notifie création, modification, suppression',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utilisé pour recharger automatique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-025',v_cert_id,v_theme_id,'Que sont les ''AsynchronousFileChannel'' ?','hard','SINGLE_CHOICE','AsynchronousFileChannel permet la lecture/écriture asynchrone avec Future ou CompletionHandler (package java.nio.channels).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Opérations I/O asynchrones',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utilise Future ou CompletionHandler',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ne bloque pas le thread appelant',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-026',v_cert_id,v_theme_id,'Que fait ''Files.probeContentType(Path.of("image.png"))'' ?','medium','SINGLE_CHOICE','probeContentType() tente de détecter le type MIME en utilisant les installed FileTypeDetector.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Détecte le type MIME du fichier',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Retourne "image/png"',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Basé sur le contenu ou l''extension',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-027',v_cert_id,v_theme_id,'Comment créer un répertoire temporaire en Java NIO ?','easy','SINGLE_CHOICE','createTempDirectory() peut utiliser le répertoire temporaire par défaut ou un répertoire spécifié.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Files.createTempDirectory("prefix")',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Files.createTempDirectory(Path.of("/tmp"), "prefix")',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Files.createTempDirectory(null, "prefix")',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B sont correctes',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-028',v_cert_id,v_theme_id,'Que fait ''Files.find(Path.of("."), 5, (path, attr) -> attr.isRegularFile() && path.toString().endsWith(".java"))'' ?','medium','SINGLE_CHOICE','Files.find() parcourt récursivement avec profondeur max, utilisant les attributs pour des filtres efficaces.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Cherche fichiers .java jusqu''à profondeur 5',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Retourne un Stream<Path>',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utilise BasicFileAttributes pour éviter I/O',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-029',v_cert_id,v_theme_id,'Que sont les ''SeekableByteChannel'' ?','medium','SINGLE_CHOICE','SeekableByteChannel permet de lire/écrire à n''importe quelle position du fichier (accès aléatoire).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Canal qui supporte position() et truncate()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permet la lecture/écriture à position aléatoire',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Implémenté par FileChannel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-030',v_cert_id,v_theme_id,'Que produit ce code ?
```java
ByteBuffer buffer = ByteBuffer.allocate(10);
buffer.put((byte)1);
buffer.put((byte)2);
buffer.flip();
System.out.println(buffer.get());
System.out.println(buffer.get());
```','hard','SINGLE_CHOICE','flip() prépare le buffer pour la lecture : limit=position, position=0. get() lit dans l''ordre d''écriture.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1 2',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','2 1',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','0 0',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Exception',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-031',v_cert_id,v_theme_id,'Que fait ''buffer.compact()'' ?','hard','SINGLE_CHOICE','compact() copie les données entre position et limit au début, puis position = remaining(), limit = capacity.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Déplace les données non lues au début',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Prépare pour réécriture',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Position = remaining(), limit = capacity',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-032',v_cert_id,v_theme_id,'Quelle est la différence entre ByteBuffer.allocate() et ByteBuffer.allocateDirect() ?','medium','SINGLE_CHOICE','Direct buffers évitent une copie lors des opérations I/O, mais l''allocation est plus coûteuse.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','allocateDirect() utilise mémoire native hors heap',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','allocateDirect() plus performant pour I/O',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','allocate() utilise heap JVM',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-033',v_cert_id,v_theme_id,'Que fait ''try (var reader = new BufferedReader(new FileReader("file.txt")))'' ?','easy','SINGLE_CHOICE','Try-with-resources + var (Java 10+) rend le code concis et sûr (fermeture automatique).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','try-with-resources ferme automatiquement',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','var infère le type',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le bloc finally n''est pas nécessaire',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-034',v_cert_id,v_theme_id,'Que sont les ''ObjectInputStream'' et ''ObjectOutputStream'' ?','medium','SINGLE_CHOICE','ObjectOutputStream écrit des objets Java. ObjectInputStream les lit. Les classes doivent implémenter Serializable.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Sérialisation d''objets Java',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lecture/écriture d''objets complets',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Nécessite Serializable',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-035',v_cert_id,v_theme_id,'Que signifie ''transient'' pour la sérialisation ?','hard','SINGLE_CHOICE','transient empêche la sérialisation d''un champ (mots de passe, données calculées, etc.).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Le champ n''est pas sérialisé',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le champ est ignoré',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Le champ reprend la valeur par défaut après désérialisation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-036',v_cert_id,v_theme_id,'Que sont ''serialVersionUID'' ?','hard','SINGLE_CHOICE','serialVersionUID permet de vérifier que l''émetteur et récepteur ont la même version de classe lors de la sérialisation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Identifiant de version de la classe sérialisée',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Assure la compatibilité entre versions',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Généré automatiquement si non déclaré',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-037',v_cert_id,v_theme_id,'Que fait ''Files.setPosixFilePermissions()'' ?','medium','SINGLE_CHOICE','setPosixFilePermissions() permet de définir les permissions UNIX, sur systèmes compatibles POSIX (Linux, Mac).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Définit les permissions UNIX (rwxr-x---)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Fonctionne seulement sur systèmes POSIX',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utilise Set<PosixFilePermission>',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-038',v_cert_id,v_theme_id,'Que sont les ''attribute views'' (DosFileView, PosixFileView, etc.) ?','medium','SINGLE_CHOICE','Les attribute views donnent accès aux attributs spécifiques à chaque OS (DOS : hidden, readonly ; POSIX : permissions, owner).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Vues spécifiques aux attributs du système',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Accès aux attributs étendus',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Files.getFileAttributeView()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-039',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Path path = Path.of("/tmp/../tmp/file.txt");
System.out.println(path.normalize());
```','medium','SINGLE_CHOICE','normalize() résout ''..''. /tmp/../tmp/file.txt → /tmp/file.txt.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','/tmp/file.txt',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','/tmp/../tmp/file.txt',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','file.txt',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','/file.txt',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-06-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-06-040',v_cert_id,v_theme_id,'Que sont les ''UserDefinedFileAttributeView'' ?','hard','SINGLE_CHOICE','Cette view permet de stocker des attributs arbitraires (clé-valeur) sur les fichiers, si le système de fichiers le supporte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Attributs personnalisés attachés aux fichiers',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Stocke des métadonnées additionnelles',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Disponible sur certains systèmes de fichiers',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-001',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations vraies concernant les buffers dans Java NIO ?','medium','SINGLE_CHOICE','A est correct car un buffer peut être utilisé pour lire et écrire des données. B est incorrect car bien que les buffers aient une taille initiale, cette taille peut être modifiée en utilisant des méthodes spécifiques. C est incorrect car les buffers eux-mêmes ne sont pas non bloquants, mais peuvent être utilisés avec des canaux non bloquants. D est correct car un buffer doit généralement être associé à un canal pour effectuer des opérations d''entrée/sortie.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Un buffer peut être utilisé pour lire et écrire des données.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les buffers ont une taille fixe qui ne peut pas être modifiée après leur création.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Un buffer peut être utilisé pour effectuer des opérations de lecture et d''écriture non bloquantes.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les buffers sont toujours liés à un canal pour effectuer des opérations d''entrée/sortie.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-002',v_cert_id,v_theme_id,'Quelle classe est utilisée pour effectuer des opérations d''entrée/sortie sur un fichier en mode non bloquant dans Java NIO ?','easy','SINGLE_CHOICE','B est correct car FileChannel peut être utilisé dans un mode non bloquant pour effectuer des opérations d''entrée/sortie sur un fichier. A est incorrect car FileInputStream est utilisé pour lire des fichiers en mode bloquant. C est incorrect car RandomAccessFile peut être utilisé pour accéder à des fichiers de manière séquentielle ou aléatoire, mais il n''est pas nécessairement non bloquant. D est incorrect car Selector est utilisé pour gérer plusieurs canaux, mais il n''est pas lui-même une classe d''entrée/sortie.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','FileInputStream',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','FileChannel',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','RandomAccessFile',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Selector',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-003',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant le flux de sortie (OutputStream) :','medium','SINGLE_CHOICE','OutputStream est une classe abstraite, donc A est correct. OutputStream peut effectivement être utilisé pour écrire des données binaires dans un fichier, donc B est correct. FileOutputStream est une implémentation de OutputStream qui écrit des données dans un fichier, donc C est correct. BufferedOutputStream améliore les performances en utilisant un tampon, donc D est correct.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','OutputStream est une classe abstraite.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','OutputStream peut être utilisé pour écrire des données binaires dans un fichier.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','FileOutputStream est une implémentation de OutputStream qui écrit des données dans un fichier.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','BufferedOutputStream améliore les performances en utilisant un tampon.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-004',v_cert_id,v_theme_id,'Quelle classe est utilisée pour lire des fichiers texte avec encodage ?','easy','SINGLE_CHOICE','InputStreamReader est utilisée pour lire des flux d''octets et les convertir en caractères, ce qui inclut l''encodage. FileReader est utilisée pour lire des fichiers texte, mais sans spécifier d''encodage. BufferedReader est utilisé pour améliorer les performances de lecture, mais il ne gère pas l''encodage. FileInputStream est utilisé pour lire des fichiers binaires.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','FileReader',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BufferedReader',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','InputStreamReader',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','FileInputStream',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-005',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant le NIO (New Input/Output) :','hard','SINGLE_CHOICE','NIO permet effectivement de manipuler des fichiers en mode non bloquant, donc A est correct. NIO est basé sur les canaux (channels) et les tampons (buffers), donc B est correct. NIO supporte la lecture asynchrone des fichiers, donc C est incorrect. NIO permet de gérer efficacement des volumes de données importants, donc D est correct.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','NIO permet de manipuler des fichiers en mode non bloquant.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','NIO est basé sur les canaux (channels) et les tampons (buffers).',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','NIO ne supporte pas la lecture asynchrone des fichiers.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NIO permet de gérer efficacement des volumes de données importants.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-006',v_cert_id,v_theme_id,'Quelle classe est utilisée pour écrire des fichiers texte ?','easy','SINGLE_CHOICE','FileWriter est utilisée pour écrire des fichiers texte. BufferedWriter est utilisé pour améliorer les performances de l''écriture, mais il ne gère pas directement les fichiers texte. OutputStreamWriter est utilisée pour écrire des flux d''octets, mais elle nécessite un encodage. FileOutputStream est utilisé pour écrire des fichiers binaires.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','FileWriter',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BufferedWriter',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','OutputStreamWriter',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','FileOutputStream',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-007',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les buffers dans NIO :','medium','SINGLE_CHOICE','Les buffers dans NIO peuvent être de différents types (ByteBuffer, CharBuffer, etc.), donc A est correct. Les buffers ont une capacité fixe qui peut être modifiée en utilisant le méthode compact(), donc B est incorrect. Les buffers permettent de gérer efficacement les données en entrée/sortie, donc C est correct. Les buffers peuvent être réinitialisés après leur utilisation en utilisant le méthode clear() ou rewind(), donc D est incorrect.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les buffers peuvent être de différents types (ByteBuffer, CharBuffer, etc.).',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les buffers ont une capacité fixe qui ne peut pas être modifiée.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les buffers permettent de gérer efficacement les données en entrée/sortie.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les buffers ne peuvent pas être réinitialisés après leur utilisation.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-008',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant les canaux (Channels) en Java NIO :','medium','SINGLE_CHOICE','Option A est correcte car les canaux en Java NIO sont conçus pour lire et écrire des données. Option B est incorrecte car les canaux ne sont pas toujours associés à un flux, ils peuvent être utilisés de manière indépendante. Option C est correcte car les canaux supportent l''asynchronisme, ce qui les rend très utiles dans des applications nécessitant une gestion efficace des E/S. Option D est incorrecte car les canaux peuvent en effet être utilisés avec des fichiers, ce qui facilite la manipulation de données sur le disque.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les canaux peuvent être utilisés pour lire et écrire des données.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les canaux sont toujours associés à un flux (Stream).',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les canaux supportent l''asynchronisme.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les canaux ne peuvent pas être utilisés avec des fichiers.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-009',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour ouvrir un fichier en lecture seule dans Java NIO ?','easy','SINGLE_CHOICE','Option B est correcte car Files.newInputStream(path) est la méthode utilisée pour ouvrir un fichier en lecture seule dans Java NIO. Option A est incorrecte car elle utilise StandardOpenOption.READ, qui peut être utilisé pour ouvrir un fichier en lecture et écriture. Option C est incorrecte car elle crée un nouveau fichier, ce qui n''est pas pour ouvrir en lecture seule. Option D est incorrecte car elle supprime un fichier, ce qui n''est pas pour ouvrir en lecture seule.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Files.open(path, StandardOpenOption.READ)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Files.newInputStream(path)',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Files.createFile(path)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Files.delete(path)',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-010',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant les buffers en Java NIO :','hard','SINGLE_CHOICE','Option A est correcte car les buffers en Java NIO peuvent être alloués de manière dynamique, ce qui leur permet d''adapter leur taille en fonction des besoins. Option B est incorrecte car bien que les buffers aient une capacité fixe, ils peuvent être redimensionnés en utilisant la méthode compact() ou clear(). Option C est correcte car les buffers supportent l''ordre des octets, ce qui est particulièrement utile lors de la manipulation de données binaires. Option D est incorrecte car les buffers peuvent être utilisés non seulement avec les canaux, mais aussi directement avec des flux (Streams).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Les buffers peuvent être alloués de manière dynamique.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Les buffers ont une capacité fixe et ne peuvent pas être redimensionnés.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Les buffers supportent l''ordre des octets (byte order).',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les buffers ne peuvent être utilisés qu''avec les canaux.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-FIE-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='flux_i_o_et_nio' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-FIE-011',v_cert_id,v_theme_id,'Quelle classe est utilisée pour lire des fichiers texte en Java NIO avec un encodage spécifique ?','medium','SINGLE_CHOICE','Option D est correcte car Files.newBufferedReader(path, Charset.forName("UTF-8")) est la méthode utilisée pour lire des fichiers texte en Java NIO avec un encodage spécifique. Option A est incorrecte car FileReader ne supporte pas de spécifier l''encodage. Option B est incorrecte car BufferedReader est un flux de caractères qui ne permet pas de spécifier l''encodage. Option C est incorrecte car InputStreamReader est un flux d''octets qui nécessite un InputStream, mais elle ne permet pas de spécifier directement l''encodage lors de la lecture d''un fichier.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','FileReader',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BufferedReader',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','InputStreamReader',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Files.newBufferedReader(path, Charset.forName("UTF-8"))',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-001',v_cert_id,v_theme_id,'Comment créer un thread en Java ?','easy','SINGLE_CHOICE','Trois façons : extends Thread, implements Runnable, ou utiliser ExecutorService (recommandé).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Étendre Thread',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Implémenter Runnable',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser ExecutorService',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-002',v_cert_id,v_theme_id,'Quelle méthode démarre l''exécution d''un thread ?','easy','SINGLE_CHOICE','start() crée un nouveau thread et appelle run(). run() direct n''exécute pas dans un nouveau thread.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','run()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','start()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','execute()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','begin()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-003',v_cert_id,v_theme_id,'Que fait ''Thread.sleep(1000)'' ?','easy','SINGLE_CHOICE','sleep() suspend le thread, mais ne libère pas les locks qu''il détient. InterruptedException peut être levée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Met le thread en pause pour 1000ms',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lève InterruptedException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ne libère pas les locks',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-004',v_cert_id,v_theme_id,'Que fait ''Thread.yield()'' ?','easy','SINGLE_CHOICE','yield() est un hint au scheduler pour céder le CPU. Peut être ignoré. Utile pour le testing.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Indique qu''on veut céder le processeur',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ne garantit rien (hint seulement)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ne libère pas les locks',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-005',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Thread t = new Thread(() -> System.out.print("A"));
t.run();
System.out.print("B");
```','medium','SINGLE_CHOICE','t.run() appelle run() directement dans le thread courant, pas de nouveau thread. Donc A puis B.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AB',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BA',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','A B (ordre variable)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-006',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Thread t = new Thread(() -> System.out.print("A"));
t.start();
System.out.print("B");
```','medium','SINGLE_CHOICE','start() crée un nouveau thread. L''ordre d''exécution entre les deux threads n''est pas garanti.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AB',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','BA',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','AB ou BA (ordre non déterminé)',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-007',v_cert_id,v_theme_id,'Que signifie ''synchronized'' ?','easy','SINGLE_CHOICE','synchronized assure exclusion mutuelle et visibilité mémoire (flush/refresh des caches).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Un seul thread peut exécuter le bloc/méthode à la fois',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Garantit la visibilité mémoire',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Établit une relation happens-before',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-008',v_cert_id,v_theme_id,'Quelle est la différence entre synchronized méthode et synchronized bloc ?','medium','SINGLE_CHOICE','synchronized méthode lock sur this (ou Class pour static). Bloc permet lock sur n''importe quel objet.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Méthode = lock sur this, bloc = lock sur objet spécifique',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Bloc permet plus de contrôle (lock plus fin)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Méthode est équivalente à synchronized(this)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-009',v_cert_id,v_theme_id,'Que fait ''wait()'' ?','medium','SINGLE_CHOICE','wait() libère le lock et attend. Nécessite d''avoir le lock sur l''objet. Se réveille avec notify().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Met le thread en attente, libère le lock',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Doit être appelé dans synchronized',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Attend jusqu''à notify()/notifyAll()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-010',v_cert_id,v_theme_id,'Que fait ''notify()'' ?','medium','SINGLE_CHOICE','notify() réveille un thread arbitraire en wait(). notifyAll() réveille tous les threads en wait().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réveille un thread en wait sur cet objet',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le thread réveillé doit reacquérir le lock',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ne garantit pas quel thread est réveillé',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-011',v_cert_id,v_theme_id,'Que produit ce code ?
```java
synchronized(this) {
    this.wait();
    System.out.print("A");
}
```','medium','SINGLE_CHOICE','wait() doit être appelé dans un bloc synchronized. Sans notify(), le thread attend indéfiniment.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Affiche A',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Bloque indéfiniment (si pas notify)',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IllegalMonitorStateException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur compilation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-012',v_cert_id,v_theme_id,'Que sont ''volatile'' variables ?','hard','SINGLE_CHOICE','volatile assure visibilité entre threads, mais pas d''atomicité pour i++ (non atomique).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Garantit la visibilité (pas d''atomicité)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lecture/écriture directement en mémoire (pas de cache thread)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plus léger que synchronized',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-013',v_cert_id,v_theme_id,'volatile est-il suffisant pour un compteur partagé (counter++) ?','hard','SINGLE_CHOICE','counter++ est lecture+incrémentation+écriture, non atomique. volatile ne suffit pas → utiliser AtomicInteger ou synchronized.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui, volatile garantit atomicité',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non, counter++ n''est pas atomique',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, si counter est volatile',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Non, même avec volatile, besoin de synchronized ou AtomicInteger',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-014',v_cert_id,v_theme_id,'Qu''est-ce qu''une ''deadlock'' ?','medium','SINGLE_CHOICE','Deadlock : situation où chaque thread attend un lock détenu par un autre. Programme bloqué indéfiniment.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Deux threads bloqués attendant mutuellement les locks',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Thread 1 lock A attend B, Thread 2 lock B attend A',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Situation qui ne se résout pas sans intervention',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-015',v_cert_id,v_theme_id,'Comment éviter les deadlocks ?','medium','SINGLE_CHOICE','Stratégies : ordre fixe, tryLock() avec timeout, éviter locks imbriqués, utiliser lock striping.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Acquérir les locks dans un ordre fixe',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utiliser tryLock() avec timeout',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Limiter l''utilisation des locks',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-016',v_cert_id,v_theme_id,'Que sont les ''locks'' dans java.util.concurrent.locks ?','medium','SINGLE_CHOICE','ReentrantLock offre tryLock() (non-bloquant), lockInterruptibly(), et Conditions multiples.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ReentrantLock (plus flexible que synchronized)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','tryLock(), lockInterruptibly()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Condition (remplace wait/notify)',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-017',v_cert_id,v_theme_id,'Quelle est la différence entre ReentrantLock et synchronized ?','medium','SINGLE_CHOICE','ReentrantLock est plus flexible mais plus verbeux. synchronized est plus simple pour les cas basiques.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ReentrantLock peut être interrompu (lockInterruptibly)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ReentrantLock a tryLock() non-bloquant',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ReentrantLock supporte Conditions multiples',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-018',v_cert_id,v_theme_id,'Que fait ''ReentrantLock.tryLock()'' ?','medium','SINGLE_CHOICE','tryLock() tente sans bloquer. tryLock(1, TimeUnit.SECONDS) attend jusqu''à 1 seconde.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Tente d''acquérir le lock, retourne true/false immédiatement',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ne bloque pas',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Peut avoir un timeout',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-019',v_cert_id,v_theme_id,'Qu''est-ce que ''ReadWriteLock'' ?','medium','SINGLE_CHOICE','ReadWriteLock permet accès concurrent en lecture, exclusif en écriture. ReentrantReadWriteLock est l''implémentation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Sépare lock lecture (partagé) et écriture (exclusif)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plusieurs lecteurs simultanés, un seul écrivain',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Meilleures performances pour lectures fréquentes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-020',v_cert_id,v_theme_id,'Qu''est-ce que ''StampedLock'' (Java 8) ?','hard','SINGLE_CHOICE','StampedLock offre optimistic read (tryOptimisticRead()) pour des lectures sans blocage si pas d''écriture.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Optimistic locking pour lectures',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Convertible (upgrade/downgrade)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plus performant que ReadWriteLock',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-021',v_cert_id,v_theme_id,'Qu''est-ce qu''ExecutorService ?','easy','SINGLE_CHOICE','ExecutorService gère un pool de threads. Utiliser Executors.newFixedThreadPool() ou .newCachedThreadPool().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Pool de threads',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Sépare soumission de tâches de l''exécution',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Gère le cycle de vie des threads',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-022') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-022',v_cert_id,v_theme_id,'Que fait ''ExecutorService.submit(Callable)'' ?','medium','SINGLE_CHOICE','Callable retourne une valeur et peut lever une exception (contrairement à Runnable). Future.get() récupère la valeur.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Retourne un Future<T>',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Tâche retourne une valeur',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Peut lever une exception',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-023') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-023',v_cert_id,v_theme_id,'Que fait ''Future.get()'' ?','medium','SINGLE_CHOICE','get() bloque. get(1, TimeUnit.SECONDS) avec timeout lève TimeoutException si dépassé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Bloque jusqu''à résultat disponible',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lève ExecutionException si tâche a échoué',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Peut avoir timeout',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-024') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-024',v_cert_id,v_theme_id,'Que fait ''Future.cancel(true)'' ?','medium','SINGLE_CHOICE','cancel() tente d''annuler. mayInterruptIfRunning=true interrompt le thread si en cours d''exécution.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Tente d''annuler la tâche',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Interrompt le thread si true',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Retourne false si déjà terminée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-025') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-025',v_cert_id,v_theme_id,'Que sont les ''atomic classes'' (AtomicInteger, AtomicReference) ?','medium','SINGLE_CHOICE','AtomicInteger offre incrementAndGet(), compareAndSet() atomiques via instructions CPU (CAS).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Opérations atomiques sans locks',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Basées sur CAS (Compare-And-Swap)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plus performantes que synchronized',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-026') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-026',v_cert_id,v_theme_id,'Que produit ce code avec AtomicInteger ?
```java
AtomicInteger ai = new AtomicInteger(0);
ai.incrementAndGet();
System.out.println(ai.get());
```','medium','SINGLE_CHOICE','incrementAndGet() incrémente atomiquement et retourne la nouvelle valeur (1).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','0',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','2',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Dépend du thread',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-027') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-027',v_cert_id,v_theme_id,'Que sont les ''CompletableFuture'' ?','hard','SINGLE_CHOICE','CompletableFuture (Java 8+) permet la programmation asynchrone déclarative, similaire à Promise/async-await.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Composition asynchrone de tâches',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','thenApply(), thenCompose(), thenCombine()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Exceptionally(), handle() pour erreurs',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-028') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-028',v_cert_id,v_theme_id,'Que fait ''CompletableFuture.supplyAsync(() -> compute())'' ?','hard','SINGLE_CHOICE','supplyAsync() exécute une tâche qui retourne une valeur, asynchrone. thenAccept() pour consommer résultat.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Exécute compute() asynchrone',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Retourne CompletableFuture<T>',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utilise ForkJoinPool.commonPool() par défaut',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-029') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-029',v_cert_id,v_theme_id,'Que sont les ''virtual threads'' (Java 21) ?','hard','SINGLE_CHOICE','Virtual threads (Project Loom) sont des threads utilisateur très légers. Thread.startVirtualThread() ou Executors.newVirtualThreadPerTaskExecutor().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Threads légers gérés par la JVM',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Millions de threads sans overhead',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Thread.start() sur virtual thread',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-030') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-030',v_cert_id,v_theme_id,'Comment créer un virtual thread en Java 21 ?','hard','SINGLE_CHOICE','Trois façons : startVirtualThread(), Thread.ofVirtual(), ou ExecutorService dédié.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Thread.startVirtualThread(() -> task())',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Thread.ofVirtual().start(task)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Executors.newVirtualThreadPerTaskExecutor()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-031') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-031',v_cert_id,v_theme_id,'Que sont les ''ThreadLocal'' ?','medium','SINGLE_CHOICE','ThreadLocal stocke une valeur par thread. Utilisé pour SimpleDateFormat thread-safe, ou contexte par requête.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Variables propres à chaque thread',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Chaque thread a sa copie',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utile pour éviter le partage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-032') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-032',v_cert_id,v_theme_id,'Que risque-t-on avec ThreadLocal ?','medium','SINGLE_CHOICE','Dans un thread pool, les threads sont réutilisés. Sans remove(), les valeurs persistent entre tâches.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Memory leak (si thread pool)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oubli de remove()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Valeur persistante entre requêtes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-033') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-033',v_cert_id,v_theme_id,'Que sont les ''BlockingQueue'' ?','medium','SINGLE_CHOICE','BlockingQueue est parfaite pour pattern producteur-consommateur. offer()/poll() non-bloquants aussi disponibles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','File d''attente thread-safe avec blocage',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','put() bloque si pleine, take() bloque si vide',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Implémentations : ArrayBlockingQueue, LinkedBlockingQueue',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-034') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-034',v_cert_id,v_theme_id,'Que sont les ''ConcurrentHashMap'' ?','medium','SINGLE_CHOICE','ConcurrentHashMap permet accès concurrent sans bloquer toute la map. computeIfAbsent() est atomique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','HashMap thread-safe',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lock striping (plusieurs segments)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Meilleures performances que Hashtable',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-035') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-035',v_cert_id,v_theme_id,'Que sont les ''LongAdder'' vs ''AtomicLong'' ?','hard','SINGLE_CHOICE','LongAdder (Java 8+) divise le compteur en cellules, mieux pour mises à jour fréquentes, lectures rares.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','LongAdder plus performant en haute concurrence',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','LongAdder utilise striping (plusieurs cellules)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','AtomicLong pour faible concurrence',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-036') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-036',v_cert_id,v_theme_id,'Que sont les ''Phaser'' (Java 7+) ?','hard','SINGLE_CHOICE','Phaser permet synchronisation par phases, où le nombre de participants peut changer dynamiquement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Barrière plus flexible que CyclicBarrier',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Permet phases dynamiques',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','arriveAndAwaitAdvance()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-037') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-037',v_cert_id,v_theme_id,'Que sont ''CountDownLatch'' ?','medium','SINGLE_CHOICE','CountDownLatch attend que N événements arrivent. Une fois à zéro, ne peut être réinitialisé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Compte à rebours, await() bloque jusqu''à zéro',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Usage unique (non réutilisable)',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','countDown() décrémente',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-038') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-038',v_cert_id,v_theme_id,'Que sont ''CyclicBarrier'' ?','medium','SINGLE_CHOICE','CyclicBarrier permet synchronisation de N threads. reset() pour réutilisation. Diffère de CountDownLatch (usage unique).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Attend que N threads arrivent à un point',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réutilisable (reset())',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Action optionnelle quand barrière franchie',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-039') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-039',v_cert_id,v_theme_id,'Que sont ''Semaphore'' ?','medium','SINGLE_CHOICE','Semaphore gère un nombre de permits. Semaphore(3) permet 3 accès simultanés. Binaire = Mutex.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Contrôle le nombre d''accès simultanés',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','acquire() / release()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Permet de limiter des ressources',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-040') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-040',v_cert_id,v_theme_id,'Que sont ''Exchanger'' ?','medium','SINGLE_CHOICE','Exchanger<V> permet à deux threads d''échanger des objets de façon synchrone.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Point d''échange entre deux threads',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','exchange(obj) bloque jusqu''à autre thread',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Échange des objets mutuellement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-041') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-041',v_cert_id,v_theme_id,'Qu''est-ce que ''ForkJoinPool'' ?','hard','SINGLE_CHOICE','ForkJoinPool est conçu pour RecursiveTask. parallelStream() l''utilise. Work-stealing équilibre la charge.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Pool pour tâches récursives (divide and conquer)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Work-stealing algorithm',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utilisé par parallel streams',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-042') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-042',v_cert_id,v_theme_id,'Que sont les ''Structured Concurrency'' (Java 21 preview) ?','hard','SINGLE_CHOICE','StructuredTaskScope (incubateur Java 21) traite les threads comme des unités de travail avec début/fin explicite.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Concurrence structurée (comme les appels)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Fork/join avec scope explicite',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Prévient les fuites de threads',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-043') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-043',v_cert_id,v_theme_id,'Que fait ''Thread.interrupt()'' ?','medium','SINGLE_CHOICE','interrupt() ne force pas l''arrêt mais signale. Le thread doit vérifier isInterrupted() ou attraper InterruptedException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Demande l''interruption du thread',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réveille le thread si en wait/sleep',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','set flag d''interruption',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-044') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-044',v_cert_id,v_theme_id,'Comment répondre correctement à une interruption ?','medium','SINGLE_CHOICE','Si on ne peut pas lever InterruptedException, appeler interrupt() pour restaurer le flag.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Restaurer le flag : Thread.currentThread().interrupt()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lever InterruptedException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Arrêter proprement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-045') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-045',v_cert_id,v_theme_id,'Que sont les ''deadlock detection tools'' ?','hard','SINGLE_CHOICE','Programmatiquement : ThreadMXBean. Outils : jstack, jconsole, VisualVM détectent les deadlocks.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ThreadMXBean.findDeadlockedThreads()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','jstack, VisualVM',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','JConsole',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-046') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-046',v_cert_id,v_theme_id,'Que sont les ''happens-before'' relationships ?','medium','SINGLE_CHOICE','Happens-before définit quand une écriture est visible par une autre lecture. Essentiel pour le threading correct.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Garanties mémoire du JMM',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Synchronized, volatile, start() créent happens-before',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Garantit visibilité des écritures',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-047') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-047',v_cert_id,v_theme_id,'Qu''est-ce que ''false sharing'' ?','hard','SINGLE_CHOICE','False sharing : threads sur CPU différents écrivent dans variables proches en mémoire (même ligne de cache).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Plusieurs threads écrivent dans même cache line',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Dégradation de performance',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Solution : padding ou @Contended',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-048') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-048',v_cert_id,v_theme_id,'Qu''est-ce que ''lock striping'' ?','hard','SINGLE_CHOICE','Lock striping : plusieurs locks pour différentes parties des données. ConcurrentHashMap utilise 16 segments par défaut.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Diviser une structure en segments avec locks distincts',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utilisé par ConcurrentHashMap',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réduit contention',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-049') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-049',v_cert_id,v_theme_id,'Que sont les ''CopyOnWriteArrayList'' ?','medium','SINGLE_CHOICE','CopyOnWriteArrayList est thread-safe. Les écritures créent une nouvelle copie, les lectures sont lock-free.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Créée copie à chaque modification',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Idéal pour lectures fréquentes, modifications rares',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Iterateurs ne lèvent pas ConcurrentModificationException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-07-050') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-07-050',v_cert_id,v_theme_id,'Qu''est-ce que ''race condition'' ?','hard','SINGLE_CHOICE','Race condition : comportement incorrect dû à un timing non contrôlé. Exemple : if(!map.containsKey(key)) map.put(key, value).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Résultat dépend de l''ordre d''exécution des threads',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Check-then-act, read-modify-write',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Corrigé par synchronisation',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-001',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la synchronisation en Java :','medium','SINGLE_CHOICE','La méthode synchronized peut être utilisée sur des méthodes et des blocs, donc l''option A est correcte. Le mot-clé volatile ne garantit pas l''ordre d''exécution des instructions, donc l''option B est incorrecte. L''utilisation de Locks offre plus de flexibilité que synchronized, donc l''option C est correcte. Les classes dans java.util.concurrent.locks peuvent être utilisées pour la synchronisation, donc l''option D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La méthode synchronized peut être utilisée sur des méthodes et des blocs.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le mot-clé volatile garantit l''ordre d''exécution des instructions.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''utilisation de Locks offre plus de flexibilité que synchronized.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les classes dans java.util.concurrent.locks ne peuvent pas être utilisées pour la synchronisation.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-002',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour attendre que tous les threads d''un ExecutorService aient terminé leur exécution ?','easy','SINGLE_CHOICE','La méthode awaitTermination() est utilisée pour attendre que tous les threads d''un ExecutorService aient terminé leur exécution, donc l''option B est correcte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','shutdown()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','awaitTermination()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','join()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','terminate()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-003',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant l''utilisation de ReentrantLock :','hard','SINGLE_CHOICE','ReentrantLock peut être utilisé comme une alternative à synchronized, donc l''option A est correcte. ReentrantLock ne permet pas de bloquer un thread indéfiniment si le lock n''est pas disponible, donc l''option B est incorrecte. ReentrantLock peut être utilisé dans des blocs try-with-resources, donc l''option C est incorrecte. ReentrantLock offre la possibilité de tenter d''acquérir le lock sans attendre, donc l''option D est correcte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ReentrantLock peut être utilisé comme une alternative à synchronized.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ReentrantLock permet de bloquer un thread indéfiniment si le lock n''est pas disponible.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ReentrantLock ne peut pas être utilisé dans des blocs try-with-resources.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ReentrantLock offre la possibilité de tenter d''acquérir le lock sans attendre.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-004',v_cert_id,v_theme_id,'Quelle classe est utilisée pour créer un thread en Java ?','easy','SINGLE_CHOICE','La classe Thread est utilisée pour créer un thread en Java, donc l''option A est correcte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Thread',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Runnable',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ExecutorService',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Callable',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-005',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe CountDownLatch :','medium','SINGLE_CHOICE','CountDownLatch est utilisé pour attendre que plusieurs opérations aient terminé, donc l''option A est correcte. CountDownLatch ne peut pas être réinitialisé après son utilisation, donc l''option B est incorrecte. CountDownLatch est thread-safe, donc l''option C est correcte. CountDownLatch peut être utilisé plusieurs fois, donc l''option D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','CountDownLatch est utilisé pour attendre que plusieurs opérations aient terminé.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','CountDownLatch peut être réinitialisé après son utilisation.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','CountDownLatch est thread-safe.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','CountDownLatch ne peut être utilisé qu''une seule fois.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-006',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la synchronisation en Java :','medium','SINGLE_CHOICE','La méthode synchronized peut être utilisée sur des méthodes et des blocs, ce qui est correct. Le mot-clé volatile garantit que les threads lisent toujours la dernière valeur d''une variable, ce qui est également correct. L''utilisation de locks explicites avec ReentrantLock offre plus de flexibilité que synchronized, ce qui est correct. Les classes dans java.util.concurrent sont généralement thread-safe, donc cette affirmation est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La méthode synchronized peut être utilisée sur des méthodes et des blocs.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Le mot-clé volatile garantit que les threads lisent toujours la dernière valeur d''une variable.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''utilisation de locks explicites avec ReentrantLock offre plus de flexibilité que synchronized.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les classes dans java.util.concurrent ne sont pas thread-safe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-007',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour attendre que tous les threads d''un ExecutorService aient terminé leur exécution ?','easy','SINGLE_CHOICE','La méthode awaitTermination() est utilisée pour attendre que tous les threads d''un ExecutorService aient terminé leur exécution. shutdown() demande à l''ExecutorService de ne plus accepter de nouvelles tâches et d''arrêter les threads en cours, mais ne bloque pas l''appelant jusqu''à ce que tous les threads aient terminé. terminate() et stop() ne sont pas des méthodes valides pour ExecutorService.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','shutdown()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','awaitTermination()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','terminate()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','stop()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-008',v_cert_id,v_theme_id,'Quelles sont les DEUX affirmations vraies concernant la classe ReentrantLock ?','hard','SINGLE_CHOICE','ReentrantLock peut être utilisé pour implémenter des sémaphores, ce qui est correct. ReentrantLock offre une meilleure performance que synchronized dans certains cas, mais pas toujours, donc cette affirmation est incorrecte. ReentrantLock permet d''essayer d''acquérir un lock sans bloquer en utilisant tryLock(), ce qui est correct. ReentrantLock supporte les conditions via Condition, donc cette affirmation est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ReentrantLock peut être utilisé pour implémenter des sémaphores.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ReentrantLock offre une meilleure performance que synchronized dans tous les cas.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ReentrantLock permet d''essayer d''acquérir un lock sans bloquer.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ReentrantLock ne supporte pas les conditions.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-009',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour signaler à un autre thread qu''une condition a été satisfaite ?','easy','SINGLE_CHOICE','La méthode signal() est utilisée pour signaler à un autre thread qu''une condition a été satisfaite. notify() est une méthode de l''objet Object et signal() est une méthode de Condition dans java.util.concurrent.locks. broadcast() n''est pas une méthode standard pour signaler des conditions et alert() n''existe pas dans Java.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','notify()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','signal()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','broadcast()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','alert()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-010',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la classe ConcurrentHashMap :','medium','SINGLE_CHOICE','ConcurrentHashMap est thread-safe, ce qui est correct. ConcurrentHashMap permet des lectures concurrentes sans verrous, ce qui est également correct. ConcurrentHashMap n''est généralement pas moins performant que HashMap dans tous les cas, donc cette affirmation est incorrecte. ConcurrentHashMap supporte la méthode putIfAbsent(), donc cette affirmation est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ConcurrentHashMap est thread-safe.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ConcurrentHashMap permet des lectures concurrentes sans verrous.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ConcurrentHashMap est moins performant que HashMap dans tous les cas.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ConcurrentHashMap ne supporte pas la méthode putIfAbsent().',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-011',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la synchronisation en Java :','medium','SINGLE_CHOICE','La méthode synchronized peut être utilisée sur des méthodes et des blocs, donc Option A est correcte. Un lock peut être utilisé pour synchroniser l''accès à une section de code, donc Option B est correcte. L''utilisation de synchronized peut entraîner des deadlocks si pas géré correctement, donc Option C est correcte. Les locks sont disponibles dans la bibliothèque java.util.concurrent, donc Option D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La méthode synchronized peut être utilisée sur des méthodes et des blocs.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Un lock peut être utilisé pour synchroniser l''accès à une section de code.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''utilisation de synchronized peut entraîner des deadlocks si pas géré correctement.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les locks ne sont pas disponibles dans la bibliothèque java.util.concurrent.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-012',v_cert_id,v_theme_id,'Quelle méthode permet de créer un thread en Java ?','easy','SINGLE_CHOICE','La méthode ExecutorService.execute() permet de créer un thread en Java, donc Option C est correcte. Thread.start() démarre le thread mais ne crée pas un nouveau, donc Option A est incorrecte. Thread.run() exécute le code dans le même thread, donc Option B est incorrecte. Runnable.run() est une méthode qui doit être implémentée dans la classe Runnable, mais elle ne crée pas un thread, donc Option D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Thread.start()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Thread.run()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ExecutorService.execute()',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Runnable.run()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-014',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour libérer un lock dans ReentrantLock ?','medium','SINGLE_CHOICE','La méthode unlock() est utilisée pour libérer un lock dans ReentrantLock, donc Option B est correcte. release(), free() et releaseLock() ne sont pas des méthodes valides pour ReentrantLock, donc Options A, C et D sont incorrectes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ReentrantLock.release()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ReentrantLock.unlock()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ReentrantLock.free()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ReentrantLock.releaseLock()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-015',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant l''interface Runnable :','easy','SINGLE_CHOICE','Runnable doit être implémenté pour créer un thread, donc Option B est correcte. La méthode run() dans Runnable peut lancer des exceptions, donc Option C est correcte. Runnable doit être étendu pour créer un thread, donc Option A est incorrecte. Runnable n''est pas une classe abstraite mais une interface, donc Option D est incorrecte.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Runnable doit être étendu pour créer un thread.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Runnable doit être implémenté pour créer un thread.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','La méthode run() dans Runnable peut lancer des exceptions.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Runnable est une classe abstraite.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-015',v_cert_id,v_theme_id,'Sélectionnez TOUTES les affirmations correctes concernant la synchronisation en Java :','medium','SINGLE_CHOICE','Option A est correcte car la méthode synchronized peut être utilisée sur des méthodes et des blocs de code. Option B est correcte car le mot-clé volatile garantit la visibilité des modifications de variable entre threads. Option C est correcte car java.util.concurrent offre une API plus flexible avec Lock. Option D est incorrecte car de nombreuses classes de java.util.concurrent sont thread-safe.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','La méthode synchronized peut être utilisée sur des méthodes et des blocs de code.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','L''utilisation du mot-clé volatile garantit que les modifications d''une variable sont visibles par tous les threads.',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','L''interface Lock fournit un mécanisme plus flexible que synchronized pour la gestion des verrous.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Les classes de l''API java.util.concurrent ne sont pas thread-safe.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-016',v_cert_id,v_theme_id,'Quelle méthode est utilisée pour attendre que tous les threads d''un ExecutorService aient terminé leur exécution ?','easy','SINGLE_CHOICE','Option B est correcte car awaitTermination() attend que tous les threads aient terminé leur exécution. Option A est incorrecte car shutdown() arrête l''acceptation de nouvelles tâches mais ne bloque pas la terminaison des tâches en cours. Option C est incorrecte car terminate() n''est pas une méthode de l''API ExecutorService. Option D est incorrecte car join() est utilisé pour attendre la fin d''un thread, pas pour un ExecutorService.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','shutdown()',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','awaitTermination()',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','terminate()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','join()',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='JAVA21-MEC-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='multithreading_et_concurrence' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'JAVA21-MEC-017',v_cert_id,v_theme_id,'Quelles sont les DEUX propositions vraies concernant la classe ReentrantLock :','hard','SINGLE_CHOICE','Option B est correcte car ReentrantLock peut être utilisé dans un bloc try-with-resources pour s''assurer que le lock est toujours libéré. Option D est correcte car ReentrantLock supporte des timeouts lors de l''acquisition du lock. Option A est incorrecte car ReentrantLock est en fait reentrant. Option C est incorrecte car ReentrantLock supporte les conditions via la méthode newCondition().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ReentrantLock est non-reentrant.',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ReentrantLock peut être utilisé dans un bloc try-with-resources pour s''assurer que le lock est toujours libéré.',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ReentrantLock ne supporte pas les conditions.',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ReentrantLock peut être utilisé avec des timeouts.',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-001') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-001',v_cert_id,v_theme_id,'Quelle est la syntaxe correcte d''une expression lambda ?','easy','SINGLE_CHOICE','Lambda peut être : (x) -> x+1 (expression) ou (x) -> { return x+1; } (bloc). Les parenthèses peuvent être omises pour un seul paramètre.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','(param) -> expression',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','(param) -> { return expression; }',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','(param) -> { expression; }',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-002') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-002',v_cert_id,v_theme_id,'Quelle interface fonctionnelle représente une fonction avec un paramètre et un retour ?','easy','SINGLE_CHOICE','Function<T,R> : applique une fonction à T et retourne R. Consumer<T> : consomme sans retour. Supplier<T> : fournit sans paramètre.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Consumer<T>',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Function<T,R>',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Supplier<T>',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Predicate<T>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-003') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-003',v_cert_id,v_theme_id,'Quelle interface fonctionnelle est utilisée pour les conditions (retourne boolean) ?','easy','SINGLE_CHOICE','Predicate<T> : test(T) retourne boolean. Utilisé pour filter(), anyMatch(), allMatch(), noneMatch().','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Function<T,R>',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Predicate<T>',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Consumer<T>',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Supplier<T>',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-004') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-004',v_cert_id,v_theme_id,'Quelle interface fonctionnelle ne prend aucun paramètre et retourne une valeur ?','easy','SINGLE_CHOICE','Supplier<T> : get() retourne T. Utilisé pour générer des valeurs (ex: generate(Supplier)).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Function<T,R>',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Predicate<T>',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Consumer<T>',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Supplier<T>',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-005') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-005',v_cert_id,v_theme_id,'Quelle annotation indique qu''une interface est fonctionnelle ?','easy','SINGLE_CHOICE','@FunctionalInterface est optionnelle mais recommandée. Le compilateur vérifie qu''il n''y a qu''une seule méthode abstraite.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','@Functional',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','@FunctionalInterface',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','@Lambda',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','@SingleMethod',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-006') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-006',v_cert_id,v_theme_id,'Quelle est la sortie de ce code ?
```java
List<String> list = Arrays.asList("a", "b", "c");
list.forEach(System.out::print);
```','easy','SINGLE_CHOICE','forEach applique l''action à chaque élément. System.out::print est une référence de méthode. Résultat : abc.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','abc',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','a b c',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','[a, b, c]',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-007') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-007',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Stream.of(1, 2, 3)
    .map(x -> x * 2)
    .forEach(System.out::print);
```','medium','SINGLE_CHOICE','map(x -> x*2) transforme 1→2, 2→4, 3→6. forEach affiche 246.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','123',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','246',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','2 4 6',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-008') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-008',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Stream.of(1, 2, 3, 4, 5)
    .filter(x -> x % 2 == 0)
    .count();
```','medium','SINGLE_CHOICE','filter garde les nombres pairs : 2,4 → count() = 2.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','2',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','3',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','4',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','5',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-009') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-009',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Stream.of("a", "bb", "ccc")
    .map(String::length)
    .reduce(0, Integer::sum);
```','medium','SINGLE_CHOICE','map en longueurs : 1,2,3. reduce(0, Integer::sum) = 1+2+3 = 6.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','6',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1+2+3=6',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','0',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-010') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-010',v_cert_id,v_theme_id,'Que fait l''opération terminale ''collect(Collectors.toList())'' ?','easy','SINGLE_CHOICE','collect est une opération terminale qui accumule les éléments dans une collection (List, Set, Map).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Convertit le stream en List',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Termine le stream',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Matérialise les résultats',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-011') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-011',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Stream.of(1, 2, 2, 3, 3, 3)
    .distinct()
    .count();
```','medium','SINGLE_CHOICE','distinct() supprime les doublons : 1,2,3 → count() = 3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','6',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','3',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','2',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','4',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-012') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-012',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Stream.of(3, 1, 4, 1, 5)
    .sorted()
    .limit(3)
    .forEach(System.out::print);
```','medium','SINGLE_CHOICE','sorted() trie : 1,1,3,4,5. limit(3) garde les 3 premiers : 1,1,3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','314',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','134',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','135',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','113',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-013') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-013',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Stream.iterate(0, n -> n + 2)
    .limit(5)
    .forEach(System.out::print);
```','medium','SINGLE_CHOICE','iterate(0, n->n+2) génère : 0,2,4,6,8. limit(5) → 02468.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','02468',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','13579',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','01234',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','24680',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-014') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-014',v_cert_id,v_theme_id,'Que sont les ''primitive streams'' (IntStream, LongStream, DoubleStream) ?','hard','SINGLE_CHOICE','IntStream évite Integer, offre range(), sum(), average(). mapToInt(), boxed() pour conversion.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Streams optimisés pour primitifs',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Évitent l''autoboxing',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Méthodes spécifiques : sum(), average(), range()',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-015') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-015',v_cert_id,v_theme_id,'Que produit ce code ?
```java
IntStream.range(1, 5)
    .forEach(System.out::print);
```','medium','SINGLE_CHOICE','range(1,5) génère 1,2,3,4 (exclut le 5). rangeClosed(1,5) inclut 5.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','1234',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','12345',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','01234',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','1 2 3 4',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-016') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-016',v_cert_id,v_theme_id,'Que sont les ''parallel streams'' ?','hard','SINGLE_CHOICE','parallelStream() utilise ForkJoinPool. Peut améliorer performances pour grandes données, mais overhead pour petites.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Streams exécutés en parallèle',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','parallelStream() ou .parallel()',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Attention aux opérations non thread-safe',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-017') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-017',v_cert_id,v_theme_id,'Que produit ce code ?
```java
List<Integer> list = Arrays.asList(1, 2, 3);
list.parallelStream()
    .forEach(System.out::print);
```','medium','SINGLE_CHOICE','L''ordre d''exécution en parallèle n''est pas garanti. forEachOrdered() garantit l''ordre.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','123',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','321',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ordre non garanti',TRUE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Erreur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-018') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-018',v_cert_id,v_theme_id,'Que fait ''Optional.ofNullable(value)'' ?','medium','SINGLE_CHOICE','ofNullable accepte null et retourne Optional.empty(). of() ne l''accepte pas.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Crée Optional vide si null, sinon Optional avec valeur',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Optional.of(value) lève NPE si null',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optional.ofNullable est plus sûr',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-019') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-019',v_cert_id,v_theme_id,'Que produit ce code ?
```java
Optional<String> opt = Optional.of("Hello");
System.out.println(opt.orElse("Default"));
```','medium','SINGLE_CHOICE','orElse() retourne la valeur si présente, sinon la valeur par défaut.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Hello',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Default',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optional[Hello]',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','null',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-020') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-020',v_cert_id,v_theme_id,'Que fait ''opt.orElseThrow(() -> new RuntimeException())'' ?','medium','SINGLE_CHOICE','orElseThrow() (Java 10+) remplace get() qui lève NoSuchElementException.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Retourne la valeur ou lève l''exception',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lève exception si Optional vide',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Alternative à get() avec meilleur message',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='J21-08-021') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='lambda_streams_et_api_fonctionnelle' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'J21-08-021',v_cert_id,v_theme_id,'Que fait ''opt.ifPresent(System.out::println)'' ?','medium','SINGLE_CHOICE','ifPresent() exécute le Consumer seulement si valeur présente.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Affiche la valeur si présente, rien sinon',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Équivalent à if(opt.isPresent()) println',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ne lève pas d''exception',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
END $$;
