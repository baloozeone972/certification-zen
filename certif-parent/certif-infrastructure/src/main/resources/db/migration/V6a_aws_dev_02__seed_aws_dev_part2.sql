-- V6a_aws_dev_02__seed_aws_dev_part2.sql
-- aws_dev: questions 151–300
-- Idempotent via legacy_id check

-- AWS_DEV: 150 questions
DO $$
DECLARE
    v_cert_id TEXT := 'aws_dev';
    v_theme_id UUID; v_q_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Cert % absent', v_cert_id; RETURN; END IF;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'dynamodb','DynamoDB',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'s3_storage','S3 & Storage',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'ci_cd_codesuite','CI/CD (CodeSuite)',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-151') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-151',v_cert_id,v_theme_id,'Combien de LSI peut-on créer par table ?','hard','SINGLE_CHOICE','Maximum 5 LSI par table.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','5',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','10',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','20',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-152') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-152',v_cert_id,v_theme_id,'Combien de GSI peut-on créer par table ?','hard','SINGLE_CHOICE','Maximum 20 GSI par table (par défaut).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','20',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','5',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','10',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','50',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-153') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-153',v_cert_id,v_theme_id,'Différence entre lecture éventuellement cohérente et fortement cohérente ?','hard','SINGLE_CHOICE','Les lectures fortement cohérentes utilisent 2 RCU, les éventuellement cohérentes 0.5 RCU.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Eventual = moins chère, plus rapide; Strong = plus chère, garantit le dernier écrit',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Identiques',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Strong moins chère',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Eventual garantit le dernier écrit',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-154') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-154',v_cert_id,v_theme_id,'Par défaut, les lectures DynamoDB sont-elles fortement cohérentes ?','hard','SINGLE_CHOICE','Les lectures par défaut sont éventuellement cohérentes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non (éventuellement cohérentes)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Dépend du mode capacité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-155') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-155',v_cert_id,v_theme_id,'DynamoDB supporte-t-il les transactions ACID ?','hard','SINGLE_CHOICE','Les transactions offrent des garanties ACID sur plusieurs éléments.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les écritures',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les lectures',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-156') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-156',v_cert_id,v_theme_id,'Quelles opérations sont supportées dans les transactions ?','hard','SINGLE_CHOICE','Deux opérations transactionnelles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','TransactGetItems, TransactWriteItems',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','GetItem seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','PutItem seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','UpdateItem seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-157') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-157',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB Accelerator (DAX) ?','hard','SINGLE_CHOICE','DAX est un cache Redis compatible DynamoDB pour des lectures microsecondes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Cache in-memory pour DynamoDB',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Migration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-158') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-158',v_cert_id,v_theme_id,'DAX est-il compatible avec l''API DynamoDB ?','hard','SINGLE_CHOICE','DAX est compatible avec l''API DynamoDB (GetItem, Query, Scan).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les lectures',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-159') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-159',v_cert_id,v_theme_id,'DAX est-il écrit en lecture ou écriture ?','hard','SINGLE_CHOICE','DAX est un cache de lecture seulement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lecture seulement',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lecture/écriture',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Écriture seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cache uniquement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-160') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-160',v_cert_id,v_theme_id,'Qu''est-ce que DynamoDB Streams ?','hard','SINGLE_CHOICE','Streams capture les modifications (création, mise à jour, suppression).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Flux de changements en temps réel',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Migration',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-161') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-161',v_cert_id,v_theme_id,'Combien de temps les données sont-elles conservées dans DynamoDB Streams ?','hard','SINGLE_CHOICE','La rétention par défaut est 24 heures (configurable jusqu''à 7 jours).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','24 heures',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','7 jours',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','30 jours',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','48 heures',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-162') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-162',v_cert_id,v_theme_id,'Qu''est-ce qu''une DynamoDB Global Table ?','hard','SINGLE_CHOICE','Les Global Tables répliquent les données dans plusieurs régions, lecture/écriture partout.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Table multi-région multi-actif',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Table répliquée',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Table partitionnée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Table indexée',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-163') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-163',v_cert_id,v_theme_id,'Global Tables nécessite-t-il l''activation des streams ?','hard','SINGLE_CHOICE','Global Tables utilise DynamoDB Streams pour la réplication.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les nouvelles tables',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-164') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-164',v_cert_id,v_theme_id,'À quoi sert DynamoDB TTL ?','hard','SINGLE_CHOICE','TTL marque les éléments pour suppression automatique à une date.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Suppression automatique après délai',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Expiration de cache',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Timeout de lecture',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Limite de temps',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-165') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-165',v_cert_id,v_theme_id,'TTL supprime-t-il immédiatement les éléments ?','hard','SINGLE_CHOICE','La suppression est asynchrone et peut prendre jusqu''à 48 heures.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, suppression asynchrone dans les 48h',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui, immédiatement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Dans les 24h',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Dans les 72h',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-166') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-166',v_cert_id,v_theme_id,'Quels types de backup DynamoDB supporte-t-il ?','hard','SINGLE_CHOICE','Les backups on-demand sont complets, PITR permet la restauration à n''importe quel moment.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','On-demand et Point-in-Time Recovery (PITR)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','On-demand seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','PITR seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Snapshots seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-167') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-167',v_cert_id,v_theme_id,'Quelle est la période de rétention de PITR ?','hard','SINGLE_CHOICE','PITR permet de restaurer à n''importe quelle seconde dans les 35 derniers jours.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','35 jours',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','7 jours',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','90 jours',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','1 an',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-168') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-168',v_cert_id,v_theme_id,'Quelle opération est la plus efficace pour trouver des éléments ?','hard','SINGLE_CHOICE','Query utilise la clé de partition (plus efficace). Scan lit toute la table.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Query',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Scan',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','GetItem',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','BatchGetItem',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-169') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-169',v_cert_id,v_theme_id,'Scan consomme-t-il plus de RCU que Query ?','hard','SINGLE_CHOICE','Scan lit tous les éléments, donc consomme plus de RCU.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Identique',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Dépend de la taille des résultats',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-170') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-170',v_cert_id,v_theme_id,'Comment paginer les résultats de Query/Scan ?','hard','SINGLE_CHOICE','La pagination utilise LastEvaluatedKey pour obtenir la page suivante.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','LastEvaluatedKey / ExclusiveStartKey',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Offset / Limit',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Page / Size',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','NextToken / PreviousToken',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-171') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-171',v_cert_id,v_theme_id,'BatchGetItem peut-il lire jusqu''à combien d''éléments ?','hard','SINGLE_CHOICE','BatchGetItem peut lire jusqu''à 100 éléments (ou 16 Mo).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','100',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','25',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','50',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','200',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-172') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-172',v_cert_id,v_theme_id,'BatchWriteItem peut-il écrire jusqu''à combien d''éléments ?','hard','SINGLE_CHOICE','BatchWriteItem peut écrire jusqu''à 25 éléments (ou 16 Mo).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','25',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','10',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','50',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','100',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-173') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-173',v_cert_id,v_theme_id,'À quoi servent les écritures conditionnelles ?','hard','SINGLE_CHOICE','Les écritures conditionnelles (ConditionExpression) évitent les race conditions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Vérifier une condition avant d''écrire',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Forcer l''écriture',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Ignorer l''écriture',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Journaliser l''écriture',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-174') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-174',v_cert_id,v_theme_id,'Quelle exception est levée si la condition échoue ?','hard','SINGLE_CHOICE','ConditionalCheckFailedException indique que la condition n''est pas satisfaite.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ConditionalCheckFailedException',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ValidationException',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','ResourceNotFoundException',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','InternalServerError',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-175') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-175',v_cert_id,v_theme_id,'Comment implémenter un compteur atomique dans DynamoDB ?','hard','SINGLE_CHOICE','ADD (UpdateItem) permet des incrémentations atomiques.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','UpdateItem avec ADD',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','GetItem + PutItem',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','BatchWriteItem',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','TransactWriteItems',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-176') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-176',v_cert_id,v_theme_id,'Quels types d''expressions sont supportés ?','hard','SINGLE_CHOICE','Plusieurs expressions pour différents usages.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ConditionExpression, UpdateExpression, FilterExpression, KeyConditionExpression',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement ConditionExpression',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement UpdateExpression',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement FilterExpression',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-177') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-177',v_cert_id,v_theme_id,'À quoi sert FilterExpression ?','hard','SINGLE_CHOICE','FilterExpression s''applique après la lecture, n''affecte pas la capacité consommée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Filtrer les résultats après Query/Scan',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Filtrer avant Query/Scan',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Filtrer les écritures',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Filtrer les clés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-178') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-178',v_cert_id,v_theme_id,'Pourquoi utiliser ExpressionAttributeNames ?','hard','SINGLE_CHOICE','ExpressionAttributeNames permet d''utiliser des noms d''attributs qui sont des mots réservés.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Échapper les mots réservés',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Raccourcir les noms',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Rendre les expressions plus lisibles',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Optimiser les performances',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-179') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-179',v_cert_id,v_theme_id,'À quoi servent ExpressionAttributeValues ?','hard','SINGLE_CHOICE','ExpressionAttributeValues évite l''injection et permet de réutiliser les expressions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Passer des valeurs dans les expressions',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Définir des valeurs par défaut',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Créer des constantes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Optimiser les requêtes',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-180') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-180',v_cert_id,v_theme_id,'Quels types de données sont supportés par DynamoDB ?','hard','SINGLE_CHOICE','DynamoDB supporte plusieurs types de données.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Scalaires (S, N, B), Document (M, L), Sets (SS, NS, BS)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement scalaires',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement document',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement sets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-181') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-181',v_cert_id,v_theme_id,'DynamoDB peut-il stocker des documents JSON ?','hard','SINGLE_CHOICE','Les types Map (M) et List (L) permettent de stocker des documents JSON.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (type M ou L)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec DAX',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Streams',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-182') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-182',v_cert_id,v_theme_id,'Comment insérer un document JSON dans DynamoDB ?','hard','SINGLE_CHOICE','JSON est converti en Map (objet) et List (tableau).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser un Map',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Convertir en String',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser un Set',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Utiliser un Binary',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-183') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-183',v_cert_id,v_theme_id,'Pourquoi éviter les clés de partition monotones (timestamp) ?','hard','SINGLE_CHOICE','Les clés monotones concentrent les écritures sur une seule partition.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Créer des hotspots',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plus lent',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plus cher',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Moins sécurisé',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-184') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-184',v_cert_id,v_theme_id,'Comment distribuer uniformément la charge ?','hard','SINGLE_CHOICE','Le sharding (suffixe aléatoire) distribue les écritures sur plusieurs partitions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ajouter un suffixe aléatoire (sharding)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utiliser un timestamp',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser une séquence',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Utiliser une clé unique',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-185') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-185',v_cert_id,v_theme_id,'Comment modéliser une relation one-to-many dans DynamoDB ?','hard','SINGLE_CHOICE','Le pattern d''adjacence utilise la clé de tri pour les relations.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Clé de partition parent, clé de tri enfant',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Deux tables',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Document imbriqué',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-186') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-186',v_cert_id,v_theme_id,'Comment implémenter le pattern d''adjacence (adjacency list) ?','hard','SINGLE_CHOICE','Le pattern d''adjacence utilise une seule table avec PK et SK pour représenter les relations.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','PK = parent, SK = enfant',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','PK = enfant, SK = parent',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Table séparée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Index GSI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-187') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-187',v_cert_id,v_theme_id,'Comment gérer les requêtes multi-conditions (filtres) ?','hard','SINGLE_CHOICE','GSI ou Scan avec filtre selon le volume de données.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser un GSI avec clé composite',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Scan avec FilterExpression',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plusieurs requêtes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-188') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-188',v_cert_id,v_theme_id,'Que faire en cas de ProvisionedThroughputExceededException ?','hard','SINGLE_CHOICE','Retry avec backoff ou augmenter la capacité.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Retry avec backoff exponentiel',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Augmenter la capacité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réduire la capacité',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-189') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-189',v_cert_id,v_theme_id,'Quel est le mécanisme de retry du SDK AWS ?','hard','SINGLE_CHOICE','Le SDK AWS implémente des retries automatiques avec backoff exponentiel.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Retry automatique avec backoff',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Aucun retry',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Retry illimité',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Retry sans backoff',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-190') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-190',v_cert_id,v_theme_id,'Quelles métriques CloudWatch sont importantes pour DynamoDB ?','hard','SINGLE_CHOICE','Surveiller la consommation et les throttling.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ConsumedReadCapacityUnits, ConsumedWriteCapacityUnits, ThrottledRequests',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement ThrottledRequests',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement ConsumedCapacity',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement Latency',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-191') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-191',v_cert_id,v_theme_id,'Comment détecter des hotspots (partition chaude) ?','hard','SINGLE_CHOICE','Les métriques par partition sont disponibles dans CloudWatch.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','CloudWatch metrics par partition (OperationLatency)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Scan de la table',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Logs CloudTrail',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','DAX',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-192') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-192',v_cert_id,v_theme_id,'Comment développer localement avec DynamoDB ?','hard','SINGLE_CHOICE','DynamoDB Local peut être exécuté via Docker ou JAR.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','DynamoDB Local',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','AWS SAM local',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Docker',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-193') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-193',v_cert_id,v_theme_id,'DynamoDB Local supporte-t-il toutes les fonctionnalités ?','hard','SINGLE_CHOICE','Quelques fonctionnalités (comme les Global Tables) ne sont pas supportées localement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non (certaines fonctionnalités manquent)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Partiellement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement les API de base',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-194') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-194',v_cert_id,v_theme_id,'Quelles permissions IAM sont nécessaires pour DynamoDB ?','hard','SINGLE_CHOICE','Les permissions dépendent des opérations nécessaires.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','dynamodb:GetItem, PutItem, UpdateItem, DeleteItem, Query, Scan',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement GetItem',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement PutItem',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement Query',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-195') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-195',v_cert_id,v_theme_id,'Peut-on restreindre l''accès par attribut ?','hard','SINGLE_CHOICE','Les politiques IAM peuvent limiter l''accès à certains attributs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (ConditionExpression)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement par clé',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement par table',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-196') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-196',v_cert_id,v_theme_id,'DynamoDB chiffre-t-il les données au repos par défaut ?','hard','SINGLE_CHOICE','Le chiffrement au repos est activé par défaut (AWS owned CMK).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les tables avec DAX',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-197') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-197',v_cert_id,v_theme_id,'Peut-on utiliser une clé KMS personnalisée ?','hard','SINGLE_CHOICE','On peut choisir une clé KMS (Customer Managed CMK) lors de la création de la table.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les backups',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les streams',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-198') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-198',v_cert_id,v_theme_id,'DynamoDB peut-il exporter des données vers S3 ?','hard','SINGLE_CHOICE','L''export to S3 (DynamoDB Backup) permet d''exporter au format DynamoDB JSON ou Ion.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (export to S3)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement via EMR',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement via Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-199') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-199',v_cert_id,v_theme_id,'DynamoDB peut-il importer des données depuis S3 ?','hard','SINGLE_CHOICE','L''import depuis S3 supporte CSV, DynamoDB JSON, Ion.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement via EMR',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement via Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-200') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-200',v_cert_id,v_theme_id,'Qu''est-ce que PartiQL pour DynamoDB ?','hard','SINGLE_CHOICE','PartiQL permet d''interroger DynamoDB avec une syntaxe similaire à SQL.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Langage de requête SQL-like',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','API de streaming',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Outil de migration',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Client SDK',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-201') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-201',v_cert_id,v_theme_id,'PartiQL supporte-t-il les opérations d''écriture ?','hard','SINGLE_CHOICE','PartiQL supporte les opérations DML (INSERT, UPDATE, DELETE).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (INSERT, UPDATE, DELETE)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Lecture seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement SELECT',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-202') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-202',v_cert_id,v_theme_id,'À quoi sert NoSQL Workbench for DynamoDB ?','hard','SINGLE_CHOICE','NoSQL Workbench aide à concevoir et tester les modèles DynamoDB.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Modélisation, visualisation, requêtage local',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Migration',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Backup',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Monitoring',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-203') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-203',v_cert_id,v_theme_id,'Comment intégrer DynamoDB et Lambda efficacement ?','hard','SINGLE_CHOICE','Streams pour réactivité, appel direct pour requêtes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Streams + Lambda',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lambda appelle directement DynamoDB',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','DAX + Lambda',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et B',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-204') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-204',v_cert_id,v_theme_id,'API Gateway peut-il s''intégrer directement à DynamoDB ?','hard','SINGLE_CHOICE','API Gateway peut appeler DynamoDB directement via l''intégration AWS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (intégration AWS)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement via Lambda',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement via VTL',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-205') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-205',v_cert_id,v_theme_id,'AWS AppSync peut-il utiliser DynamoDB comme source de données ?','hard','SINGLE_CHOICE','AppSync a une intégration native avec DynamoDB pour GraphQL.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec Lambda',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Aurora',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-206') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-206',v_cert_id,v_theme_id,'EMR peut-il lire/écrire dans DynamoDB ?','hard','SINGLE_CHOICE','EMR peut interagir avec DynamoDB via Hadoop/Hive.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement en lecture',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement en écriture',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-207') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-207',v_cert_id,v_theme_id,'AWS Glue peut-il extraire des données de DynamoDB ?','hard','SINGLE_CHOICE','Glue peut lire DynamoDB comme source ETL.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec ETL',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Crawlers',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-208') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-208',v_cert_id,v_theme_id,'Athena peut-il interroger DynamoDB ?','hard','SINGLE_CHOICE','Un connecteur Athena pour DynamoDB existe (via Lambda).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui (via Connector)',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec EMR',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Glue',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-209') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-209',v_cert_id,v_theme_id,'QuickSight peut-il se connecter directement à DynamoDB ?','hard','SINGLE_CHOICE','QuickSight a un connecteur natif pour DynamoDB.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement via Athena',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement via Glue',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-210') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='dynamodb' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-210',v_cert_id,v_theme_id,'Comment optimiser les coûts DynamoDB ?','hard','SINGLE_CHOICE','Plusieurs stratégies pour optimiser les coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser On-Demand pour les charges variables',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utiliser l''auto-scaling',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser DAX pour les lectures répétées',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-211') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-211',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un objet S3 ?','easy','SINGLE_CHOICE','La taille maximale d''un objet S3 est 5 To.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','5 To',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1 To',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','500 Go',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','10 To',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-212') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-212',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un PUT unique sur S3 ?','easy','SINGLE_CHOICE','Un PUT unique est limité à 5 Go. Au-delà, utiliser le multipart upload.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','5 Go',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1 Go',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','500 Mo',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','10 Go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-213') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-213',v_cert_id,v_theme_id,'Qu''est-ce que le multipart upload ?','medium','SINGLE_CHOICE','Multipart upload divise les gros fichiers en parties uploadées en parallèle.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Upload d''objets en plusieurs parties',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Upload en parallèle',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Upload de gros fichiers',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-214') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-214',v_cert_id,v_theme_id,'Combien de parties maximum pour un multipart upload ?','medium','SINGLE_CHOICE','Maximum 10 000 parties par objet (chaque partie entre 5 Mo et 5 Go).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','10 000',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1000',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','100',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','50 000',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-215') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-215',v_cert_id,v_theme_id,'Quelle classe de stockage S3 est la moins chère ?','easy','SINGLE_CHOICE','Glacier Deep Archive est la classe la moins chère (récupération en 12-48h).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','S3 Glacier Deep Archive',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','S3 Glacier Flexible Retrieval',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','S3 Standard-IA',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','S3 One Zone-IA',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-216') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-216',v_cert_id,v_theme_id,'Quelle classe de stockage est pour les données consultées rarement ?','medium','SINGLE_CHOICE','Standard-IA (Infrequent Access) pour accès peu fréquents.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','S3 Standard-IA',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','S3 Standard',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','S3 Glacier',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','S3 Intelligent-Tiering',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-217') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-217',v_cert_id,v_theme_id,'Quelle classe de stockage réplique les données sur une seule AZ ?','hard','SINGLE_CHOICE','One Zone-IA stocke uniquement dans une AZ (moins chère mais moins résiliente).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','S3 One Zone-IA',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','S3 Standard',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','S3 Standard-IA',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','S3 Intelligent-Tiering',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-218') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-218',v_cert_id,v_theme_id,'Peut-on désactiver le versioning après l''avoir activé ?','hard','SINGLE_CHOICE','Une fois activé, on ne peut que suspendre, pas désactiver.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non, seulement suspendre',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Oui, avec délai',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement après suppression du bucket',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-219') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-219',v_cert_id,v_theme_id,'Qu''est-ce que S3 MFA Delete ?','hard','SINGLE_CHOICE','MFA Delete exige une authentification MFA pour supprimer des versions.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Suppression nécessitant MFA',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Suppression automatique',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Suppression en masse',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Suppression définitive',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-220') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-220',v_cert_id,v_theme_id,'Qu''est-ce que S3 Object Lock ?','hard','SINGLE_CHOICE','Object Lock protège contre les suppressions (WORM).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Empêche la suppression/modification pendant une période',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Verrouille l''objet',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Chiffre l''objet',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Versionne l''objet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-221') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-221',v_cert_id,v_theme_id,'À quoi sert une pre-signed URL S3 ?','hard','SINGLE_CHOICE','Pre-signed URL donne un accès temporaire à un objet privé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Accès temporaire à un objet privé',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Accès permanent',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Accès public',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Accès chiffré',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-222') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-222',v_cert_id,v_theme_id,'Quelle est la durée de validité maximale d''une pre-signed URL ?','hard','SINGLE_CHOICE','La durée maximale est de 7 jours (par défaut 1 heure).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','7 jours',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1 jour',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','12 heures',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','30 jours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-223') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-223',v_cert_id,v_theme_id,'Quels sont les types de chiffrement S3 ?','hard','SINGLE_CHOICE','SSE-S3 (clés AWS), SSE-KMS (clés KMS), SSE-C (clés client).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','SSE-S3, SSE-KMS, SSE-C',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','SSE-S3 seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SSE-KMS seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','SSE-C seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-224') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-224',v_cert_id,v_theme_id,'Qu''est-ce que le chiffrement côté client ?','hard','SINGLE_CHOICE','Client-side encryption : le client chiffre avant d''envoyer à S3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Chiffrement avant upload',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Chiffrement par AWS',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Chiffrement par KMS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Chiffrement par S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-225') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-225',v_cert_id,v_theme_id,'Qu''est-ce qu''une bucket policy S3 ?','hard','SINGLE_CHOICE','Les bucket policies sont des politiques resource-based pour S3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Politique IAM attachée au bucket',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Politique attachée à l''utilisateur',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Politique attachée au rôle',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Politique attachée à l''objet',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-226') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-226',v_cert_id,v_theme_id,'Quelle condition restreint l''accès à une adresse IP ?','hard','SINGLE_CHOICE','aws:SourceIp restreint l''accès à une plage d''adresses IP.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','aws:SourceIp',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','aws:SourceVpc',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','aws:SourceArn',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','s3:x-amz-server-side-encryption',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-227') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-227',v_cert_id,v_theme_id,'Comment rendre un bucket public ?','hard','SINGLE_CHOICE','Plusieurs conditions nécessaires pour rendre un bucket public.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Bucket policy avec Principal: ''*'' et Action: ''s3:GetObject''',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ACL publique',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Block Public Access désactivé',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-228') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-228',v_cert_id,v_theme_id,'Pourquoi configurer CORS sur un bucket S3 ?','hard','SINGLE_CHOICE','CORS permet à des sites web de différents domaines d''accéder aux ressources S3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Permettre des requêtes cross-origin depuis un site web',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Augmenter la sécurité',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Accélérer les transferts',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Compresser les données',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-229') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-229',v_cert_id,v_theme_id,'S3 peut-il héberger un site web statique ?','hard','SINGLE_CHOICE','S3 supporte l''hébergement de sites web statiques (HTML, CSS, JS).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec CloudFront',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Route53',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-230') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-230',v_cert_id,v_theme_id,'Quel est le endpoint pour un site web statique S3 ?','hard','SINGLE_CHOICE','Le endpoint de site web est différent du endpoint REST.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','bucket-name.s3-website-region.amazonaws.com',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','bucket-name.s3.amazonaws.com',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','bucket-name.cloudfront.net',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','bucket-name.s3-website.amazonaws.com',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-231') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-231',v_cert_id,v_theme_id,'S3 peut-il envoyer des notifications à Lambda ?','hard','SINGLE_CHOICE','S3 Event Notifications peut cibler Lambda, SNS, SQS, EventBridge.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement à SNS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement à SQS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-232') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-232',v_cert_id,v_theme_id,'Quels types d''événements S3 peuvent déclencher des notifications ?','hard','SINGLE_CHOICE','Plusieurs types d''événements S3 sont supportés.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','s3:ObjectCreated:*, s3:ObjectRemoved:*, s3:ObjectRestore:*',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement Put',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement Delete',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Tous',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-233') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-233',v_cert_id,v_theme_id,'Qu''est-ce que S3 Replication ?','hard','SINGLE_CHOICE','La réplication copie automatiquement les objets vers un bucket de destination.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Réplique les objets vers un autre bucket',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Copie les objets',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Sauvegarde les objets',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Archive les objets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-234') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-234',v_cert_id,v_theme_id,'Quels sont les types de réplication S3 ?','hard','SINGLE_CHOICE','CRR vers une autre région, SRR dans la même région.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Cross-Region (CRR) et Same-Region (SRR)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Cross-Region seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Same-Region seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Multi-Region',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-235') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-235',v_cert_id,v_theme_id,'S3 CRR réplique-t-il les objets existants par défaut ?','hard','SINGLE_CHOICE','CRR réplique uniquement les nouveaux objets, pas les existants.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Versioning',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-236') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-236',v_cert_id,v_theme_id,'À quoi servent les S3 Lifecycle policies ?','hard','SINGLE_CHOICE','Les lifecycle policies automatisent le cycle de vie des objets.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Transition et expiration des objets',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Réplication',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Versioning',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-237') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-237',v_cert_id,v_theme_id,'Quels sont les types d''actions dans une Lifecycle Policy ?','hard','SINGLE_CHOICE','Transition (changement de classe) et Expiration (suppression).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Transition et Expiration',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Transition seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Expiration seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Replication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-238') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-238',v_cert_id,v_theme_id,'Qu''est-ce qu''un S3 Access Point ?','hard','SINGLE_CHOICE','Les Access Points simplifient la gestion des permissions par application.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Point d''accès avec politique spécifique',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Endpoint VPC',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','URL personnalisée',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Load balancer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-239') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-239',v_cert_id,v_theme_id,'Un Access Point peut-il être restreint à un VPC ?','hard','SINGLE_CHOICE','On peut configurer un Access Point pour qu''il ne soit accessible que depuis un VPC spécifique.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (VPC-only)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec PrivateLink',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec Endpoint',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-240') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-240',v_cert_id,v_theme_id,'Qu''est-ce que S3 Object Lambda ?','hard','SINGLE_CHOICE','S3 Object Lambda modifie les données retournées par S3 GET.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Transforme les données à la volée lors des GET S3',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lambda sur S3',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Lambda pour les événements S3',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Lambda pour la réplication',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-241') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-241',v_cert_id,v_theme_id,'Object Lambda reçoit-il l''objet original de S3 ?','hard','SINGLE_CHOICE','Lambda reçoit une URL pour récupérer l''objet original.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (via un presigned URL)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement les métadonnées',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement le nom',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-242') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-242',v_cert_id,v_theme_id,'Qu''est-ce que S3 Select ?','hard','SINGLE_CHOICE','S3 Select permet d''extraire des sous-ensembles de données (CSV, JSON).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Interroge des données dans S3 sans les télécharger',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Sélectionne des objets',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Filtre des objets',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Jointure',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-243') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-243',v_cert_id,v_theme_id,'Quels formats sont supportés par S3 Select ?','hard','SINGLE_CHOICE','S3 Select supporte CSV, JSON et Parquet.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','CSV, JSON, Parquet',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','CSV seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','JSON seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','XML seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-244') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-244',v_cert_id,v_theme_id,'À quoi servent les S3 Batch Operations ?','hard','SINGLE_CHOICE','Batch Operations exécute des actions sur de grands ensembles d''objets.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Opérations en masse sur des objets',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Traitement batch',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Copy, tag, restore',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-245') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-245',v_cert_id,v_theme_id,'S3 Batch Operations utilise-t-il Lambda ?','hard','SINGLE_CHOICE','Les tâches personnalisées peuvent invoquer Lambda.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (invocation optionnelle)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les tâches personnalisées',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les rapports',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-246') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-246',v_cert_id,v_theme_id,'Qu''est-ce que S3 Transfer Acceleration ?','hard','SINGLE_CHOICE','Transfer Acceleration utilise CloudFront edge locations pour accélérer les uploads.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Accélère les transferts via edge locations',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Compresse les fichiers',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Chiffre les données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Versionne les objets',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-247') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-247',v_cert_id,v_theme_id,'Qu''est-ce que S3 Storage Lens ?','hard','SINGLE_CHOICE','Storage Lens fournit des métriques agrégées sur l''utilisation S3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Analyse d''utilisation et métriques',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lentille de stockage',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Outil de monitoring',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Dashboard',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-248') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-248',v_cert_id,v_theme_id,'Storage Lens propose-t-il des recommandations ?','hard','SINGLE_CHOICE','Storage Lens fournit des recommandations d''optimisation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les coûts',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour la sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-249') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-249',v_cert_id,v_theme_id,'Qu''est-ce qu''un Multi-Region Access Point ?','hard','SINGLE_CHOICE','Multi-Region Access Points simplifient l''accès aux données répliquées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Point d''accès unique pour plusieurs régions',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Bucket multi-région',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Réplication globale',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','CDN',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-250') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-250',v_cert_id,v_theme_id,'Quel est le débit maximum par préfixe S3 ?','hard','SINGLE_CHOICE','Par préfixe, 3 500 requêtes PUT/POST/DELETE et 5 500 GET/HEAD par seconde.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','3 500 PUT/ 5 500 GET par seconde',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','100 par seconde',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','10 000 par seconde',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Illimité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-251') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-251',v_cert_id,v_theme_id,'Comment améliorer les performances S3 ?','hard','SINGLE_CHOICE','Des clés aléatoires améliorent la distribution, Transfer Acceleration accélère les uploads.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Utiliser des clés d''objet aléatoires',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Utiliser des préfixes',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Transfer Acceleration',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-252') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-252',v_cert_id,v_theme_id,'Qu''est-ce qu''EBS ?','easy','SINGLE_CHOICE','EBS est le stockage bloc pour EC2.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Elastic Block Store',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Elastic Bulk Storage',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Elastic Backup Storage',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Elastic Byte Storage',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-253') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-253',v_cert_id,v_theme_id,'Quel type de volume EBS est SSD généraliste ?','medium','SINGLE_CHOICE','gp2/gp3 sont les volumes SSD à usage général.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','gp2/gp3',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','io1/io2',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','st1',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','sc1',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-254') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-254',v_cert_id,v_theme_id,'Qu''est-ce qu''un snapshot EBS ?','hard','SINGLE_CHOICE','Les snapshots EBS sont incrémentaux (seuls les blocs modifiés sont sauvegardés).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Sauvegarde incrémentale',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Copie complète',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Archive',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Clone',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-255') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-255',v_cert_id,v_theme_id,'Qu''est-ce qu''EFS ?','easy','SINGLE_CHOICE','EFS est un système de fichiers NFS partagé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Elastic File System (NFS)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Elastic Block Store',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Elastic Container Service',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Elastic Compute Service',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-256') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-256',v_cert_id,v_theme_id,'EFS peut-il être monté sur plusieurs instances EC2 ?','hard','SINGLE_CHOICE','EFS est conçu pour être partagé entre plusieurs instances.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec EFS Multi-AZ',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec EFS One Zone',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-257') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-257',v_cert_id,v_theme_id,'Quels sont les classes de stockage EFS ?','hard','SINGLE_CHOICE','EFS Standard, EFS-IA (Infrequent Access), EFS Archive.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Standard, Infrequent Access, Archive',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Standard seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Infrequent Access seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Archive seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-258') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-258',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Storage Gateway ?','hard','SINGLE_CHOICE','Storage Gateway intègre le stockage on-premise avec AWS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Passerelle entre on-premise et AWS',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de stockage',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Base de données',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-259') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-259',v_cert_id,v_theme_id,'Quels sont les types de Storage Gateway ?','hard','SINGLE_CHOICE','Quatre types pour différents cas d''usage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','S3 File Gateway, FSx File Gateway, Volume Gateway, Tape Gateway',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','S3 Gateway seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Volume Gateway seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Tape Gateway seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-260') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-260',v_cert_id,v_theme_id,'AWS Backup peut-il sauvegarder des volumes EBS ?','hard','SINGLE_CHOICE','AWS Backup supporte EBS, RDS, DynamoDB, EFS, FSx, S3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour RDS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-261') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-261',v_cert_id,v_theme_id,'À quoi sert AWS Snow Family ?','hard','SINGLE_CHOICE','Snow Family (Snowcone, Snowball, Snowmobile) transfère des données physiquement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Transfert de données physiques',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Archive',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-262') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-262',v_cert_id,v_theme_id,'Quel est le plus petit appareil Snow Family ?','hard','SINGLE_CHOICE','Snowcone est le plus petit (2,1 kg, 8 To).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Snowcone',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Snowball Edge',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Snowmobile',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Snowball',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-263') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-263',v_cert_id,v_theme_id,'Quand utiliser S3 plutôt que EBS ?','hard','SINGLE_CHOICE','S3 pour stockage objet scalable, EBS pour volumes attachés à EC2.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Stockage objet illimité',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Base de données',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Système de fichiers partagé',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Volume boot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-264') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-264',v_cert_id,v_theme_id,'Quand utiliser EFS plutôt que EBS ?','hard','SINGLE_CHOICE','EFS pour partage NFS entre plusieurs instances.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Partage de fichiers entre instances',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Volume boot',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Haute performance',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Faible coût',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-265') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-265',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS DataSync ?','hard','SINGLE_CHOICE','DataSync transfère des données entre on-premise et AWS ou entre services AWS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Service de transfert de données automatisé',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Backup',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Archive',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Cache',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-266') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-266',v_cert_id,v_theme_id,'DataSync supporte-t-il la vérification d''intégrité ?','hard','SINGLE_CHOICE','DataSync vérifie l''intégrité des données pendant le transfert.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Optionnel',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-267') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-267',v_cert_id,v_theme_id,'Comment réduire les coûts S3 ?','hard','SINGLE_CHOICE','Les lifecycle policies et le choix de classe de stockage réduisent les coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lifecycle policies, classes de stockage',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plus de versions',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plus de réplication',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-268') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-268',v_cert_id,v_theme_id,'Comment sécuriser un bucket S3 ?','hard','SINGLE_CHOICE','Plusieurs couches de sécurité pour S3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Bucket policies, ACLs, IAM, chiffrement',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Bucket policies seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','IAM seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','ACLs seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-269') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-269',v_cert_id,v_theme_id,'Qu''est-ce que S3 Block Public Access ?','hard','SINGLE_CHOICE','Block Public Access désactive les politiques et ACLs publiques.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Empêche les accès publics au niveau bucket/account',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Bloque les accès privés',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Supprime les politiques publiques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-270') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='s3_storage' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-270',v_cert_id,v_theme_id,'Qu''est-ce que S3 Access Analyzer ?','hard','SINGLE_CHOICE','Access Analyzer détecte les politiques qui permettent des accès publics ou croisés.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Analyse les politiques pour accès non intentionnels',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Analyse les performances',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Analyse les coûts',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Analyse les logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-271') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-271',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS CodeCommit ?','easy','SINGLE_CHOICE','CodeCommit est un service de dépôt Git privé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Service de dépôt Git managé',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de build',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service de déploiement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service de pipeline',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-272') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-272',v_cert_id,v_theme_id,'CodeCommit supporte-t-il HTTPS et SSH ?','easy','SINGLE_CHOICE','CodeCommit supporte les deux protocoles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HTTPS seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','SSH seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-273') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-273',v_cert_id,v_theme_id,'Comment se connecter à CodeCommit ?','medium','SINGLE_CHOICE','Plusieurs méthodes d''authentification sont supportées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','IAM user avec git-credentials',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','IAM role',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','HTTPS avec nom d''utilisateur/mot de passe',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-274') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-274',v_cert_id,v_theme_id,'Quelle est la taille maximale d''un dépôt CodeCommit ?','hard','SINGLE_CHOICE','La taille maximale d''un dépôt est 100 Go.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','100 Go',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','50 Go',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','25 Go',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','200 Go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-275') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-275',v_cert_id,v_theme_id,'CodeCommit peut-il déclencher des notifications sur les événements Git ?','hard','SINGLE_CHOICE','CodeCommit peut envoyer des notifications à SNS, Lambda, EventBridge.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (SNS, Lambda)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement CloudWatch',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement EventBridge',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-276') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-276',v_cert_id,v_theme_id,'CodeCommit supporte-t-il les pull requests ?','hard','SINGLE_CHOICE','CodeCommit a des fonctionnalités de pull request.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement dans la console',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement via CLI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-277') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-277',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS CodeBuild ?','easy','SINGLE_CHOICE','CodeBuild compile le code et exécute les tests.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Service de build entièrement managé',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de dépôt',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service de déploiement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service de pipeline',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-278') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-278',v_cert_id,v_theme_id,'Où est défini la spécification de build CodeBuild ?','easy','SINGLE_CHOICE','buildspec.yml est le fichier de configuration par défaut.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','buildspec.yml',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','codebuild.yml',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','build.yml',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','codebuild.yaml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-279') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-279',v_cert_id,v_theme_id,'Quelles phases de build sont supportées ?','medium','SINGLE_CHOICE','Les phases install, pre_build, build, post_build sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','install, pre_build, build, post_build',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','build seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','pre_build, build',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','install, build',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-280') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-280',v_cert_id,v_theme_id,'CodeBuild peut-il utiliser des images Docker personnalisées ?','hard','SINGLE_CHOICE','CodeBuild supporte les images personnalisées (ECR ou Docker Hub).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement les images AWS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement les images publiques',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-281') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-281',v_cert_id,v_theme_id,'Quelle est la limite de mémoire pour CodeBuild ?','hard','SINGLE_CHOICE','La mémoire maximale est 8 Go (configurable).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8 Go',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','4 Go',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','16 Go',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','32 Go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-282') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-282',v_cert_id,v_theme_id,'Quelle est la durée maximale d''un build ?','hard','SINGLE_CHOICE','La durée maximale de build est 8 heures (480 minutes).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','8 heures',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','1 heure',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','4 heures',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','12 heures',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-283') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-283',v_cert_id,v_theme_id,'CodeBuild peut-il produire des artefacts ?','hard','SINGLE_CHOICE','Les artefacts de build peuvent être stockés dans S3.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (S3)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement local',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement CodeDeploy',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-284') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-284',v_cert_id,v_theme_id,'CodeBuild supporte-t-il les caches ?','hard','SINGLE_CHOICE','Le cache S3 accélère les builds en réutilisant les dépendances.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (S3)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement local',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement Docker',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-285') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-285',v_cert_id,v_theme_id,'CodeBuild peut-il exécuter des builds dans un VPC ?','hard','SINGLE_CHOICE','CodeBuild peut accéder à des ressources dans un VPC.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec NAT',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec PrivateLink',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-286') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-286',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS CodeDeploy ?','easy','SINGLE_CHOICE','CodeDeploy automatise les déploiements sur EC2, on-premise, Lambda, ECS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Service de déploiement automatisé',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de build',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service de dépôt',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service de pipeline',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-287') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-287',v_cert_id,v_theme_id,'Quels sont les types de déploiement CodeDeploy ?','easy','SINGLE_CHOICE','In-place (mise à jour des instances existantes) et Blue/Green (swap de groupes).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','In-place et Blue/Green',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Rolling seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','All-at-once seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Canary seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-288') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-288',v_cert_id,v_theme_id,'Où est défini la configuration de déploiement CodeDeploy ?','medium','SINGLE_CHOICE','appspec.yml est le fichier de configuration CodeDeploy.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','appspec.yml',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','codedeploy.yml',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','deployment.yml',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','deploy.yml',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-289') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-289',v_cert_id,v_theme_id,'Quels hooks sont supportés dans appspec.yml ?','hard','SINGLE_CHOICE','Plusieurs hooks permettent de personnaliser le déploiement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','ApplicationStop, DownloadBundle, BeforeInstall, AfterInstall, ApplicationStart, ValidateService',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Seulement BeforeInstall',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement AfterInstall',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement ApplicationStart',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-290') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-290',v_cert_id,v_theme_id,'Qu''est-ce que le déploiement Blue/Green ?','hard','SINGLE_CHOICE','Blue/Green réduit les temps d''arrêt en basculant entre deux environnements.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Crée un nouvel environnement puis bascule le trafic',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Met à jour les instances en place',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Redémarre les instances',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Remplace une instance à la fois',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-291') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-291',v_cert_id,v_theme_id,'CodeDeploy peut-il être utilisé avec des instances on-premise ?','hard','SINGLE_CHOICE','CodeDeploy supporte les instances on-premise via des agents.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec EC2',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec ECS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-292') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-292',v_cert_id,v_theme_id,'CodeDeploy supporte-t-il les déploiements sur Lambda ?','hard','SINGLE_CHOICE','CodeDeploy peut faire des déploiements progressifs sur Lambda (traffic shifting).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les alias',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les versions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-293') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-293',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS CodePipeline ?','easy','SINGLE_CHOICE','CodePipeline orchestre les étapes de livraison continue.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Service de pipeline CI/CD',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de build',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service de dépôt',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service de déploiement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-294') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-294',v_cert_id,v_theme_id,'Quels sont les types d''étapes (stages) dans CodePipeline ?','medium','SINGLE_CHOICE','Plusieurs types d''étapes sont disponibles.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Source, Build, Test, Deploy, Approve',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Source, Build seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Source, Deploy seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Build, Test seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-295') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-295',v_cert_id,v_theme_id,'CodePipeline peut-il s''intégrer à des fournisseurs tiers ?','hard','SINGLE_CHOICE','CodePipeline supporte des intégrations tierces via des actions personnalisées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (GitHub, Bitbucket, Jenkins, etc.)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement AWS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement GitHub',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-296') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-296',v_cert_id,v_theme_id,'Comment ajouter une approbation manuelle dans CodePipeline ?','hard','SINGLE_CHOICE','L''étape d''approbation manuelle nécessite une validation humaine.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Étape d''approbation (Manual Approval)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Lambda custom',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','SNS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','CloudWatch',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-297') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-297',v_cert_id,v_theme_id,'CodePipeline peut-il déclencher des pipelines à partir d''événements ?','hard','SINGLE_CHOICE','CodePipeline peut être déclenché par des événements (push CodeCommit, S3, etc.).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (CloudWatch Events, EventBridge)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement via webhook',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement via cron',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-298') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-298',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS CodeStar ?','hard','SINGLE_CHOICE','CodeStar fournit des projets CI/CD prêts à l''emploi avec templates.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Plateforme de développement intégrée',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de build',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Service de déploiement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Service de dépôt',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-299') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-299',v_cert_id,v_theme_id,'Comment intégrer CloudFormation dans un pipeline CI/CD ?','hard','SINGLE_CHOICE','Plusieurs façons de déployer l''infrastructure via pipeline.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','CodePipeline action CloudFormation',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','AWS CLI',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','CDK',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-DEV-300') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='ci_cd_codesuite' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-DEV-300',v_cert_id,v_theme_id,'Qu''est-ce qu''un change set CloudFormation ?','hard','SINGLE_CHOICE','Les change sets permettent de visualiser l''impact des modifications.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Aperçu des modifications avant déploiement',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Journal des modifications',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Liste des ressources',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Rapport de déploiement',FALSE,3);
    END IF;
END $$;
