-- V6a_aws_saa_04__seed_aws_saa_part4.sql
-- aws_saa: questions 451–500
-- Idempotent via legacy_id check

-- AWS_SAA: 50 questions
DO $$
DECLARE
    v_cert_id TEXT := 'aws_saa';
    v_theme_id UUID; v_q_id UUID;
BEGIN
    IF NOT EXISTS (SELECT 1 FROM certifications WHERE id = v_cert_id) THEN
        RAISE NOTICE 'Cert % absent', v_cert_id; RETURN; END IF;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'monitoring_logging','Monitoring & Logging',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    INSERT INTO certification_themes (id,certification_id,code,label,question_count,display_order)
    VALUES (uuid_generate_v4(),v_cert_id,'pricing_support','Pricing & Support',0,0)
    ON CONFLICT (certification_id,code) DO NOTHING;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-451') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-451',v_cert_id,v_theme_id,'Comment surveiller les logs d''application ?','hard','SINGLE_CHOICE','CloudWatch Logs est la solution recommandée.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','CloudWatch Logs, CloudWatch Logs Insights, X-Ray',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','S3',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','DynamoDB',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','RDS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-452') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-452',v_cert_id,v_theme_id,'Comment surveiller les coûts ?','hard','SINGLE_CHOICE','Cost Explorer et Budgets sont dédiés à la gestion des coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','AWS Cost Explorer, Budgets, Trusted Advisor',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','CloudWatch',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','CloudTrail',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-453') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-453',v_cert_id,v_theme_id,'EventBridge peut-il répondre aux événements CloudWatch Alarms ?','hard','SINGLE_CHOICE','EventBridge peut déclencher des actions basées sur les alarmes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement aux événements AWS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement aux événements personnalisés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-454') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-454',v_cert_id,v_theme_id,'EventBridge supporte-t-il les schémas d''événements ?','hard','SINGLE_CHOICE','EventBridge Schema Registry découvre et versionne les schémas.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui (Schema Registry)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les événements AWS',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les événements personnalisés',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-455') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-455',v_cert_id,v_theme_id,'Les dashboards CloudWatch sont-ils partageables ?','hard','SINGLE_CHOICE','Les dashboards peuvent être partagés via des comptes ou publics.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec un compte pro',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec AWS Organizations',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-456') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-456',v_cert_id,v_theme_id,'Peut-on exporter un dashboard CloudWatch en JSON ?','hard','SINGLE_CHOICE','Les dashboards peuvent être exportés en JSON pour sauvegarde.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement en PNG',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement en PDF',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-457') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-457',v_cert_id,v_theme_id,'Qu''est-ce qu''AWS Distro for OpenTelemetry (ADOT) ?','hard','SINGLE_CHOICE','ADOT est la distribution AWS d''OpenTelemetry.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Distribution certifiée d''OpenTelemetry',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Service de tracing',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Logs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-458') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-458',v_cert_id,v_theme_id,'À quoi sert CloudWatch Application Signals ?','hard','SINGLE_CHOICE','Application Signals fournit une visibilité sans code sur les applications.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Monitoring des applications sans instrumentation',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Tracing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-459') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-459',v_cert_id,v_theme_id,'Qu''est-ce que CloudWatch Internet Monitor ?','hard','SINGLE_CHOICE','Internet Monitor détecte les problèmes de connectivité réseau entre les utilisateurs et AWS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Surveille la connectivité Internet vers vos applications',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Logs',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Métriques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Tracing',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-460') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='monitoring_logging' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-460',v_cert_id,v_theme_id,'Quelle est la bonne pratique pour centraliser les logs multi-comptes ?','hard','SINGLE_CHOICE','Centraliser les logs facilite l''analyse et la conformité.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Centralisation vers un compte de logging avec CloudWatch cross-account',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Logs séparés par compte',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','S3 dans chaque compte',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','CloudTrail uniquement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-461') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-461',v_cert_id,v_theme_id,'Quels sont les modèles de tarification AWS ?','easy','SINGLE_CHOICE','AWS propose plusieurs modèles pour optimiser les coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Pay-as-you-go, Reserved, Spot, Savings Plans',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Uniquement pay-as-you-go',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement Reserved',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement Spot',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-462') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-462',v_cert_id,v_theme_id,'Quel est le modèle de paiement On-Demand ?','easy','SINGLE_CHOICE','On-Demand ne nécessite aucun engagement et facture à l''usage.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Payer à l''heure ou à la seconde',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Paiement anticipé',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Engagement 1 an',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Engagement 3 ans',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-463') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-463',v_cert_id,v_theme_id,'Quelles sont les options de paiement pour Reserved Instances ?','medium','SINGLE_CHOICE','Trois options de paiement pour les RI.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','All Upfront, Partial Upfront, No Upfront',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Mensuel, Trimestriel, Annuel',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','À la demande uniquement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Pay as you go',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-464') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-464',v_cert_id,v_theme_id,'Quel est le plus grand rabais pour les RI ?','hard','SINGLE_CHOICE','All Upfront 3 ans offre le plus grand rabais (jusqu''à 75%).','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','All Upfront 3 ans',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','No Upfront 1 an',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Partial Upfront 3 ans',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','All Upfront 1 an',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-465') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-465',v_cert_id,v_theme_id,'Quel est l''inconvénient des instances Spot ?','medium','SINGLE_CHOICE','Les instances Spot peuvent être reprises par AWS avec un préavis.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Peuvent être interrompues avec préavis de 2 minutes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plus chères',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Pas de Linux',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Pas de Windows',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-466') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-466',v_cert_id,v_theme_id,'Quel est le rabais typique des instances Spot ?','hard','SINGLE_CHOICE','Les instances Spot peuvent offrir jusqu''à 90% de réduction.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Jusqu''à 90%',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Jusqu''à 50%',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Jusqu''à 30%',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Jusqu''à 10%',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-467') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-467',v_cert_id,v_theme_id,'Quel service AWS permet de gérer des pools d''instances Spot ?','hard','SINGLE_CHOICE','Plusieurs options pour gérer les instances Spot.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Spot Fleet',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','ASG avec mixed instances',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','EC2 Fleet',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-468') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-468',v_cert_id,v_theme_id,'Savings Plans s''applique-t-il à Lambda ?','hard','SINGLE_CHOICE','Savings Plans couvre EC2, Fargate et Lambda.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement à EC2',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement à Fargate',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-469') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-469',v_cert_id,v_theme_id,'Quels sont les types de Savings Plans ?','hard','SINGLE_CHOICE','Trois types de Savings Plans.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Compute Savings Plans, EC2 Instance Savings Plans, SageMaker Savings Plans',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','EC2 seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Lambda seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Fargate seulement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-470') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-470',v_cert_id,v_theme_id,'Quels services sont inclus dans le Free Tier ?','easy','SINGLE_CHOICE','Le Free Tier offre des limites sur plusieurs services.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','EC2 (750h), S3 (5GB), Lambda (1M requests), etc.',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Tous les services',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Aucun',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Seulement EC2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-471') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-471',v_cert_id,v_theme_id,'Combien de temps dure le Free Tier ?','hard','SINGLE_CHOICE','Le Free Tier dure 12 mois pour les nouveaux comptes AWS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','12 mois',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','6 mois',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','24 mois',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toujours',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-472') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-472',v_cert_id,v_theme_id,'À quoi sert AWS Pricing Calculator ?','hard','SINGLE_CHOICE','Le calculateur aide à estimer les coûts des services.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Estimer les coûts avant de déployer',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Facturer les clients',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Gérer les budgets',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Suivre les dépenses',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-473') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-473',v_cert_id,v_theme_id,'À quoi sert AWS Cost Explorer ?','hard','SINGLE_CHOICE','Cost Explorer permet d''analyser les tendances des coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Analyser les coûts passés et prévoir les futurs',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Facturer',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Payer',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-474') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-474',v_cert_id,v_theme_id,'Les budgets AWS peuvent-ils déclencher des alarmes ?','hard','SINGLE_CHOICE','Les budgets peuvent envoyer des alertes SNS.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement des notifications',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement des actions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-475') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-475',v_cert_id,v_theme_id,'À quoi sert Cost Anomaly Detection ?','hard','SINGLE_CHOICE','Cost Anomaly Detection utilise ML pour identifier les anomalies.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Détecter les pics de dépenses inhabituels',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Prévoir les coûts',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Optimiser',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-476') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-476',v_cert_id,v_theme_id,'Quels sont les plans de support AWS ?','easy','SINGLE_CHOICE','AWS propose quatre plans de support.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Basic, Developer, Business, Enterprise',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Basic seulement',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Premium seulement',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Standard, Premium',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-477') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-477',v_cert_id,v_theme_id,'Le plan Basic est-il gratuit ?','hard','SINGLE_CHOICE','Le plan Basic est inclus gratuitement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les comptes de moins d''un an',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les comptes éducatifs',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-478') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-478',v_cert_id,v_theme_id,'Quel plan supporte le Technical Account Manager (TAM) ?','hard','SINGLE_CHOICE','Le plan Enterprise inclut un TAM dédié.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Enterprise',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Business',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Developer',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Basic',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-479') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-479',v_cert_id,v_theme_id,'Quel plan offre un temps de réponse de 15 minutes pour les cas de production ?','hard','SINGLE_CHOICE','Enterprise offre une réponse critique en 15 minutes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Enterprise',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Business',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Developer',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Basic',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-480') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-480',v_cert_id,v_theme_id,'Organizations permet-il une facturation consolidée ?','hard','SINGLE_CHOICE','Organizations consolide la facturation des comptes membres.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec Control Tower',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec AWS Config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-481') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-481',v_cert_id,v_theme_id,'Organizations permet-il des réductions sur les RI partagées ?','hard','SINGLE_CHOICE','Les RI et Savings Plans sont partagés entre les comptes de l''organisation.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les Savings Plans',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les comptes master',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-482') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-482',v_cert_id,v_theme_id,'Comment réduire les coûts S3 ?','hard','SINGLE_CHOICE','Les lifecycle policies et le choix de classe de stockage réduisent les coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Lifecycle policies, classes de stockage, compression',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plus de réplication',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plus de versions',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Chiffrement',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-483') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-483',v_cert_id,v_theme_id,'Comment réduire les coûts EC2 ?','hard','SINGLE_CHOICE','Utiliser des modèles de tarification économiques et ajuster la capacité.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','RI, Savings Plans, Spot, auto-scaling',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plus d''instances',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Plus de mémoire',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Plus de CPU',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-484') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-484',v_cert_id,v_theme_id,'Qu''est-ce que le tagging pour les coûts ?','hard','SINGLE_CHOICE','Le tagging aide à analyser les coûts par projet, équipe, environnement.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Assigner des métadonnées pour attribuer les coûts',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Étiqueter les ressources',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Grouper les ressources',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Toutes ces réponses',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-485') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-485',v_cert_id,v_theme_id,'À quoi sert Trusted Advisor pour les coûts ?','hard','SINGLE_CHOICE','Trusted Advisor recommande de supprimer les ressources inutilisées.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Identifier les ressources sous-utilisées',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Augmenter les coûts',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Facturer',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Budgéter',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-486') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-486',v_cert_id,v_theme_id,'Compute Optimizer aide-t-il à réduire les coûts ?','hard','SINGLE_CHOICE','Compute Optimizer recommande des types d''instance plus adaptés.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour EC2',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour Lambda',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-487') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-487',v_cert_id,v_theme_id,'Storage Lens aide-t-il à optimiser les coûts S3 ?','hard','SINGLE_CHOICE','Storage Lens fournit des recommandations d''optimisation des coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les métriques',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour la sécurité',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-488') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-488',v_cert_id,v_theme_id,'Comment réduire les coûts RDS ?','hard','SINGLE_CHOICE','RI, instances t3, et arrêt des environnements non productifs.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','RI, instances burstable, arrêt des dev',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plus de réplicas',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Multi-AZ',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Backup',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-489') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-489',v_cert_id,v_theme_id,'Comment réduire les coûts Lambda ?','hard','SINGLE_CHOICE','Réduire la mémoire et le temps d''exécution baisse les coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Ajuster la mémoire (CPU proportionnel)',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Provisioned concurrency',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Durée d''exécution',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','A et C',TRUE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-490') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-490',v_cert_id,v_theme_id,'Le transfert de données entre services dans la même AZ est-il facturé ?','hard','SINGLE_CHOICE','Le trafic entre services dans la même AZ via IP privée est gratuit.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement pour les grands volumes',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour les régions',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-491') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-491',v_cert_id,v_theme_id,'Le transfert de données sortant d''Internet est-il facturé ?','hard','SINGLE_CHOICE','Le trafic sortant vers Internet est facturé.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Seulement au-delà d''un seuil',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement pour EC2',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-492') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-492',v_cert_id,v_theme_id,'Peut-on obtenir les prix AWS via API ?','hard','SINGLE_CHOICE','L''API AWS Price List permet d''obtenir les tarifs par programme.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement via le console',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement via le calculateur',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-493') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-493',v_cert_id,v_theme_id,'À quoi sert AWS Billing Conductor ?','hard','SINGLE_CHOICE','Billing Conductor permet de regrouper et facturer des comptes internes.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Créer des factures personnalisées pour les clients internes',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Facturer AWS',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Optimiser',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-494') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-494',v_cert_id,v_theme_id,'AWS Marketplace permet-il d''acheter des logiciels tiers ?','hard','SINGLE_CHOICE','Marketplace propose des AMI, SaaS, conteneurs, etc.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement des AMI',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement des SaaS',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-495') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-495',v_cert_id,v_theme_id,'Quel est l''avantage des Savings Plans sur les RI ?','hard','SINGLE_CHOICE','Savings Plans sont plus flexibles que les RI.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Plus de flexibilité (famille d''instances, région, services)',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Plus de réduction',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Engagement plus court',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Aucun',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-496') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-496',v_cert_id,v_theme_id,'La facturation consolidée est-elle disponible sans Organizations ?','hard','SINGLE_CHOICE','La facturation consolidée nécessite AWS Organizations.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Non',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Oui',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement avec Control Tower',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement avec AWS Config',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-497') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-497',v_cert_id,v_theme_id,'Les crédits AWS peuvent-ils être appliqués à tous les services ?','hard','SINGLE_CHOICE','Certains services (ex: Marketplace) peuvent être exclus.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Oui',FALSE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Non, certains services exclus',TRUE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement EC2',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement S3',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-498') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-498',v_cert_id,v_theme_id,'À quoi sert AWS Activate ?','hard','SINGLE_CHOICE','AWS Activate offre des crédits et du support aux startups.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Crédits et support pour startups',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Facturation',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Budgéter',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Optimisation',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-499') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-499',v_cert_id,v_theme_id,'Quelle est la meilleure pratique pour suivre les coûts ?','hard','SINGLE_CHOICE','Combiner plusieurs outils pour une visibilité complète.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Tagging, budgets, alertes, Cost Explorer',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ignorer les coûts',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Uniquement les factures',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','Uniquement les RI',FALSE,3);
    END IF;
    IF NOT EXISTS (SELECT 1 FROM questions WHERE legacy_id='AWS-SAA-500') THEN
        SELECT id INTO v_theme_id FROM certification_themes WHERE certification_id=v_cert_id AND code='pricing_support' LIMIT 1;
        v_q_id:=uuid_generate_v4();
        INSERT INTO questions(id,legacy_id,certification_id,theme_id,statement,difficulty,question_type,explanation_original,explanation_status,is_active)
        VALUES(v_q_id,'AWS-SAA-500',v_cert_id,v_theme_id,'Comment éviter les surprises de facturation ?','hard','SINGLE_CHOICE','Configurer des budgets et des alarmes pour surveiller les coûts.','PENDING',TRUE);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'A','Budgets, alertes, analyse régulière',TRUE,0);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'B','Ne pas utiliser AWS',FALSE,1);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'C','Utiliser uniquement le Free Tier',FALSE,2);
        INSERT INTO question_options(id,question_id,label,text,is_correct,display_order)VALUES(uuid_generate_v4(),v_q_id,'D','RI seulement',FALSE,3);
    END IF;
END $$;
